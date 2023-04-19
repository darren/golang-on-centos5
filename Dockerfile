FROM darrenhoo/centos5-go-bootstrap:1.17.13

ADD go-src /usr/local/go
RUN cd /usr/local/go/src/; ./make.bash
RUN cd /usr/local/; rm -rf go/pkg/obj; tar cf - go | xz -z - > /go.tar.xz
