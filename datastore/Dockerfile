FROM --platform=linux/amd64 amd64/mongo:4.4

# Set environment variables for MongoDB root user
ENV MONGO_INITDB_ROOT_USERNAME=root
ENV MONGO_INITDB_ROOT_PASSWORD=rootPassXXX

RUN apt-get update && apt-get install -y wget
RUN wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | tee /etc/apt/trusted.gpg.d/server-7.0.asc
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
RUN apt-get update
RUN apt-get install -y mongodb-mongosh
ADD  ./Pixi44Dump.tar /tmp
COPY pixi_setup.sh /docker-entrypoint-initdb.d
RUN chmod +x /docker-entrypoint-initdb.d/pixi_setup.sh

# Set usr/bin/mongod as the dockerized entry-point application
CMD ["mongod", "--quiet", "--bind_ip_all", "--auth"]