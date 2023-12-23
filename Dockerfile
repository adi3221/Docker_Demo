FROM mcr.microsoft.com/java/jre:8u252-zulu-alpine

ENV MULE_VERSION=4.4.0

WORKDIR /opt
RUN wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/$MULE_VERSION/mule-standalone-$MULE_VERSION.tar.gz && \
    tar -xf mule-standalone-$MULE_VERSION.tar.gz && \
    rm mule-standalone-$MULE_VERSION.tar.gz

EXPOSE 8081

WORKDIR /opt/mule-standalone-$MULE_VERSION

COPY docker_mule.rar apps/

CMD ["./bin/mule"]
