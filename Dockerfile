FROM ubuntu:xenial

RUN apt-get update

RUN mkdir build /scripts

COPY ./ /scripts
RUN chmod +x /scripts/build-env.sh
RUN cd /scripts/ && /scripts/build-env.sh

# EXPOSE 80