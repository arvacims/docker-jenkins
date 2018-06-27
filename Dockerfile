FROM jenkins/jenkins:2.129

USER root

# Install docker binary
ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 18.03.1-ce
ENV DOCKER_COMPOSE_VERSION 1.21.2

RUN curl -fSL "https://${DOCKER_BUCKET}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o /tmp/docker-ce.tgz \
        && tar -xvzf /tmp/docker-ce.tgz --directory="/usr/local/bin" --strip-components=1 docker/docker \
	&& rm /tmp/docker-ce.tgz

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install plugins
RUN /usr/local/bin/install-plugins.sh \
  authentication-tokens:1.3 \
  credentials-binding:1.16 \
  docker-commons:1.13 \
  docker-workflow:1.17 \
  icon-shim:2.0.3 \
  xvnc:1.24 \
  gerrit-trigger:2.27.5 \
  git:3.9.1 \
  ldap:1.20 \
  matrix-auth:2.2 \
  workflow-aggregator:2.5

# Add groovy setup config
COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

# Add Jenkins URL and system admin e-mail config file
COPY jenkins.model.JenkinsLocationConfiguration.xml /usr/local/etc/jenkins.model.JenkinsLocationConfiguration.xml

USER jenkins
# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
