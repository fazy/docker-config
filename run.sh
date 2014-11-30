#!/bin/bash
if [ ! -f /.root_pw_set ]; then
        /set_root_pw.sh
fi

if [ ! -z "$GIT_AUTHOR_NAME" ]; then
        git config --global user.name "$GIT_AUTHOR_NAME"
fi

if [ ! -z "$GIT_AUTHOR_EMAIL" ]; then
        git config --global user.email "$GIT_AUTHOR_EMAIL"
fi

exec /usr/sbin/sshd -D

