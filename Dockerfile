FROM ubuntu:22.04

ENV DEBAIN_FRONTEND = noninteractive

WORKDIR /minecraft

RUN apt-get update && apt-get install -y \ 
    openjdk-21-jdk \ 
    wget \ 
    && rm -rf /var/lib/at/lists/*

RUN wget -O server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

RUN echo "eula=true" > eula.txt

RUN rm -rf /minecraft/world

RUN echo "level-name=../../minecraft/worlds/A_hole_world" > server.properties

EXPOSE 25565

ENTRYPOINT [ "java" ]

CMD [ "-Xmx2G", "-Xms2G", "-jar", "server.jar", "nogui" ]

