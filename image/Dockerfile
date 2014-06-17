FROM fedora
MAINTAINER gustavonalle

RUN yum -y install net-tools git puppet openssh-server yum-utils java-1.7.0-openjdk-devel
RUN /usr/sbin/sshd-keygen
RUN git clone https://github.com/gustavonalle/puppet /puppet
RUN puppet apply --modulepath=puppet/ -e 'include hadoop'

RUN yum -y remove puppet git yum-utils
RUN yum -y autoremove
RUN yum clean all
RUN rm -Rf /opt/hadoop/*.gz  /opt/hadoop/hadoop-1.1.1/src/ /puppet/

ADD java_home.sh /home/hadoop/.bashrc
ADD java_home.sh /etc/profile.d/java_home.sh

RUN echo "root:root" | chpasswd

EXPOSE 22 9001 50030 50070 50065 80 8080

ENTRYPOINT ["/usr/sbin/sshd","-D"]

