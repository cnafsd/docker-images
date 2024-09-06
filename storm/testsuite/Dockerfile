FROM almalinux:9

ARG PUPPET_STDLIB_VERSION=9.6.0
# ARG PUPPET_FETCHCRL_VERSION=7.0.0
ARG PUPPET_EPEL_VERSION=5.0.0
ARG PUPPET_APT_VERSION=9.4.0
ARG PUPPET_MYSQL_VERSION=16.0.0
ARG PUPPET_PYTHON_VERSION=7.3.0
ARG PUPPET_ARCHIVE_VERSION=7.1.0
ARG PUPPET_ACCOUNTS_VERSION=8.2.0
ARG PUPPET_JAVA_VERSION=11.0.0
ARG PUPPET_SAZSUDO_VERSION=8.0.0
ARG PUPPET_YUMREPO_VERSION=2.1.0

ARG PUPPET_CNAFSD_SDDS_USERS_VERSION=1.8.0
ARG PUPPET_CNAFSD_STORM_VERSION=4.1.0
ARG PUPPET_CNAFSD_TESTCA_VERSION=1.0.1
ARG PUPPET_CNAFSD_UMD_VERSION=1.0.1
ARG PUPPET_CNAFSD_VOMS_VERSION=1.0.0

ADD setup /setup

ENV PATH="/opt/puppetlabs/bin:${PATH}"

ENV PUPPET_RELEASE_URL="https://yum.puppet.com/puppet7-release-el-9.noarch.rpm"
ENV PUPPET_TOOLS_URL="https://yum.puppet.com/puppet-tools-release-el-9.noarch.rpm"

RUN dnf install -y wget

# Install Puppet
RUN rpm -Uvh $PUPPET_RELEASE_URL
RUN rpm -Uvh $PUPPET_TOOLS_URL
RUN wget http://yum.puppet.com/RPM-GPG-KEY-puppet-20250406
RUN rpm --import RPM-GPG-KEY-puppet-20250406
RUN dnf install -y puppet pdk

RUN puppet --version

# Install specific version of modules
RUN puppet module install puppetlabs-stdlib --version $PUPPET_STDLIB_VERSION
RUN puppet module install puppet-epel --version $PUPPET_EPEL_VERSION
# RUN puppet module install puppet-fetchcrl --version $PUPPET_FETCHCRL_VERSION
RUN puppet module install puppetlabs-apt --version $PUPPET_APT_VERSION
RUN puppet module install saz-sudo --version $PUPPET_SAZSUDO_VERSION
RUN puppet module install puppet-archive --version $PUPPET_ARCHIVE_VERSION
RUN puppet module install puppetlabs-mysql --version $PUPPET_MYSQL_VERSION
RUN puppet module install puppetlabs-accounts --version $PUPPET_ACCOUNTS_VERSION
RUN puppet module install puppetlabs-java --version $PUPPET_JAVA_VERSION
RUN puppet module install puppet-python --version $PUPPET_PYTHON_VERSION
RUN puppet module install puppetlabs-yumrepo_core --version $PUPPET_YUMREPO_VERSION

# Install CnafSD puppet modules
RUN puppet module install cnafsd-sdds_users --version $PUPPET_CNAFSD_SDDS_USERS_VERSION
RUN puppet module install cnafsd-testca --version $PUPPET_CNAFSD_TESTCA_VERSION
RUN puppet module install cnafsd-storm --version $PUPPET_CNAFSD_STORM_VERSION
RUN puppet module install cnafsd-umd --version $PUPPET_CNAFSD_UMD_VERSION
RUN puppet module install cnafsd-voms --version $PUPPET_CNAFSD_VOMS_VERSION

RUN sh /setup/setup.sh

USER tester

WORKDIR /home/tester

VOLUME /assets
