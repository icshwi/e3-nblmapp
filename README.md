
e3-nblmapp  
======
ESS Site-specific EPICS IOC Application : nblmapp

In CSS the main opi to run is nBLM_daq.opi


## Setup development tool

```
$ yum install centos-release-scl
$ yum-config-manager --enable rhel-server-rhscl-7-rpms
```

* gcc8

```
$ yum install devtoolset-8
```

## Enable gcc 8

```
$ scl enable devtoolset-8 bash
```

```
$ bash e3.bash base
...

```

## Disabled gcc 8

```
$ exit
```

## GCC compiler options

 Unfortunately, CentOS7 devtoolset-8 doesn't support -std=gnu++17. However ESS Yocto Linux does support it properly.
 