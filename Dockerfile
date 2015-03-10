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



# ssh config...
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config


# Create known_hosts
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan -T 60 github.com >> /root/.ssh/known_hosts

#RUN git clone git@github.com:KnowRe/INADM-SERVER.git

#ADD start.sh /data/
#RUN chmod +x /data/start.sh

EXPOSE 5000:5000
ENV PORT 5000

#CMD sh /data/start.sh