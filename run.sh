#!/bin/bash
if [ -a /usr/bin/wine ];
then
  if [ -a $HOME/.wine/drive_c/Sicoobnet/office.exe ];
  then
    wine $HOME/.wine/drive_c/Sicoobnet/office.exe
  else
    echo -e "O programa \033[01mSicoobnet\033[00m não está instalado ou possui algum error."
  fi
else
  echo -e "O \033[01mWine\033[00m não foi encontrado. Tente reinstala-lo."
fi