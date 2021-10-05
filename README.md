Este script tem como finalidade a instalação do docker, docker-compose juntamente com o mergerFS para a utilização do Handbrake para conversão de arquivos com envio automatico para a nuvem.

# Recomendações para instalação:

- Ubuntu 16.04 & 18.04 & 20.04 LTS
- RAM: Mínimo 2GB / Recomendado 8GB
- Processador de preferencia com 4 núcleos ou maior.
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
sudo rm -rf /opt/handbrake-holtzflix && sudo git clone https://github.com/luizfeliperc/handbrake-holtzflix.git /opt/handbrake-holtzflix
cd /opt/handbrake-holtzflix && bash install.sh
```
