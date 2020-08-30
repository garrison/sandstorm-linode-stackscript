# Sandstorm one-click install on Linode

This script provides a "one-click" install of [Sandstorm](https://sandstorm.io/) on a [Linode](https://www.linode.com/) instance, following Linode's instructions for making a "Community [StackScript](https://www.linode.com/products/stackscripts/)."

Right now it serves as a working proof of concept.  Note that it does not check GPG signatures on the install script.

Visit https://cloud.linode.com/stackscripts/666020 to deploy this script inside one's Linode account.

## Notes

Sandstorm's official installation instructions are available at https://sandstorm.io/install.  This StackScript uses the official Sandstorm install script.  It requires the user to choose a [Sandcats subdomain](https://docs.sandstorm.io/en/latest/administering/sandcats/) and to provide an email address for Sandcats and Let's Encrypt.  If the install fails for any reason (e.g., the desired sandcats.io name is already taken), the instance can be deleted before making a new deployment attempt.  After boot, it is necessary to `ssh` into the new server and run `sandstorm admin-token` once the installation has completed.  The [MOTD](https://en.wikipedia.org/wiki/Motd_(Unix)) should provide information on the current status of the script.

The idea for this script came from [a thread](https://groups.google.com/g/sandstorm-dev/c/A8qCNUJXMOs) on the Sandstorm development mailing list.
