FROM ubuntu:14.04
USER  0
MAINTAINER bob@123.com
LABEL  version=1.0
LABEL  description="this texst illustrates \
that label-value can span multiple lines."

ENV PGUSER openerp
ENV PGPASSWORD mc1234


ENTRYPOINT /entrypoint.sh 


EXPOSE 22 
ADD test  /usr/local/test
CMD mkdir /home/openerp
#RUN apt-get update && apt-get install -y --force-yes apache2
#RUN /bin/bash -c 'echo hello'
COPY *.txt  /home/openerp
COPY entrypoint.sh  /entrypoint.sh



