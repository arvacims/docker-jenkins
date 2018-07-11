FROM jenkins/jenkins:2.121.1

# Install docker binary
USER root

ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 18.03.1-ce
ENV DOCKER_COMPOSE_VERSION 1.21.2

RUN curl -fSL "https://${DOCKER_BUCKET}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o /tmp/docker-ce.tgz \
        && tar -xvzf /tmp/docker-ce.tgz --directory="/usr/local/bin" --strip-components=1 docker/docker \
	&& rm /tmp/docker-ce.tgz

RUN curl -fSL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

USER jenkins

# Install plugins
RUN /usr/local/bin/install-plugins.sh \
    ssh-credentials:1.14 \
    gerrit-trigger:2.27.5 \
    ldap:1.20

# Add groovy setup config
COPY init.groovy.d/csrf_protection.groovy       /usr/share/jenkins/ref/init.groovy.d/
COPY init.groovy.d/general_credentials.groovy   /usr/share/jenkins/ref/init.groovy.d/
COPY init.groovy.d/general_url.groovy           /usr/share/jenkins/ref/init.groovy.d/
COPY init.groovy.d/gerrit.groovy                /usr/share/jenkins/ref/init.groovy.d/
COPY init.groovy.d/ldap.groovy                  /usr/share/jenkins/ref/init.groovy.d/

# Add Jenkins URL and system admin e-mail config file
COPY jenkins.model.JenkinsLocationConfiguration.xml /usr/local/etc/jenkins.model.JenkinsLocationConfiguration.xml

# Add setup script.
COPY jenkins-setup.sh /usr/local/bin/jenkins-setup.sh

# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
