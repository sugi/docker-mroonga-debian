FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://packages.groonga.org/debian/ wheezy main" > /etc/apt/sources.list.d/groonga.list
RUN echo "deb-src http://packages.groonga.org/debian/ wheezy main" >> /etc/apt/sources.list.d/groonga.list

RUN apt-get update
RUN apt-get -y --allow-unauthenticated install groonga-keyring; apt-get update
RUN apt-get -y install mysql-server-mroonga
ADD init /

CMD ["/init"]
