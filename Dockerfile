FROM centos:centos6
MAINTAINER Hanbat Kil, hbkil@knowre.com

# Download necessary packages... just append \ and package name to install more
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN	yum install -y \
	ImageMagick \
	npm \
	unzip \
	git \
	wget \
	ssh


# AWS CLI download...
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# change work directory to /data which is where the application files are going to be
WORKDIR /data

RUN git clone https://github.com/rauchg/chat-example.git /data/chat

RUN cd chat && npm install 

CMD cd chat && node index.js


EXPOSE 3000:3000
