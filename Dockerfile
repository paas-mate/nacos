FROM shoothzj/compile:jdk17-mvn

RUN git clone --depth 1 https://github.com/alibaba/nacos.git && \
    cd nacos && \
    mvn -B clean package -DskipTests=true
