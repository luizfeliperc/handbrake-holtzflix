# handbrake-holtzflix

Este script tem como finalidade a instalação do Handbrake para conversão automática de arquivos em nuvem. 

# Recomendações para instalação:

- Ubuntu 18.04 & 20.04 LTS
- RAM: Mínimo 2GB / Recomendado 8GB
- Processador de preferencia com 4 núcleos ou maior.
- Storage: Mínimo 200GB / Recomendado 500GB

# Informações Importantes!

Não execute o procedimento usando o root. Crie um usuário e de permissão de sudo a ele!

# Passos a seguir antes da primeira conversão:

- Criar as seguintes pastas em seu Drive ou Drive de equipe: Handbrake/output e Handbrake/watch
- Dentro do Handbrake, no meu suspenso você deve clicar em Presets / Imports. Após isto, navegar até a pasta storage e selecionar o preset já disponivel. 
- Após fazer isto, clique novamente em Set Defalt e ele ficará salvo para as próximas conversões manual.
- Para a conversão automática, que é o foco do script, vc deve clicar em Save As, selecionar a categoria General e salvar com o seguinte nome: mkv-1080p, selecione Defalt Preset e clique em OK.




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

# Informações sobre o sistema
Após a instalação, os serviços ficarão disponiveis nos endereços abaixo.
- Handbrake: http://localhost:5888
- Monitor: http://localhost:8555

