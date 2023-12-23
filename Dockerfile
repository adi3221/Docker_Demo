# Use Amazon Linux as the base image
FROM amazonlinux:2

# Set environment variables
ENV MULE_HOME /opt/mule
ENV MULE_VERSION 4.4.0
ENV MULE_DOWNLOAD_URL https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz

# Install dependencies
RUN yum -y update && \
    yum -y install tar gzip java-1.8.0-openjdk && \
    yum clean all

# Download and extract MuleSoft runtime
RUN mkdir -p ${MULE_HOME} && \
    curl -L ${MULE_DOWNLOAD_URL} | tar xz -C ${MULE_HOME} --strip-components=1

# Expose the necessary ports
EXPOSE 8081

# Set the working directory to MuleSoft installation directory
WORKDIR ${MULE_HOME}

# Copy your Mule application into the container
COPY ./target/docker_mule-1.0.0-SNAPSHOT-mule-application.jar ${MULE_HOME}/apps/

# Start MuleSoft runtime
CMD ["./bin/mule"]
