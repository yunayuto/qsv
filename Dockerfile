FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/ffmpeg
RUN set -x && \
    apt-get update && \
    apt-get install -y \
      git make g++ yasm \
      libfdk-aac-dev libva-dev libmfx-dev intel-media-va-driver-non-free && \
    git clone https://github.com/FFmpeg/FFmpeg.git && \
    ./configure \
      --disable-ffplay \
      --disable-debug \
      --disable-doc \
      --enable-libmfx && \
    make -j $(grep cpu.cores /proc/cpuinfo | sort -u | sed 's/[^0-9]//g')
