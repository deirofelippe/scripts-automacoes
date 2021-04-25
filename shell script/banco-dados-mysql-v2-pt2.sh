#!/bin/bash

caminho_alura=/home/boibandido/Documentos/alura/curso-shell-script-2
caminho_restore=/home/boibandido/Documentos/alura/curso-shell-script-2/restore_mutillidae_amazon

cd $caminho_alura

if [ ! -d restore_mutillidae_amazon ]
then
	mkdir restore_mutillidae_amazon
fi

aws s3 sync s3://curso-shell-script-felippe/$(date +%F) $caminho_restore

cd restore_mutillidae_amazon

if [ -f $1.sql ]
then
	mysql -u root mutillidae < $1.sql
	if [ $? -eq 0 ]
	then
		echo "O restore foi realizado com sucesso."
	fi
else
	echo "O arquivo procurado não existe no diretório."
fi



