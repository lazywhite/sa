FROM centos:latest
USER  0
LABEL  version=1.0
LABEL  maintainer=bob@123.com
LABEL  description="this text illustrates \
that label-value can span multiple lines."

ENV PGUSER openerp
ENV PGPASSWORD mc1234

#ENTRYPOINT /entrypoint.sh 
EXPOSE 22 

SHELL ["/bin/bash"]
COPY test  /usr/local/test
WORKDIR /home/openerp
VOLUME ["/data"]
COPY entrypoint.sh  /entrypoint.sh
CMD ["tail", "-f"]
