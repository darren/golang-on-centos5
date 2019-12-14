## Build Go on CentOS5

*WARNING: Go has never been supported on CentOS5, use on your own risk.*


## Can not access github on centos5

```
error: error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version while accessing 
```

RESOLVE: disable https verify

edit ~/.gitconfig
```
[http]
	sslVerify = false
```


## References

1. [How to install Go 1.1 on CentOS 5.9 by Dave Cheney](https://dave.cheney.net/2013/06/18/how-to-install-go-1-1-on-centos-5)
