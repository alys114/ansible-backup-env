#!/bin/bash
################################################
# Author: alys114
# Blog: blog.alys114.com
# Time: 2018-03-19 19:39:59
# Name: rsync_server.sh
# Version: V1.0
# Description: This is a...
################################################

[ ! /usr/bin/rsync -f ] && {
    # rsync need to install
    yum install -y rsync
}

useradd rsync -s /sbin/nolgoin -M -u 801
mkdir -p /backup
chown rsync.rsync /backup
chmod 600 /etc/rsync.password
rsync --daemon
echo 'rsync --daemon'>>/etc/rc.local

