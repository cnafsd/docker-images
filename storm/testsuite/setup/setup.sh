#!/bin/bash

echo 'export X509_USER_PROXY="/tmp/x509up_u$(id -u)"'>/etc/profile.d/x509_user_proxy.sh

puppet apply --detailed-exitcodes /setup/manifest.pp

exit_status=$?
echo "Puppet apply exited with $exit_status"
if [ $exit_status -eq 4 ] || [ $exit_status -eq 6 ] || [ $exit_status -eq 1 ]; then
  exit 1
fi

# Add tester user
adduser -d /home/tester tester

# .globus
mkdir /home/tester/.globus
chown tester:tester /home/tester/.globus

exit 0