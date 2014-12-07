#!/bin/bash

if [ ! -f /.root_pw_set ]; then
    /set_root_pw.sh
fi

if [ ! -f docker_config_set ]; then
    /opt/run/ssh.sh
    /opt/run/git.sh

    touch /var/run/docker_config_set
fi

exec /usr/sbin/sshd -D
