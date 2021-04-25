#!/bin/bash

#importar backup
#sudo mysql -u root registrador_de_processo_judicial < $caminho_backup/$1.sql

caminho_alura=/home/boibandido/Documentos/alura/curso-shell-script-2
caminho_backup=/home/boibandido/Documentos/alura/curso-shell-script-2/backup

cd $caminho_alura

if [ ! -d backup ]
then
	mkdir backup
fi

mysqldump -u root $1 > $caminho_backup/$1.sql

if [ $? -eq 0 ]
then
	echo "Backup foi realizado com sucesso."
else
	echo "Houve um problema ao fazer backup."
fi

