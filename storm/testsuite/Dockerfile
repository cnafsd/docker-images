FROM italiangrid/centos7-base

ARG PUPPET_STDLIB_VERSION=8.6.0
ARG PUPPET_FETCHCRL_VERSION=5.1.0
ARG PUPPET_EPEL_VERSION=4.1.0
ARG PUPPET_APT_VERSION=8.5.0
ARG PUPPET_FIREWALL_VERSION=5.0.0
ARG PUPPET_SAZSUDO_VERSION=7.0.2
ARG PUPPET_MYSQL_VERSION=14.0.0

ADD setup /setup

ENV PATH="/opt/puppetlabs/bin:${PATH}"

# Install Puppet
RUN rpm -Uvh https://yum.puppet.com/puppet7-release-el-7.noarch.rpm && \
  rpm -Uvh https://yum.puppet.com/puppet-tools-release-el-7.noarch.rpm && \
  wget http://yum.puppet.com/RPM-GPG-KEY-puppet-20250406 && \
  rpm --import RPM-GPG-KEY-puppet-20250406 && \
  yum install -y puppet pdk

RUN puppet --version

# Install specific version of modules
RUN puppet module install puppetlabs-stdlib --version $PUPPET_STDLIB_VERSION
RUN puppet module install puppet-epel --version $PUPPET_EPEL_VERSION
RUN puppet module install puppet-fetchcrl --version $PUPPET_FETCHCRL_VERSION
RUN puppet module install puppetlabs-apt --version $PUPPET_APT_VERSION
RUN puppet module install puppetlabs-firewall --version $PUPPET_FIREWALL_VERSION
RUN puppet module install saz-sudo --version $PUPPET_SAZSUDO_VERSION
RUN puppet module install puppetlabs-mysql --version $PUPPET_MYSQL_VERSION


# Install Puppet modules
RUN puppet module install puppet-python --version "<=5.0.0" && \
    puppet module install puppetlabs-java && \
    puppet module install cnafsd-sdds_users && \
    puppet module install cnafsd-voms && \
    puppet module install cnafsd-testca && \
    puppet module install cnafsd-umd4 && \
    puppet module install cnafsd-storm

RUN sh /setup/setup.sh

USER tester

WORKDIR /home/tester

VOLUME /assets
