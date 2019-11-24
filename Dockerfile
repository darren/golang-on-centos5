FROM centos:5.11

RUN rm -f /etc/yum.repos.d/*.repo
RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf 

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y gcc xz

ADD go1.4.3 /usr/local/go1.4.3
ADD go1.13.4 /usr/local/go

ENV GOROOT_BOOTSTRAP=/usr/local/go1.4.3/
RUN cd /usr/local/go/src/; ./make.bash
RUN cd /usr/local/; rm -rf go/pkg/obj; tar cf - go | xz -z - > /go1.13.4-CentOS5.linux-amd64.tar.xz
