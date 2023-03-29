FROM shoothzj/compile:jdk17-mvn AS compiler

RUN git clone --depth 1 https://github.com/alibaba/nacos.git && \
    cd nacos && \
    mvn -B clean install -DskipTests=true -Prelease-nacos -Dmaven.test.skip=true

FROM shoothzj/base:jdk17

COPY --from=compiler /nacos/distribution/target/nacos-server-2.2.1/nacos /opt/nacos

ENV NACOS_HOME /opt/nacos

sed -i "s/nacos.core.auth.plugin.nacos.token.secret.key=/nacos.core.auth.plugin.nacos.token.secret.key=${NACOS_TOKEN_SECRET_KEY}" ${NACOS_HOME}/conf/application.properties

WORKDIR /opt/nacos
