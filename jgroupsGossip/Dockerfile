FROM jboss/base-jdk:7

RUN curl http://central.maven.org/maven2/org/jgroups/jgroups/3.6.0.Final/jgroups-3.6.0.Final.jar > jgroups.jar

EXPOSE 12001

CMD ["java","-classpath","jgroups.jar","org.jgroups.stack.GossipRouter","-port","12001"]

