#!/bin/bash

caminho_raiz=~/Documentos/alura/curso-shell-script-1/log

if [ ! -d $caminho_raiz ]
then
   mkdir log
fi

salvar_log_processos(){
   processos=$(ps -e -o pid --sort -size | head -n 11 | grep '[0-9]')
   for pid in $processos
   do
      nome_processo=$(ps -p $pid -o comm=)
      caminho_processo=$caminho_raiz/$nome_processo.log

      echo -n $(date +%F,\ %H:%M:%S,) >> "$caminho_processo"
      tamanho_processo=$(ps -p $pid -o size | grep '[0-9]')
      echo -n $(bc <<< "scale=2;$tamanho_processo/1024") >> "$caminho_processo"
      echo " MB" >> "$caminho_processo"

      echo "Log do processo '$nome_processo' foi salvo!"
   done
}

salvar_log_processos

if [ $? -eq 0 ]
then
   echo "Log dos processos foram salvos!"
else
   echo "Houve um problema em salvar o log."
fi