# Use the official Amazon Linux image as the base image
FROM amazonlinux:2

# Install necessary dependencies
RUN yum install -y java-1.8.0-openjdk-devel

# Set environment variables
ENV MULE_HOME /opt/mule
ENV MULE_VERSION 4.4.0

# Download and install Mule runtime
WORKDIR /opt
RUN curl -L https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz -o mule-standalone-${MULE_VERSION}.tar.gz \
    && tar -xf mule-standalone-${MULE_VERSION}.tar.gz \
    && mv mule-standalone-${MULE_VERSION} mule \
    && rm mule-standalone-${MULE_VERSION}.tar.gz

# Set the Mule runtime as the working directory
WORKDIR ${MULE_HOME}

# Expose the necessary ports for your Mule application
EXPOSE 8081

# Copy your Mule application to the container
COPY docker_mule.rar ${MULE_HOME}/apps/your-mule-app.zip

# Start the Mule runtime
CMD ["./bin/mule"]

# Example command to build the Docker image:
# docker build -t your-mule-app-image .
