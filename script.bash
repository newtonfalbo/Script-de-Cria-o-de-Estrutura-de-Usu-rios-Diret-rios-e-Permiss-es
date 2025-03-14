#!/bin/bash

# Definição dos grupos e usuários
GRUPOS=(GRP_ADM GRP_VEN GRP_SEC)
USUARIOS_ADM=(carlos maria joao)
USUARIOS_VEN=(debora sebastiana roberto)
USUARIOS_SEC=(josefina amanda rogerio)
DIR_BASE=/empresa

# Removendo usuários, grupos e diretórios previamente criados
for USER in ${USUARIOS_ADM[@]} ${USUARIOS_VEN[@]} ${USUARIOS_SEC[@]}; do
    userdel -r -f $USER 2>/dev/null
    echo "Usuário $USER removido."
done

for GRUPO in ${GRUPOS[@]}; do
    groupdel $GRUPO 2>/dev/null
    echo "Grupo $GRUPO removido."
done

rm -rf $DIR_BASE 2>/dev/null
mkdir $DIR_BASE
chmod 755 $DIR_BASE

echo "Diretório base recriado em $DIR_BASE."

# Criando os grupos
for GRUPO in ${GRUPOS[@]}; do
    groupadd $GRUPO
    echo "Grupo $GRUPO criado."
done

# Criando os diretórios e configurando permissões
for GRUPO in ${GRUPOS[@]}; do
    mkdir $DIR_BASE/$GRUPO
    chown root:$GRUPO $DIR_BASE/$GRUPO
    chmod 770 $DIR_BASE/$GRUPO
    echo "Diretório $DIR_BASE/$GRUPO criado e permissões ajustadas."
done

# Criando usuários e adicionando aos grupos
for USER in ${USUARIOS_ADM[@]}; do
    useradd $USER -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
    echo "Usuário $USER criado e adicionado ao GRP_ADM."
done

for USER in ${USUARIOS_VEN[@]}; do
    useradd $USER -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
    echo "Usuário $USER criado e adicionado ao GRP_VEN."
done

for USER in ${USUARIOS_SEC[@]}; do
    useradd $USER -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC
    echo "Usuário $USER criado e adicionado ao GRP_SEC."
done

echo "Provisionamento concluído com sucesso!"
