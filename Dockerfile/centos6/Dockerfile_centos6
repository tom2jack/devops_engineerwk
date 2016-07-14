FROM centos:6
MAINTAINER Nguyen Manh Dung
RUN ["yum", "-y", "update"]
COPY entrypoint.sh /entrypoint.sh
RUN ["yum", "-y", "install", "initscripts", "telnet", "iputils", "inetutils-tools", "inetutils-ping", "wget", "unzip", "epel-release", "gcc", "gcc-++", "tcpdump", "nmap"]
RUN ["chmod", "u+x", "/entrypoint.sh"]
RUN ["wget", "-O", "/tmp/remi-release", "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"]
RUN ["rpm", "-ivh", "/tmp/remi-release"]
ENV LANG en_US.utf8
CMD ["/bin/bash"]
ENTRYPOINT ["/entrypoint.sh"]
