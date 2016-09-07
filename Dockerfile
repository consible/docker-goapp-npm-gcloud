FROM ubuntu
MAINTAINER arran@consible.com

RUN apt-get update && \
  apt-get install -y build-essential vim htop automake aufs-tools curl git ssh wget unzip python && \
  curl -sL https://deb.nodesource.com/setup_5.x | bash -  && \
  apt-get install -y nodejs && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /work/ /.gopath/ && \
  wget https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-1.9.40.zip -O /gae.zip && \
  unzip /gae.zip && \
  rm -f /gae.zip && \
  echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update && apt-get install -y google-cloud-sdk

WORKDIR /work

ENV PATH /go_appengine/:$PATH
ENV GOROOT /go_appengine/goroot/
ENV GOPATH /.gopath/

RUN goapp get google.golang.org/appengine
