# Jenkins Docker Image
Official Jenkins docker plus some plugins and scripts in order to integrating with the Gerrit.  
Additional plugins include:
* gerrit-trigger:2.21.1
* git-client:1.19.6
* git:2.4.4
* structs:1.2
* scm-api:1.2
* junit:1.15
* maven-plugin:2.13
* docker-plugin:0.16.0
* durable-task:1.11
* token-macro:1.12.1
* ssh-slaves:1.10
* ldap:1.12
* ssh-credentials:1.11
* credentials:1.27
* authentication-tokens:1.2
* icon-shim:2.0.3
* docker-commons:1.4.0
* docker-build-publish:1.3.1
* parameterized-trigger:2.30
* swarm:2.1

## Features
* Demonstrate how to integrate Jenkins with Gerrit.
* Domonstrate how to configure Jenkins [docker-plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin) to utilise other docker images as the slave nodes.
* There's a [sample image](https://hub.docker.com/r/openfrontier/jenkins-slave/) which demonstrate how to build a jenkins-slave image for Jenkins docker-plugin.
* There's another [project](https://github.com/openfrontier/ci) which privdes sample scripts about how to combine this image with [Gerrit image](https://hub.docker.com/r/openfrontier/gerrit/) and other images to create a ci system.

## Create Jenkins container
    createJenkins.sh

## Basic setup for integrating Jenkins with Gerrit.

    #A public ssh key should be imported to Gerrit first as the <Gerrit admin uid>'s public key.
    setupJenkins.sh \
      <Gerrit admin uid> \
      <Gerrit admin email> \
      <Gerrit ssh ip/name> \
      <Gerrit canonicalWebUrl> \
      <Jenkins WebUrl> \
      <Nexus public repoUrl>

    sample:
    setupJenkins.sh \
      gerrit \
      gerrit@demo.org \
      172.17.42.1 \
      http://ci.demo.org/gerrit \
      http://ci.demo.org/jenkins \
      http://ci.demo.org/nexus/content/groups/public

## Destroy Jenkins container (Use with caution!)
    destroyJenkins.sh

## Upgrade Jenkins container (Use with caution!)
    upgradeJenkins.sh

