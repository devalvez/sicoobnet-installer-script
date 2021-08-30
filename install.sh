#!/bin/bash

echo -e "\n       \033[01mSICOOBNET EMPRESARIAL\033[00m"
echo "------------------------------------"
echo -e "\nVerificando distribuição..."
hostnamectl
basearch=('arch')
basedebian=('Mint' 'Debian' 'debian' 'Ubuntu', 'ubuntu')

parsebasearch() {
  sudo pacman -Sy
  sudo pacman -S wine wine-gecko wine-mono
}

parsebasedebian() {

  if hostnamectl | grep "Mint" || hostnamectl | grep "Ubuntu";
  then
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key

    if hostnamectl | grep "Ubuntu 21.04"; then
      sudo add-apt-repository deb 'https://dl.winehq.org/wine-builds/ubuntu/ hirsute main'
    elif hostnamectl | grep "Ubuntu 20.10";
      sudo add-apt-repository deb 'https://dl.winehq.org/wine-builds/ubuntu/ groovy main'
    elif hostnamectl | grep "Ubuntu 20.04" || hostnamectl | "Linux Mint 20"; then
      sudo add-apt-repository deb 'https://dl.winehq.org/wine-builds/ubuntu/ focal main'
    elif hostnamectl | grep "Ubuntu 18.04" || hostnamectl | "Linux Mint 19"; then
      sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
    fi
  fi
  
  sudo apt-get update -y
  sudo apt install --install-recommends winehq-stable

}

checkWineInstallation() {
  echo -e "Buscando \033[01mWine...\033[00m"
  if [ -a /usr/bin/wine ]; then
    true
  else
    false
  fi
}

checkSicoobnetInstallExists() {
  if [ -e $HOME/sicoobnet-installer/instalador-sicoobnet-windows-amd64.exe ];
  then
    true
  else
    false
  fi
}

downloadSicoobnetInstall() {
  mkdir $HOME/sicoobnet-installer
	wget -c -P $HOME/sicoobnet-installer https://office-sicoob-instalador.s3-us-west-2.amazonaws.com/instalador-sicoobnet-windows-amd64.exe
}

checkSicoobnetInstallation() {
  if [ -e $HOME/.wine/drive_c/Sicoobnet/office.exe ];
  then
    true
  else
    false
  fi
}


createShortcute() {
  shortcute="[Desktop Entry]\nVersion=1.0\nName=SicoobNet\nGenericName=Gerenciador Financeiro SicoobNet\nGenericName[fil]=Gerenciador Financeiro SicoobNet\nComment=Gerenciador Financeiro SicoobNet\nExec=/usr/bin/sicoobnet.sh\nTerminal=false\nIcon=$HOME/.wine/drive_c/Sicoobnet/SicoobEmp001.ico\nType=Application\nCategories=restart;Finance;"
  if checkSicoobnetInstallation;
  then

    sudo cp run.sh /usr/bin/sicoobnet.sh

    if [ -d $HOME/Desktop ]; then
      echo -e $shortcute >> $HOME/Desktop/Sicoobnet.desktop
    fi

    if [ -d $HOME/Área\ de\ Trabalho ]; then
      echo -e $shortcute >> $HOME/Área\ de\ Trabalho/Sicoobnet.desktop
    fi

  fi
}

runSicoobnetInstaller() {
  wine $HOME/sicoobnet-installer/instalador-sicoobnet-windows-amd64.exe

  if checkSicoobnetInstallation;
  then
    createShortcute
  fi
}

if hostnamectl | grep $basearch;
then
  if checkWineInstallation; then
    wine --version
    echo -e "Wine encontrado...ok!"
    if checkSicoobnetInstallExists;
    then
      if ! checkSicoobnetInstallation; then
        runSicoobnetInstaller
      else
        echo -e "\nO \033[01mSicoobnet\033[00m já está instalado.\n"
      fi
    else
      downloadSicoobnetInstall
      if checkSicoobnetInstallExists;
      then
        runSicoobnetInstaller
      fi
    fi
  else
    echo -e "Iniciando a instalação do \033[01mWine\033[00m..."
    parsebasearch
  fi
fi

if hostnamectl | grep $basedebian;
then
  if checkWineInstallation; then
    wine --version
    echo -e "Wine encontrado...ok!"
    if checkSicoobnetInstallExists;
    then
      if ! checkSicoobnetInstallation; then
        runSicoobnetInstaller
      else
        echo -e "\nO \033[01mSicoobnet\033[00m já está instalado.\n"
      fi
    else
      downloadSicoobnetInstall
      if checkSicoobnetInstallExists;
      then
        runSicoobnetInstaller
      fi
    fi
  else
    echo -e "Iniciando a instalação do \033[01mWine\033[00m..."
    parsebasedebian
  fi
fi