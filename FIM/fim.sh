#!/bin/bash
# Tool name: FIM - File Integrity Monitoring Installer
# Written by: KsrvcO
# Version: 1.1
# Tested on debian based linux servers
# This tool running as a service in linux server

config_file="/etc/fim/fim.conf"
auto_check_time=$(cat $config_file | grep auto_check | cut -d "=" -f2)
for i in $(cat $config_file  | grep -v "#" | grep -v "auto_check")
do
        md5sum $i >> /etc/fim/md5.hash
done
while (true)
do
date=$(date | awk '{print $2,$3,$7,$4}')
       for j in $(cat $config_file  | grep -v "#")
               do
                    md5sum $j > /etc/fim/current.md5
                        if grep -q -Fx -f /etc/fim/current.md5 /etc/fim/md5.hash
                            then
                                echo "" > /dev/null
                            else
                                second_hash=$(md5sum $j | awk '{print $1}')
                                echo "$j changed at $date to hash $second_hash" >> /etc/fim/output
                                cat /etc/fim/output | sort -n | awk '{if (NF == 10) print $0}' >> /var/log/fim.log
                        fi

               done
rm -f /etc/fim/output
/usr/bin/sleep 10
done