FROM fedora
MAINTAINER gustavonalle

RUN (yum -y update; \
     yum -y install net-tools git puppet openssh-server yum-utils java-1.7.0-openjdk-devel; \
     /usr/sbin/sshd-keygen; \
     git clone https://github.com/gustavonalle/puppet /puppet; \
     puppet apply --modulepath=puppet/ -e 'include hadoop'; \
     yum -y remove puppet git yum-utils; \
     yum -y autoremove; \
     yum clean all; \
     rm -Rf /opt/hadoop/*.gz  /opt/hadoop/hadoop-1.1.1/src/ /puppet/)

ADD java_home.sh /home/hadoop/.bashrc
ADD java_home.sh /etc/profile.d/java_home.sh

RUN echo "root:root" | chpasswd

RUN sed -i -e 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/' /etc/pam.d/sshd

EXPOSE 22 9001 50030 50070 50065 80 8080

ENTRYPOINT ["/usr/sbin/sshd","-D"]

