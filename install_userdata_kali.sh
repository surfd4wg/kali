#!/bin/bash
chsh -s $(which bash) kali
chsh -s $(which bash) root
banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}
#Update all the packages to the latest
banner "Updating packages and distribution"
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo reboot -r now 
#More Updating after reboot
sudo apt install linux-headers-$(uname -r)
sudo apt-get install shellter
dpkg --add-architecture i386 && apt update && apt -y install wine32
#--- curl, unzip, jq
banner "Installing curl, unzip, jq"
sudo apt-get update
sudo apt-get -y install curl unzip
sudo apt-get -y install jq
#--- AWS CLI ---
#banner "Installing AWS cli"
#mkdir /AWSCLIinstall
#cd /AWSCLIinstall
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#sudo ./aws/install
#--- snap (reqd for AWS SSM agent install ---
#banner "Installing snap"
#sudo apt update
#sudo apt install -y snapd
#sudo snap install hello-world
#--- AWS SSM ---
#banner "Installing  AWS SSM"
#sudo snap install amazon-ssm-agent --classic
#sudo systemctl status snap.amazon-ssm-agent.amazon-ssm-agent.service
#sudo systemctl stop snap.amazon-ssm-agent.amazon-ssm-agent.service
#sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service

PS1_DATE="\D{%Y-%m-%d %H:%M:%S %Z}"
LOCATION=' `pwd | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`'
color_prompt=yes

# Color mapping
grey='\[\033[1;30m\]' #bold dark
GREY='\[\033[0;30m\]' #dark
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
purple='\[\033[0;35m\]'
PURPLE='\[\033[1;35m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
NC='\[\033[0m\]'

if [ "$color_prompt" = yes ]; then
    PS1="$PURPLE $PS1_DATE $GREEN\u@\h$NC:$BLUE$LOCATION$NC\$"
else
    PS1="$NC$PS1_DATE \u@\h $LOCATION\$"
fi

