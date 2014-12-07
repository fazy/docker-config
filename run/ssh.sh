#!/bin/sh

if [ ! -z "$SSH_AUTHORIZED_KEY" ]; then
    mkdir -p /root/.ssh
    echo "$SSH_AUTHORIZED_KEY" > /root/.ssh/authorized_keys
fi

if [ ! -z "$SSH_PRIVATE_KEY" ]; then
    mkdir -p /root/.ssh
    echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
fi

if [ -d /root/.ssh ]; then
    chmod 0700 /root/.ssh
    chmod 0600 /root/.ssh/*
fi
