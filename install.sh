#!/bin/sh
if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi
export DEBIAN_FRONTEND=noninteractive

echo "we are going to download needed files:)"
GITHUB_REPOSITORY=hiddify-config
GITHUB_USER=hiddify
GITHUB_BRANCH_OR_TAG=main

apt update
apt upgrade -y
apt install -y wget python3-pip dialog unzip
pip3 install lastversion "requests<=2.29.0"

mkdir -p /opt/$GITHUB_REPOSITORY
cd /opt/$GITHUB_REPOSITORY

wget https://github.com/hiddify/hiddify-config/releases/download/v9.4.3/hiddify-config.zip -O hiddify-config.zip
unzip -o hiddify-config.zip
rm hiddify-config.zip

bash install.sh

echo "/opt/$GITHUB_REPOSITORY/menu.sh">>~/.bashrc
echo "cd /opt/$GITHUB_REPOSITORY/">>~/.bashrc

read -p "Press any key to go to menu" -n 1 key
cd /opt/$GITHUB_REPOSITORY
bash menu.sh
