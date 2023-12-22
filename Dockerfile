# Use the official Amazon Linux image
FROM amazonlinux:2

# Install required dependencies
RUN yum update -y \
    && amazon-linux-extras install -y java-openjdk11 \
    && yum install -y wget unzip curl

# Set the Mule runtime version
ENV MULE_VERSION=4.4.0

# Download and install Mule runtime
WORKDIR /opt
RUN wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.4.0/mule-standalone-4.4.0.tar.gz \
    && tar -xzf mule-standalone-4.4.0.tar.gz \
    && rm mule-standalone-4.4.0.tar.gz \
    && ln -s mule-standalone-4.4.0 mule

# Set the working directory
WORKDIR /opt/mule

# Copy the Mule application into the container
COPY ./docker_mule.rar /opt/mule/apps/

# Expose the Mule runtime ports
EXPOSE 8081

# Start the Mule runtime when the container starts
CMD ["./bin/mule"]

# Healthcheck to ensure the Mule runtime is running
HEALTHCHECK CMD curl --fail http://localhost:8081/ || exit 1
