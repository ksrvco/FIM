#!/bin/bash
# Tool name: FIM - File Integrity Monitoring Installer
# Written by: KsrvcO
# Version: 1.1
# Tested on debian based linux servers
# This tool running as a service in linux server
mkdir -p /etc/fim/
chmod 755 /etc/fim/
mkdir -p /bin/fim/
touch /etc/fim/fim.conf
echo "# Welcome to File Integrity Monitoring configuration file." > /etc/fim/fim.conf
echo "# Setup and customize this configuration file before start FIM service." >> /etc/fim/fim.conf
echo "auto_check=100" >> /etc/fim/fim.conf
echo "# Add your important and sensitive files on your server for file integrity monitoring" >> /etc/fim/fim.conf
echo "/etc/passwd" >> /etc/fim/fim.conf
echo "/etc/shadow" >> /etc/fim/fim.conf
echo "/etc/group" >> /etc/fim/fim.conf
echo "/etc/fstab" >> /etc/fim/fim.conf
echo "/etc/ssh/sshd_config" >> /etc/fim/fim.conf
echo "/etc/sudoers" >> /etc/fim/fim.conf
echo "/etc/sysctl.conf" >> /etc/fim/fim.conf
chmod 644 /etc/fim/fim.conf
echo "Configuration file created in /etc/fim/fim.conf"
sleep 2
chmod 755 fim.sh
cp -r fim.service /etc/systemd/system/
echo "Service file config created in /etc/systemd/system/fim.service"
sleep 2
cp -r fim.sh /bin/fim/
echo "Execution files created in /bin/fim/fim.sh"
sleep 2
systemctl enable fim.service
sleep 4
systemctl start fim.service
sleep 4
echo ""
echo "Service Installed Successfully."
echo ""
systemctl status fim.service