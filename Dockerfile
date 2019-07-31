#-------------------------------------------------------
# Dockerfile to build Osint Framework system
# From https://github.com/lockfale/OSINT-Framework
#
# last modified:
#     2019-07-31 - First Commit
#
# Usage:
#   $ docker run -p <port>:8000 mrnonoss/osint-framework
#   Then browse to locahost:<port> # Where <port> is the port of your choice
#
#-------------------------------------------------------
FROM debian:stretch
LABEL maintainer="Bruno BORDAS <bruno.bordas@gmx.com>"

#################
# Configuration #
#################

WORKDIR /home
EXPOSE 8000

#############################
# Install Required Packages #
#############################

RUN apt-get update && apt-get full-upgrade -y && apt-get install apt-utils python git curl apt-transport-https lsb-release gnupg -y
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install nodejs -y
RUN ls && git clone https://github.com/lockfale/OSINT-Framework.git . && npm install

RUN groupadd -r osint && useradd -r -s /bin/false -g osint osint
USER osint

CMD ["npm", "start"]
