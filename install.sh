#!/bin/bash
# Script para instalação dos containers básicos para Streaming com utilização do Rclone com cache VFS FULL

echo "Atualizando pacotes"
sudo apt update -y && sudo apt dist-upgrade -y
echo
sleep 5

echo "Instalando programas necessários"
echo
sudo apt-get install htop bmon screenfetch zsh curl git tmux screen zip unzip curl unionfs-fuse fuse nano -y
echo
sleep 5

echo "Configurando o Time Zone e idioma!"
echo
sudo dpkg-reconfigure tzdata && sudo dpkg-reconfigure locales
echo
sleep 5

echo "Instalando o RCLONE"
echo
curl https://rclone.org/install.sh | sudo bash
echo
sleep 5

echo "ATENÇÃO - Configure seu rclone com os nomes dos drivers de gdrive para Drive e tdrive Drive de Equipes"
echo
rclone config
sudo chown -R 1000:1000 ~/.config
echo
sleep 5

echo "Instalando o MergerFS"
read -p ">>> Qual versão do SO você está usando, 18.04 ou 20.04? (18/20)" RESP
if [ "$RESP" = "18" ]; then
echo "Instalando MERGERFS (Ubuntu 18)"
sudo wget https://github.com/trapexit/mergerfs/releases/download/2.32.6/mergerfs_2.32.6.ubuntu-bionic_amd64.deb
sudo dpkg -i mergerfs*.deb
else 
echo "Instalando MERGERFS (Ubuntu 20)"
sudo wget https://github.com/trapexit/mergerfs/releases/download/2.32.6/mergerfs_2.32.6.ubuntu-focal_amd64.deb
sudo dpkg -i mergerfs*.deb
echo
sleep 5
fi

echo "Instalando o Docker"
echo
sudo curl -fsSl https://get.docker.com | bash
sudo usermod -aG docker ${USER}
echo
sleep 5

echo "Instalando o Docker Compose"
echo
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo
sleep 5

echo "Copiando o arquivo docker-compose"
echo
cp docker-compose.yml /home/${USER}
echo
sleep 5

echo "criando as pastas do rclone"
echo
sleep 3
read -p ">>> Você vai usar gdrive? (y/n)" RESP
if [ "$RESP" = "y" ]; then
sudo mkdir -p /mnt/cache /mnt/gdrive /mnt/logs /mnt/unionfs /mnt/move /mnt/ui /mnt/ /mnt/Handbrake/output /mnt/hb/storage
sudo chown -R 1000:1000 /mnt/cache
sudo chown -R 1000:1000 /mnt/gdrive
sudo chown -R 1000:1000 /mnt/logs
sudo chown -R 1000:1000 /mnt/unionfs
sudo chown -R 1000:1000 /mnt/move
sudo chown -R 1000:1000 /mnt/ui
sudo chown -R 1000:1000 /mnt/hb
sudo chown -R 1000:1000 /mnt/Handbrake

else
sudo mkdir /mnt/cache /mnt/tdrive /mnt/logs /mnt/unionfs /mnt/move /mnt/ui /mnt/Handbrake/output /mnt/hb/storage
sudo chown -R 1000:1000 /mnt/cache
sudo chown -R 1000:1000 /mnt/tdrive
sudo chown -R 1000:1000 /mnt/logs
sudo chown -R 1000:1000 /mnt/unionfs
sudo chown -R 1000:1000 /mnt/move
sudo chown -R 1000:1000 /mnt/ui
sudo chown -R 1000:1000 /mnt/hb
sudo chown -R 1000:1000 /mnt/Handbrake
echo
sleep 5
fi

echo "Copiando os serviços"
echo
sleep 3
read -p ">>> Você vai usar gdrive? (y/n)" RESP
if [ "$RESP" = "y" ]; then
sudo cp /opt/handbrake-holtzflix/services/gdrive.service /etc/systemd/system/
sudo cp /opt/handbrake-holtzflix/services/mergerfsgd.service /etc/systemd/system/
sudo cp /opt/handbrake-holtzflix/services/movegd.service /etc/systemd/system/
else 
sudo cp /opt/handbrake-holtzflix/services/tdrive.service /etc/systemd/system/
sudo cp /opt/handbrake-holtzflix/services/mergerfstd.service /etc/systemd/system/
sudo cp /opt/handbrake-holtzflix/services/movetd.service /etc/systemd/system/
echo
sleep 5
fi

echo "ATENÇÃO - Tire o comentário da linha allow_other do fuse.conf"
echo
sleep 10
echo
sudo nano /etc/fuse.conf
echo
sleep 5

echo "Criando a pasta Move"
echo
sudo rm -rf /opt/move
sudo mkdir /opt/move
sudo chown -R 1000:1000 /opt/move
echo
sleep 5

echo "Copiando os arquivos da UI"
echo
sudo cp /opt/handbrake-holtzflix/ui/index.php /mnt/ui/
echo
sleep 5

echo "Copiando os scritps de movimentação dos arquivos."
echo
read -p ">>> Você vai usar gdrive? (y/n)" RESP
if [ "$RESP" = "y" ]; then
sudo cp /opt/handbrake-holtzflix/scripts/movegd.sh /opt/move/
sudo chmod +x /opt/move/movegd.sh
else
sudo cp /opt/handbrake-holtzflix/scripts/movetd.sh /opt/move/
sudo chmod +x /opt/move/movetd.sh
echo
sleep 1
fi

echo "Habilitando os Serviços"
echo
sleep 3
read -p ">>> Você vai usar gdrive? (y/n)" RESP
if [ "$RESP" = "y" ]; then
sudo systemctl enable gdrive.service
sudo systemctl enable mergerfsgd.service
sudo systemctl enable movegd.service   
sudo systemctl daemon-reload
sudo systemctl start gdrive.service
sudo systemctl start mergerfsgd.service
sudo systemctl start movegd.service 
else
sudo systemctl enable tdrive.service
sudo systemctl enable mergerfstd.service
sudo systemctl enable movetd.service  
sudo systemctl daemon-reload
sudo systemctl start tdrive.service
sudo systemctl start mergerfstd.service
sudo systemctl start movetd.service
echo
sleep 5
fi

echo "Subindo os containers"
echo
cd /home/${USER}
 sudo docker-compose up -d
echo
sleep 5

echo "Criando a pasta de backup"
echo
sudo rm -rf /opt/bkp
sudo mkdir /opt/bkp
sudo chown -R 1000:1000 /opt/bkp
sudo chown -R 1000:1000 /mnt/incomplete
echo
sleep 5

echo "Copiando os arquivos de backup para o cronjob."
echo
read -p ">>> Você vai usar gdrive? (y/n)" RESP
if [ "$RESP" = "y" ]; then
sudo cp /opt/handbrake-holtzflix/scripts/backup-gdrive.sh /opt/bkp/
sudo chmod +x /opt/bkp/backup-gdrive.sh
sudo cp /opt/handbrake-holtzflix/scripts/bkp-gdrive /etc/cron.d/
else
sudo cp /opt/handbrake-holtzflix/scripts/backup-tdrive.sh /opt/bkp/
sudo chmod +x /opt/bkp/backup-tdrive.sh
sudo cp /opt/handbrake-holtzflix/scripts/bkp-tdrive /etc/cron.d/
echo
sleep 1
fi

echo "Sucesso na cópia, backup configurado"
echo
sleep 5

echo "Reiniciando os containers"
echo
cd ~/
sudo docker-compose restart
echo
sleep 5
echo "Instalação Completa. Reinicie o computador para aplicar todas as configurações"
exit
