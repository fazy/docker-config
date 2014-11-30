FROM tutum/ubuntu:trusty

ADD run.sh /run.sh
RUN chmod +x /*.sh

RUN apt-get update && apt-get -y install vim git

