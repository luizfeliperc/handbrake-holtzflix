#!/bin/bash
# Title:      Script de movimentação dos arquivos para a nuvem
# Authors:    Holtzmann
# URL:        http://luitech.com.br
################################################################################

source /opt/move/cloneclean.sh

if pidof -o %PPID -x "$0"; then
    exit 1
fi

hdpath="/mnt"
while true; do

    useragent="Handbrake"
    bwlimit="20M"
    vfs_dcs="128M"
    let "cyclecount++"

    if [[ $cyclecount -gt 4294967295 ]]; then
        cyclecount=0
    fi
        echo "" >>/mnt/logs/movegd.log
        echo "---Inicio do ciclo $cyclecount - $p: $(date "+%Y-%m-%d %H:%M:%S")---" >>/mnt/logs/movegd.log
        echo "Checando arquivos para upload..." >>/mnt/logs/movegd.log

    rsync "$hdpath/Handbrake/" "$hdpath/move/" \
        -aq --remove-source-files --link-dest="$hdpath/Handbrake/" \
        --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
        --exclude="**partial~" --exclude=".unionfs-fuse/**" \
        --exclude=".fuse_hidden**" --exclude="**.grab/**" --exclude="\.**" \
        --exclude="**qbittorrent**" --exclude="**rutorrent**"


    if [[ $(find "$hdpath/move" -type f | wc -l) -gt 0 ]]; then

        rclone move "$hdpath/move" "tdrive:/Handbrake/" \
            --config=/home/${USER}/.config/rclone/rclone.conf \
            --log-file=/mnt/logs/movegd.log \
            --log-level=INFO --stats=5s --stats-file-name-length=0 \
            --max-size=300G \
            --tpslimit=2 \
            --checkers=2 \
            --min-age 1m \
            --min-size 1K \
            --delete-empty-src-dirs \
            --no-traverse \
            --fast-list \
            --max-transfer 750G \
            --bwlimit="$bwlimit" \
            --drive-chunk-size="$vfs_dcs" \
            --user-agent="$useragent" \
            --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
            --exclude="**partial~" --exclude=".unionfs-fuse/**" \
            --exclude="**sabnzbd**" --exclude="**nzbget**" \
            --exclude="**qbittorrent**" --exclude="**rutorrent**" --exclude="\.**" \
            --exclude="**ignore**" --exclude="**inProgress**"

         echo "Upload completo." >>/mnt/logs/movegd.log

        else
        echo "Não há arquivos em $hdpath/move pra enviar pra nuvem." >>/mnt/logs/movegd.log
    fi
    echo "---Ciclo completado $cyclecount: $(date "+%Y-%m-%d %H:%M:%S")---" >>/mnt/logs/movegd.log
    echo "$(tail -n 200 /mnt/logs/movegd.log)" >/mnt/logs/movegd.log

    sleep 30
    cloneclean
done