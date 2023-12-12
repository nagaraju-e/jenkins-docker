FROM openjdk:8-jdk-alpine
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN ./mvnw clean package

EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/source/target/multi-stage-example-0.0.1-SNAPSHOT.jar"]

VOLUME /var/run/docker.sock

RUN adduser jenkins sudo

RUN echo “jenkins ALL=NOPASSWD: ALL” >> /etc/sudoers

RUN usermod -aG docker jenkins

RUN chmod 777 /var/run/docker.sock

RUN chown root:jenkins /var/run/docker.sock

USER jenkins