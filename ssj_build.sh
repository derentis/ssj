#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "This script requires Docker to be installed"
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "This script must be run with an active Internet connection"
   exit 1
fi

mkdir -p /tmp/ssj && \
cd /tmp/ssj && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/Dockerfile && \
docker build -t scarfaced/ssj:latest . && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/.bashrc && \
mkdir -p /home/ssj && \
cp .bashrc /home/ssj/.bashrc && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.desktop && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png && \
mkdir -p /usr/local/share/applications && \
cp ssj.desktop /usr/local/share/applications/ssj.desktop && \
cp ssj.png /usr/local/share/applications/ssj.png && \
cd /tmp && \
rm -rf /tmp/ssj && \
rm -rf /tmp/ssj.sh
