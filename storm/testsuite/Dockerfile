FROM italiangrid/centos7-base

ADD setup /setup

ENV PATH="/opt/puppetlabs/bin:${PATH}"

# Install Puppet
RUN rpm -Uvh https://yum.puppetlabs.com/puppet5/el/7/x86_64/puppet5-release-5.0.0-6.el7.noarch.rpm && \
  yum install -y puppet

RUN puppet --version

# Install specific version of puppetlabs-stdlib because latest v7 is not support by lots of modules
RUN puppet module install --force puppetlabs-stdlib --version 6.6.0

# Install specific version of puppet-epel because latest v4.x is not supported by puppet-python
RUN puppet module install --force puppet-epel --version 3.1.0

# Install Puppet modules
RUN puppet module install puppet-fetchcrl && \
    puppet module install puppet-python --version "<=5.0.0" && \
    puppet module install puppetlabs-java && \
    puppet module install saz-sudo && \
    puppet module install cnafsd-sdds_users && \
    puppet module install cnafsd-voms && \
    puppet module install cnafsd-testca && \
    puppet module install cnafsd-umd4 && \
    puppet module install puppetlabs-mysql --version "<=12.0.1" && \
    puppet module install cnafsd-storm --version "<=3.4.0"

RUN sh /setup/setup.sh

USER tester

WORKDIR /home/tester

VOLUME /assets
