FROM xavivn/centos6:2.0
MAINTAINER B.S
ENV PACKAGE_URL https://dev.mysql.com/get/mysql57-community-release-el6-8.noarch.rpm
RUN yum -y install $PACKAGE_URL \
        && yum -y install mysql-community-server
VOLUME /etc/my.cnf.d/
VOLUME /var/lib/mysql/
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "u+x", "/docker-entrypoint.sh"]
ENV LANG en_US.utf8
CMD ["/bin/bash"]
ENTRYPOINT ["/docker-entrypoint.sh"]
