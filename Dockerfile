# Use the Amazon Linux base image
FROM amazonlinux:2

# Install necessary dependencies
RUN yum -y update && \
    yum -y install java-1.8.0-openjdk-devel

# Set environment variables
ENV MULE_HOME /opt/mule
ENV MULE_VERSION 4.4.0  # Replace with your desired Mule version
ENV MULE_DOWNLOAD_URL https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz

# Create the MuleSoft installation directory
RUN mkdir -p ${MULE_HOME}

# Download and extract MuleSoft runtime
RUN curl -L ${MULE_DOWNLOAD_URL} | tar -xz --strip-components=1 -C ${MULE_HOME}

# Set the working directory to MuleSoft installation directory
WORKDIR ${MULE_HOME}

# Expose the necessary ports
EXPOSE 8081

# Copy your Mule application JAR to the apps directory
COPY ./docker_mule.jar ${MULE_HOME}/apps/

# Start MuleSoft runtime
CMD ["./bin/mule"]
