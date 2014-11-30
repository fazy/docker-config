#!/bin/bash

if [ ! -f /.root_pw_set ]; then
        /set_root_pw.sh
fi

if [ ! -f /var/run/git_config_set ]; then
        /opt/run/git.sh
fi

exec /usr/sbin/sshd -D

