#!/bin/bash

# Atualizar pacotes e instalar dependências
sudo apt update -y
sudo apt install apache2 unzip -y

# Habilitar e iniciar o serviço do Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Baixar a aplicação do GitHub
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

# Descompactar a aplicação
unzip main.zip

# Copiar os arquivos para o diretório padrão do Apache
sudo cp -r linux-site-dio-main/* /var/www/html/

# Ajustar permissões
sudo chmod -R 755 /var/www/html/

# Abrir a porta 80 no firewall (caso esteja ativo)
sudo ufw allow 80/tcp
sudo ufw reload

# Mensagem de conclusão
echo "Instalação do Apache e configuração da aplicação concluídas. Acesse o servidor pelo navegador!"
