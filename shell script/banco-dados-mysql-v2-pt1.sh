#!/bin/bash

caminho_alura=/home/boibandido/Documentos/alura/curso-shell-script-2
caminho_backup=/home/boibandido/Documentos/alura/curso-shell-script-2/backup_mutillidae_amazon

cd $caminho_alura

if [ ! -d backup_mutillidae_amazon ]
then
	mkdir backup_mutillidae_amazon
fi

data=$(date +$F)
if [ ! -d $data]
then
	mkdir $data
fi

tabelas=$(sudo mysql -u root mutillidae -e "show tables;" | grep -v Tables)

for tabela in $tabelas
do
	mysqldump -u root mutillidae $tabela > $caminho_backup/$data/$tabela.sql
done


#aws s3api create-bucket --bucket curso-shell-script-felippe --create-bucket-configuration LocationConstraint=sa-east-1
aws s3 sync $caminho_backup s3://curso-shell-script-felippe
