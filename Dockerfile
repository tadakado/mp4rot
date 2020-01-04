# https://hub.docker.com/_/ruby

FROM ruby

WORKDIR /home/mp4rot
ADD Gemfile .

RUN \
  bundle install && \
  apt-get update && \
  apt-get install -y ffmpeg && \
  cd /usr/local/src && \
  wget https://exiftool.org/Image-ExifTool-11.81.tar.gz && \
  tar xzf Image-ExifTool-11.81.tar.gz && \
  cd Image-ExifTool-11.81 && \
  perl Makefile.PL && \
  make install

