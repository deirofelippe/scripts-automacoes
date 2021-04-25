#!/bin/bash

caminho_raiz=~/Documentos/alura/curso-shell-script-1/imagens-novos-livros

converter_imagem(){
   local caminho_imagem=$1
   local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }')
   convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png 

   if [ $? -eq 0 ]
   then
      echo "Conversão para png feita!"
   else
      echo "Erro na conversão!"
   fi
}

varrer_diretorio(){
   cd $1
   for arquivo in *
   do
      local caminho_arquivo=$(find $caminho_raiz -name $arquivo)

      if [ -d $caminho_arquivo ]
      then
         varrer_diretorio $caminho_arquivo
      else
         extensao=$(find $caminho_arquivo | awk -F. '{ print $2 }')

         if [ $extensao = 'jpg' ]
         then
            converter_imagem $caminho_arquivo
         fi
      fi
   done
}

varrer_diretorio $caminho_raiz 2>$caminho_raiz/erros_conversao_novos_livros.txt

if [ $? -eq 0 ]
then
   echo "Conversão realizada com sucesso!"
else
   echo "Houve uma falha no processo."
fi




