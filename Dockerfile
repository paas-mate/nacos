FROM shoothzj/compile:jdk17-mvn AS compiler

RUN git clone --depth 1 https://github.com/alibaba/nacos.git && \
    cd nacos && \
    mvn -B clean package -DskipTests=true -Prelease-nacos -Dmaven.test.skip=true

FROM shoothzj/base:jdk17

COPY --from=compiler /nacos/distribution/target/nacos-server-2.2.1/nacos /opt/nacos

ENV NACOS_HOME /opt/nacos

WORKDIR /opt/nacos
