#!/bin/bash

if [ -a /usr/bin/sicoobnet.sh ] && [ -d $HOME/.wine/drive_c/Sicoobnet ]; then
		sudo rm -rf /usr/bin/sicoobnet.sh $HOME/.wine/drive_c/Sicoobnet
		
		if [ -a $HOME/Desktop/Sicoobnet.desktop ];
		then
				rm $HOME/Desktop/Sicoobnet.desktop
		elif [ -a $HOME/Área\ de\ Trabalho/Sicoobnet.desktop ];
		then
				$HOME/Área\ de\ Trabalho/Sicoobnet.desktop
		fi
		echo -e "\033[01mSicoobnet removido\033[01m"
fi
