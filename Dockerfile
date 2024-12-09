FROM debian:12.8

WORKDIR /app

RUN apt-get -y update
RUN apt-get -y install wget unzip

# Latest Version at time of creation
ARG VERSION=1449

# Download the desired server-zip and extract it
RUN wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip -O server.zip \
    && unzip server.zip \
    && rm server.zip

# Copy the boot script
COPY boot.sh boot.sh
RUN chmod +x boot.sh

# Default environment parameters
ENV MAX_PLAYERS 20
ENV WORLD_NAME "Terraria Docker"
ENV DIFFICULTY 0
ENV MOTD ""
ENV PASSWORD ""

# Ensure worlds directory exists (intended to be mounted)
RUN mkdir -p /app/worlds

# Terraria default port
EXPOSE 7777

# Change workdir
WORKDIR /app/${VERSION}/Linux/

# Run the boot script
CMD /app/boot.sh