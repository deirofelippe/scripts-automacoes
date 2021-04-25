#!/bin/bash
#usa o ssmtp e mailutils (comando 'mail')
#pode colocar no crontab e executar esse codigo de tempos em tempos
#crontab -e

memoria_total=$(free | grep -i mem | awk '{ print $2 }')
echo $memoria_total
memoria_consumida=$(free | grep -i mem | awk '{ print $3 }')
echo $memoria_consumida
relacao_memoria_atual_total=$(echo "scale=2; $memoria_consumida/$memoria_total * 100" | bc | awk -F. '{ print $1 }')
echo $relacao_memoria_atual_total

if [ $relacao_memoria_atual_total -gt 50 ]
then
mail -s "Consumo de memória acima do limite" sergiofelippe.teste@gmail.com<<del
O consumo de memória está acima do limite que foi especificado.
Atualmente o consumo é de $(free -h --si | grep -i mem | awk '{ print $3 }').
del

fi