FROM ubuntu:14.04
MAINTAINER mroshan@gmail.com

RUN apt-get update 

# Install SSH
RUN apt-get install -y openssh-server 
RUN mkdir /var/run/sshd

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd

# Install Mysql
RUN apt-get install -y mysql-server-5.6 libmysqlclient-dev
#RUN apt-get install -y mysql-server-5.6 mysql-client libmysqlclient-dev
# Install Apache
RUN apt-get install -y apache2
# Install php
RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

RUN apt-get install -y wget bzip2
RUN wget -q -O - --no-check-certificate https://s3.amazonaws.com/nor1.internal.share/QA/nor1_upg_db1_dal_us.latest.sql.bz2  | bunzip2 >/root/nor1upg_db.sql
RUN wget -q -O - --no-check-certificate https://s3.amazonaws.com/nor1.internal.share/QA/analytics_schema.sql >/root/analytics_schema.sql

# Install phpMyAdmin
RUN mysqld & \
    service apache2 start; \
    sleep 5; \
    printf y\\n\\n\\n\\n | apt-get install -y phpmyadmin; \
    sleep 15; \
    mysqladmin -u root create nor1_upg_db_dal_us; \
    mysqladmin -u root create analytics; \
    mysql -u root nor1_upg_db_dal_us </root/nor1upg_db.sql; \
    mysql -u root analytics </root/analytics_schema.sql; \
    mysqladmin -u root shutdown

RUN sed -i "s#// \$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\] = TRUE;#\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\] = TRUE;#g" /etc/phpmyadmin/config.inc.php 
COPY apache-phpmyadmin.conf /etc/apache2/sites-available/000-default.conf

#EXPOSE 80
#EXPOSE 3306

CMD mysqld_safe & \
    service apache2 start & \
    /usr/sbin/sshd -D
