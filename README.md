docker-config
=============

***New/experimental***

Docker image for editing configuration exported from another container. Currently supported:

* SSH
* Git
* Vim

The image is intended to be useful enough already, but you'll probably want to extend it.
Also, it is primarily intended as a development tool for working with new Docker images.
You still need a strategy to launch new docker containers based on the finished configuration.

Usage
-----

The image you want to configure should already be running and exporting volumes for the necessary
config directories.

Run an instance of the config container:

    docker run -d \
        -p <port>:22 \
        -e SSH_AUTHORIZED_KEY=`cat <public-key>` \
        --volumes-from <container-id> \
        fazy/config

Change `<...>` as follows:

* `<port>` = SSH port on the host to listen on
* `<public-key>` = SSH public key to allow login inside the container, e.g. ~/.ssh/id_rsa.pub
* `<container-id>` = id/name of the container exporting volumes that you want to edit

SSH into your container:

    ssh -p <port> root@localhost

After editing the config, you might need to restart the application within the container.
This is entirely dependant on the application however.

SSH config
----------

The container requires a public key for SSH access, and also supports adding a private key
for outbound connections.

* **SSH_AUTHORIZED_KEY** - key that will be written to /root/.ssh/authorized_keys
  inside the container

* **SSH_PRIVATE_KEY** - key that will be written to /root/.ssh/id_rsa inside the container
  (place the corresponding public key with hosts you want to connect to, e.g. Github)

Git config
----------

You can configure the following:

* GIT_AUTHOR_NAME
* GIT_AUTHOR_EMAIL

There's also a .gitconfig file non-user specific which can be changed by building
a new container with your own .gitocnfig.

How to launch the container via Fig
-----------------------------------

If you are using [Fig](http://www.fig.sh/) to manage Docker, here's an example `fig.yml`:

    config:
        image: fazy/config
        environment:
            SSH_AUTHORIZED_KEY:
            SSH_PRIVATE_KEY:
            GIT_AUTHOR_NAME: My Name
            GIT_AUTHOR_EMAIL: me@example.net
        volumes_from:
            - my_docker_application
        ports:
            - "2222:22"

I didn't want to include my SSH keys in `fig.yml`, so I launch fig like this:

    cd /path/to/fig/config
    SSH_AUTHORIZED_KEY=`cat ~/.ssh/id_rsa.pub` SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa` fig up -d

Todo
----

This Dockerfile is barely started, here are a few TODOs:

* Allow for Git configuration
* Allow for Vim configuration
* Allow key-based SSH login
* Script that starts a new config instance, connects via SSH, then terminates the config
  instance after exiting SSH (handy for quick config edits without leaving config containers
  lying around).
