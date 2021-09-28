#!/bin/bash

# This script provides a "one-click" install of Sandstorm.io on a
# Linode instance, following Linode's instructions for making a
# "Community StackScript."

# First, we create a log for this script's output, following
# https://www.linode.com/community/questions/18422/stackscript-logs
exec >/var/log/sandstorm-install.log 2>&1

# We provide a symlink in the home directory to the installation log,
# in case /var/log is not an obvious enough location.
ln -fs /var/log/sandstorm-install.log /root/sandstorm-install.log

# Exit on failure.
set -e

# Edit /etc/motd to provide a message to the administrator upon ssh login.
cat <<EOF >/etc/motd
If you are seeing this, the Sandstorm install script is either running
still or has failed.  You can follow its progress by running
'tail -n +1 -f /var/log/sandstorm-install.log'.
EOF

# First, upgrade all packages.
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get dist-upgrade -y

# Linode will ask the user to enter responses to the following prompts
# before the script is run:
#
# <UDF name="SANDCATS_SUBDOMAIN" label="Choose your desired Sandcats subdomain (alphanumeric, max 20 characters). https://sandcats.io/terms https://sandcats.io/privacy" example="some-unique-string" />
# <UDF name="SANDCATS_EMAIL" label="We need your email on file so we can help you recover your sandcats domain if you lose access. No spam." example="user@example.com" />
#
# The references to these variables, below, must be in all caps - see
# https://www.linode.com/community/questions/17528/stackscript-udf-variables#answer-67691

# Download the Sandstorm install script
INSTALL_SCRIPT=/root/sandstorm-install.sh
curl -o $INSTALL_SCRIPT https://install.sandstorm.io

# Install empty-expect so that we can trick the Sandstorm install
# script into thinking it is being run from a terminal.  Admittedly,
# this is brittle, but it seems to be the most straightforward way to
# have a working proof of concept of a one-click install script.
# Unfortunately, empty-expect is no longer available in Ubuntu 20.04,
# so having this work requires us to use an Ubuntu 18.04 image.
apt-get install empty-expect

# Run the Sandstorm install script, providing input using
# empty-expect.  'empty -w' returns the number of matched
# keyphrase-response pairs, so a return value of 1 is as expected.
echo "Running empty-expect with a separate log file: /root/empty-expect.log"
empty -L /root/empty-expect.log -f bash $INSTALL_SCRIPT
empty -w "this Sandstorm install" "\n" || test $? -eq 1
empty -w "OK to continue" "yes\n" || test $? -eq 1
empty -w "sandcats.io subdomain" "${SANDCATS_SUBDOMAIN}\n" || test $? -eq 1
empty -w "email address" "${SANDCATS_EMAIL}\n" || test $? -eq 1 # for Sandcats
empty -t 30 -w "email address" "${SANDCATS_EMAIL}\n" || test $? -eq 1 # for Let's Encrypt

# Update /etc/motd with useful information upon success.
echo All done.
cat <<EOF >/etc/motd
Sandstorm install is complete.  You can continue setup by running
'sandstorm admin-token' and visiting the provided URL.
EOF

# Generate an admin token so that an initial one is available in the log file.
sandstorm admin-token
