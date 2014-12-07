FROM tutum/ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive
RUN    apt-get update \
    && apt-get -yq install \
        vim \
        git \
    && rm -rf /var/lib/apt/lists/*

ADD run /opt/run
RUN chmod +x /opt/run/*.sh

ADD git/.gitconfig /root/

CMD ["/opt/run/init.sh"]
