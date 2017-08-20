FROM centos:7
MAINTAINER B.s
ENV container docker
ENV LANG en_US.utf8
RUN ["yum", "-y", "update"]
COPY entrypoint.sh /entrypoint.sh
RUN ["yum", "-y", "initscripts", "telnet", "iputils", "inetutils-tools", "inetutils-ping", "wget", "unzip", "yum" , "apt-get" , "iftop" "epel-release", "gcc", "gcc-++", "tcpdump", "nmap"]
RUN ["chmod", "u+x", "/entrypoint.sh"]
RUN ["wget", "-O", "/tmp/remi-release", "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"]
RUN ["rpm", "-ivh", "/tmp/remi-release"]
CMD ["/bin/bash"]
ENTRYPOINT ["/entrypoint.sh"]
