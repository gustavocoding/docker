FROM fedora:21
MAINTAINER gustavonalle

ENV FLINK_VERSION 0.9.1
ENV FLINK_HADOOP hadoop1 

RUN (yum -y update; \
     yum -y install hostname words ruby supervisor iputils iproute openssh-clients net-tools openssh-server tar unzip java-1.8.0-openjdk-devel; \
     yum -y autoremove; \
     yum clean all;)

RUN curl "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/flink/flink-$FLINK_VERSION/flink-$FLINK_VERSION-bin-$FLINK_HADOOP.tgz" | tar -C /usr/local/ -xz | ln -s /usr/local/flink-$FLINK_VERSION/ /usr/local/flink

ADD java_home.sh /etc/profile.d/java_home.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER root
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 22 6123 8080 8081
