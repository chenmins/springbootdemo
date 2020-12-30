FROM maven:3-jdk-8 as app
#docker run -it --rm -v "$PWD":/usr/src/mymaven -v /data/maven:/root/.m2  -w /usr/src/mymaven -e MAVEN_CONFIG=/root/.m2 maven:3-jdk-8  mvn -X clean package 
COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven
RUN mvn -X clean package -Dmaven.test.skip=true


FROM chenmins/serverjre8:util
COPY --from=app /usr/src/mymaven/target/springboot-hello-0.0.1-SNAPSHOT.jar /opt
WORKDIR /opt
CMD ["java","-jar","/opt/springboot-hello-0.0.1-SNAPSHOT.jar"]