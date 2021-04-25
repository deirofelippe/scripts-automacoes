#!/bin/bash

# bash nome-do-script formato-converter imagem
# bash bla.sh png amazon_aws

cd ~/Documentos/alura/curso-shell-script-1/imagens-livros

for imagem in $@
do
	rm $imagem.png
	echo "$imagem.png excluido!"

	convert $imagem.jpg $imagem.png
	echo "$imagem.jpg convertido para $imagem.png"
done
