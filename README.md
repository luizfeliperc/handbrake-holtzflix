Este script tem como finalidade a instalação do docker, docker-compose e todos os containers básicos para funcionamento de um servidor de streaming utilizando o rclone para transporte de arquivos juntamente com o mergerFS.

# Recomendações para instalação:

- Ubuntu 16.04 & 18.04 & 20.04 LTS
- RAM: Mínimo 4GB / Recomendado 8GB
- Storage: Mínimo 200GB / Recomendado 500GB

# Informações Importantes!

Não execute o procedimento usando o root. Crie um usuário e de permissão de sudo a ele!

### Instalação
```sh
adduser seu_user
sudo usermod -aG sudo seu_user
sudo visudo
Adicione no final do arquivo o seguinte: seu_user ALL=(ALL) NOPASSWD: ALL

sudo apt-get update && sudo apt upgrade -y
sudo apt-get install git -y
sudo rm -rf /opt/holtzflix-v2 && sudo git clone https://github.com/luizfeliperc/holtzflix-v2.git /opt/holtzflix-v2
cd /opt/holtzflix-v2 && bash install.sh
```