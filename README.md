docker-config
=============

***New/experimental***

Docker image designed for editing config files. Currently just installs Git and Vim.

This is designed to work with images that export volumes.

Note, this is only a development tool for working on new Docker configs. You still need
a strategy to launch new docker containers based on the finished configuration. How to
do this entirely depends on how your container is designed.

Usage
-----

The image you want to configure should already be running and exporting volumes for the necessary
config directories.

Run an instance of the config container:

    docker run -d -p 0.0.0.0:<port>:22 -e ROOT_PASS="<password>" --volumes-from <container-id> fazy/config

Change `<...>` as follows:

* `<port>` = SSH port on the host to listen on
* `<password>` = root SSH password
* `<container-id>` = id/name of the container exporting volumes that you want to edit

SSH into your container:

    ssh -p <port> root@localhost

After editing the config, you will need to reload the daemon in your Docker container. How
to do this depends on the specific container/application. This brute force method has worked
for me:

    docker restart <container-id>

If you want to configure multiple Docker containers in this way, run a new config container
instance for each one using a different SSH port. You don't need to keep the config container
running when you've finished editing, so you can always just shut it down and start a new one.

Git config
----------

A work in progrss but you can configure the following:

* GIT_AUTHOR_NAME
* GIT_AUTHOR_EMAIL

There's also a .gitconfig file non-user specific which can be changed by building
a new container with your own .gitocnfig.

Todo
----

This Dockerfile is barely started, here are a few TODOs:

* Allow for Git configuration
* Allow for Vim configuration
* Allow key-based SSH login
* Allow copying SSH keys into the container (e.g. for accessing Github/Bitbucket)
* Script that starts a new config instance, connects via SSH, then terminates the config
  instance after exiting SSH (handy for quick config edits without leaving config containers
  lying around).


