# Install PuppetDB Server
FROM centos:centos6
MAINTAINER Tim Hartmann <tfhartmann@gmail.com>

COPY config/nginx.repo /etc/yum.repos.d/

RUN yum install epel-release -y
RUN yum install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm -y 
RUN yum install -y mrepo \
    lftp \
    apt-mirror \
    tar \
    hardlink \
    hostname \
    wget \
    unzip \
    rsync \
    python-pip \
    fuse \ 
    yum-utils \ 
    fuse-iso \
    nginx && \
    yum clean all

RUN mkdir -p /etc/mrepo.conf.d
RUN mkdir -p /mrepo/www
RUN chown -R nobody:nobody /mrepo
RUN echo 'set dns:order "inet inet6"' >> /etc/lftp.conf

ADD mrepo/mrepo.conf /etc/mrepo.conf 
ADD mrepo/repos.conf /etc/mrepo.conf.d/repos.conf 
ADD config/nginx.conf /etc/nginx/
ADD config/docker-entrypoint.sh / 

# Run MRepo and/or apache
CMD [ "/docker-entrypoint.sh" ]

# Expose Web ports
EXPOSE 80
