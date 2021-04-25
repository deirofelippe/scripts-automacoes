#!/bin/bash

 # ffmpeg -i ~/cinnamon-20201220-5.webm -s 1024x640 ~/Downloads/conversor.mp4 

converter_imagem(){
   for imagem in *.jpg
   do
      # awk    separa o texto em 2 a partir do . e imprime o primeiro valor
      # $()    resultado do comando é armazenado na variavel e n o comando
      # local  n da p acessar a variavel fora do escopo
      local imagem_sem_extensao=$(ls $imagem | awk -F. '{ print $1 }')

      if [ -n "$imagem_sem_extensao" ]
      then
         echo "Convertendo $imagem_sem_extensao.jpg para $imagem_sem_extensao.png"
      fi

      convert $imagem_sem_extensao.jpg png/$imagem_sem_extensao.png
   done
}

caminho=~/Documentos/alura/curso-shell-script-1/imagens-livros
cd $caminho

if [ ! -d png ]
then
   mkdir png
   echo "Diretório 'png/' criado!"
else 
   diretorio_vazio=$(ls png/ | wc -l)
   
   if [ ! $diretorio_vazio -eq 0 ]
   then
      rm png/*.png
      echo "Imagens .png excluidas!"
   else
      echo "Diretório vazio!"
   fi
fi

#fluxo de entrada 0, fluxo de saida 1, fluxo de erros 2
#o fluxo de erros sera redirecionada p um arquivo
converter_imagem 2>erros_conversao.txt

# $?    pega o status de saida do comando anterior e ve se deu td certo, varia de 0 a 255
if [ $? -eq 0 ]
then
   echo "Imagens foram convertidas!"
else
   echo "Houve uma falha no processo."
fi





# rm -r png
# rm *.txt
# ls | wc -l
# ls png | wc -l