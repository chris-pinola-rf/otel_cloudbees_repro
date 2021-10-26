FROM adoptopenjdk/openjdk15:alpine-jre

WORKDIR /app

COPY . .

ENV JAVA_TOOL_OPTIONS=-javaagent:/app/opentelemetry-javaagent.jar
ENTRYPOINT ["./gradlew", "run"]
