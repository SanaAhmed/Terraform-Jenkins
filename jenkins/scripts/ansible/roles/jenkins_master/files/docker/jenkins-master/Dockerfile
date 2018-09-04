FROM java:8-jdk

ARG http_port=8080

# Variables to define Jenkins version and Jenkins Home directory
ARG JENKINS_VERSION=1.651.3
ARG JENKINS_SHA=564e49fbd180d077a22a8c7bb5b8d4d58d2a18ce
ENV JENKINS_HOME "/var/jenkins_home"


ARG user=ubuntu
ARG group=jenkins
ARG uid=1000
ARG gid=1000


RUN apt-get update \
    && apt-get install -y git curl zip \
&& rm -rf /var/lib/apt/lists/*


# Set up environment variables for Jenkins
ENV JENKINS_VERSION ${JENKINS_VERSION}
ENV JENKINS_HOME ${JENKINS_HOME}


RUN mkdir /usr/share/jenkins
# Downloads the Jenkins WAR and leaves it in tomcat folder
RUN curl "http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war" -o /usr/share/jenkins/jenkins.war

#Default port for jenkins master
EXPOSE ${http_port}