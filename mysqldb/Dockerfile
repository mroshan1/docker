FROM ubuntu:14.04
MAINTAINER mroshan@gmail.com

RUN apt-get update 

# Install SSH
RUN apt-get install -y openssh-server 
RUN mkdir /var/run/sshd

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd

# Install Mysql
RUN apt-get install -y mysql-server-5.5 mysql-client libmysqlclient-dev
# Install Apache
RUN apt-get install -y apache2
# Install php
RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

RUN apt-get install -y wget bzip2
RUN wget -q -O - --no-check-certificate https://s3.amazonaws.com/bucket/testdb.sql.bz2  | bunzip2 >/root/testdb.sql

# Install phpMyAdmin
RUN mysqld & \
    service apache2 start; \
    sleep 5; \
    printf y\\n\\n\\n\\n | apt-get install -y phpmyadmin; \
    sleep 15; \
    mysqladmin -u root testdb; \
    mysql -u root testdb </root/testdb.sql; \
    mysqladmin -u root shutdown

RUN sed -i "s#// \$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\] = TRUE;#\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\] = TRUE;#g" /etc/phpmyadmin/config.inc.php 

#EXPOSE 80
#EXPOSE 3306

CMD mysqld_safe & \
    service apache2 start & \
    /usr/sbin/sshd -D
