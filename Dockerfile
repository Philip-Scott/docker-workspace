FROM openjdk:8u162-jre-stretch

RUN mkdir build /scripts

COPY ./ /scripts
RUN chmod +x /scripts/build-env.sh
RUN cd /scripts/ && /scripts/build-env.sh

# EXPOSE 80