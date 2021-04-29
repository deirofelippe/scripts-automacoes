#!/bin/sh

pedir_url(){
   local indice=0
   while true; do
      echo -n "Digite a url do vídeo (fim - finalizar): "
      read url

      if [ $url = "fim" ]; then
         break
      fi

      urls[$indice]=$url

      ((indice=indice+1))
   done

   echo -n "Qual o formato? (webm ou mp4): "
   read formato
}

escolher_formato(){
   url=$1
   
   while true; do
      echo "URL digitada: $url"

      echo "Buscando formatos do vídeo...\n"
      
      # pytube $url --list

      # echo -n "Escolha o formato (1 - 720p, 2 - 1080p): "
      # read formato

      # case $formato in
      # 1)
      #    formato="247"
      #    ;;

      # 2)
      #    formato="248"
      #    ;;
      # esac
   
      case $formato in
      webm)
         formato="247"
         ;;

      mp4)
         formato="136"
         ;;
      esac
      
      pytube $url --itag=$formato

      if [ $? -eq 0 ]; then
         break
      fi

      echo "Erro ao escolher o formato, escolha novamente"
   done
}

while true; do

   pedir_url

   if [ ${#urls[@]} -eq 0 ]; then
      echo "Nenhuma url foi informada"
      exit 1
   fi

   for url in ${urls[@]}; do
      escolher_formato $url
   done

   
   echo -n "\nDeseja finalizar (y/n)? "
   read finalizar
   
   if [ $finalizar = "y" ]; then
      break
   fi

   echo -n "Limpar tela (y/n)? "
   read limpar
   
   if [ $limpar = "y" ]; then
      clear
   fi
done
