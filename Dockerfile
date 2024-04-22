FROM ubuntu:22.04

ENV DEBAIN_FRONTEND = noninteractive

WORKDIR /minecraft

RUN apt-get update && apt-get install -y \ 
    openjdk-21-jdk \ 
    wget \ 
    && rm -rf /var/lib/at/lists/*

RUN wget -O server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

RUN echo "eula=true" > eula.txt

EXPOSE 25565

CMD [ "-Xmx2G", "-Xms2G", "-jar", "server.jar", "nogui" ]

ENTRYPOINT [ "java" ]

