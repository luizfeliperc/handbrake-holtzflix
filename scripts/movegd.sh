#!/bin/bash
# Title:      Script de movimentação dos arquivos para a nuvem
# Authors:    Holtzmann
# URL:        http://luitech.com.br
################################################################################

if pidof -o %PPID -x "$0"; then
    exit 1
fi

hdpath="/mnt"
while true; do

    useragent="HoltzFlix"
    bwlimit="20M"
    vfs_dcs="128M"
    let "cyclecount++"

    if [[ $cyclecount -gt 4294967295 ]]; then
        cyclecount=0
    fi
        echo "" >>/mnt/logs/movegd.log
        echo "---Inicio do ciclo $cyclecount - $p: $(date "+%Y-%m-%d %H:%M:%S")---" >>/mnt/logs/movegd.log
        echo "Checando arquivos para upload..." >>/mnt/logs/movegd.log

    rsync "$hdpath/downloads/" "$hdpath/move/" \
        -aq --remove-source-files --link-dest="$hdpath/downloads/" \
        --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
        --exclude="**partial~" --exclude=".unionfs-fuse/**" \
        --exclude=".fuse_hidden**" --exclude="**.grab/**" \
        --exclude="**qbittorrent**" --exclude="**rutorrent**"


    if [[ $(find "$hdpath/move" -type f | wc -l) -gt 0 ]]; then

        rclone move "$hdpath/move/" "tdrive:/" \
            --config=/home/${USER}/.config/rclone/rclone.conf \
            --log-file=/mnt/logs/movegd.log \
            --log-level=INFO --stats=5s --stats-file-name-length=0 \
            --max-size=300G \
            --tpslimit=2 \
            --checkers=2 \
            --min-age 5m \
            --no-traverse \
            --fast-list \
            --max-transfer 750G \
            --bwlimit="$bwlimit" \
            --drive-chunk-size="$vfs_dcs" \
            --user-agent="$useragent" \
            --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
            --exclude="**partial~" --exclude=".unionfs-fuse/**" \
            --exclude="**sabnzbd**" --exclude="**nzbget**" \
            --exclude="**qbittorrent**" --exclude="**rutorrent**" \
            --exclude="**ignore**" --exclude="**inProgress**"

         echo "Upload completo." >>/mnt/logs/movegd.log

        else
        echo "Não há arquivos em $hdpath/move pra enviar pra nuvem." >>/mnt/logs/movegd.log
    fi
    echo "---Ciclo completado $cyclecount: $(date "+%Y-%m-%d %H:%M:%S")---" >>/mnt/logs/movegd.log
    echo "$(tail -n 200 /mnt/logs/movetd.log)" >/mnt/logs/movegd.log

    sleep 30

done