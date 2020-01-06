FROM darrenhoo/centos5-go-bootstrap:latest

ADD go1.13.4 /usr/local/go
RUN cd /usr/local/go/src/; ./make.bash
RUN cd /usr/local/; rm -rf go/pkg/obj; tar cf - go | xz -z - > /go1.13.4-CentOS5.linux-amd64.tar.xz
