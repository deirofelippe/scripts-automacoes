#!/bin/sh

if [ ! -f "$1.asm" ]
then
   echo "Arquivo '$1.asm' não existe."
   exit 1
fi

nasm -f elf64 -o $1.o $1.asm &&
ld $1.o -o $1

if [ $? -eq 0 ]
then  
   echo "Compilação bem sucedida"
   exit 0
fi
