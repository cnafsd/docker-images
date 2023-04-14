FROM centos:7

ARG UMD_RELEASE_PACKAGE_URL=http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm

RUN \
  echo "include_only=.garr.it,.cern.ch" >> /etc/yum/pluginconf.d/fastestmirror.conf && \
  rpm --import http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7 && \
  rpm --import http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-Testing-7 && \
  yum clean all && \
  yum --enablerepo=centosplus install -y deltarpm redhat-lsb && \
  yum -y install hostname which wget tar sudo file less epel-release ${UMD_RELEASE_PACKAGE_URL} && \
  yum -y update && \
  yum clean all