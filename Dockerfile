FROM centos:7
WORKDIR /tmp
ARG HELM_VERSION=v2.14.3
ENV HELM_HOME=/root/.helm
RUN yum -y install gunzip wget 
RUN wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
RUN gunzip helm-${HELM_VERSION}-linux-amd64.tar.gz && tar -xvf helm-${HELM_VERSION}-linux-amd64.tar && find ./
USER root
RUN cp linux-amd64/tiller /usr/bin/tiller && chgrp root /usr/bin/tiller && chmod 750 /usr/bin/tiller &&\
    cp linux-amd64/helm /usr/bin/helm && chgrp root /usr/bin/helm && chmod 750 /usr/bin/helm
RUN helm init --client-only && chgrp -R root /root/.helm && chmod -R 770 /root/.helm
#COPY template1 ./template1
#RUN helm --debug --host=localhost:44134 template template1
CMD while true; do echo "loop"; sleep 60; done;
