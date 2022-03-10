FROM ubuntu:18.04

MAINTAINER "Javier Hidalgo-Carrió" <https://jhidalgocarrio.github.io>

RUN apt-get update && \
    apt-get upgrade -y

RUN apt install -y --no-install-recommends \
    sudo zsh ssh vim build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev wget

RUN apt-get install -y ruby ruby-dev

RUN apt-get install -y libboost-all-dev

# Create javi user
RUN adduser  --disabled-password --gecos -m javi && adduser javi sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV HOME /home/javi
USER javi
WORKDIR /home/javi

ENV SHELL /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

RUN mkdir /home/javi/rock

RUN git config --global user.email "havyhidalgo@gmail.com"
RUN git config --global user.name "Javier Hidalgo-Carrió"

# Attaching point
CMD /usr/bin/zsh
