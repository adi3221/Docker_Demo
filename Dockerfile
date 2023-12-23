# Use an official MuleSoft base image
FROM mcr.microsoft.com/java/jre:8u252-zulu-alpine

# Set environment variables
ENV MULE_HOME=/opt/mule
ENV MULE_VERSION=4.4.0

# Download and install Mule runtime
WORKDIR /opt
RUN wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/$MULE_VERSION/mule-standalone-$MULE_VERSION.tar.gz && \
    tar -xf mule-standalone-$MULE_VERSION.tar.gz && \
    rm mule-standalone-$MULE_VERSION.tar.gz && \
    ln -s mule-standalone-$MULE_VERSION mule

# Expose necessary ports
EXPOSE 8081

# Set the working directory to the Mule home directory
WORKDIR $MULE_HOME

# Copy your Mule application (RAR file) to the apps directory
COPY docker_mule.rar $MULE_HOME/apps/

# Start Mule runtime
CMD ["./bin/mule"]
