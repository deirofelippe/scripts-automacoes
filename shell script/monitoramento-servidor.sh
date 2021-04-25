#!/bin/bash
#usa o crontab para executar esse script a cada 1 minutos
#execute 'sudo crontab -e' para editar o arquivo
#usa o ssmtp, mailutils, 
#execute 'sudo gedit /etc/ssmtp/ssmtp.conf' para colocar os dados do usuario q envia o email

resposta_http=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost)
echo $resposta_http
if [ $resposta_http -ne 200 ]
then
mail -s "Problema no servidor" seergiio.felippe@gmail.com<<delimitador
	Houve um problema no servidor apache
delimitador
echo "email enviado"

systemctl restart apache2		
echo "servidor reiniciado"
fi
