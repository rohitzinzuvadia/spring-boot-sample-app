FROM openjdk:11
RUN mkdir -p /app/bin
COPY target/spring-boot-sample-app-1.0.jar /app/bin
COPY deployment/runApp /app/bin
WORKDIR /app/bin
ENTRYPOINT ["/bin/sh"]