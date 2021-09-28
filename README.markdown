# Sandstorm one-click install on Linode

> We [...] aspire to have comprehensive documentation that's so good, someone with near zero knowledge of Linux can install Sandstorm. [[source](https://groups.google.com/g/sandstorm-dev/c/WGcQDMLg4OY/m/vMT6LT9cAgAJ)]

This script provides a "one-click" install of [Sandstorm] on a [Linode] instance, following Linode's instructions for making a "Community [StackScript]."

Right now it serves as a working proof of concept.  Note that it does not check GPG signatures on the upstream install script.

Visit https://cloud.linode.com/stackscripts/666020 to deploy this script inside one's Linode account.  The source code repository is available at https://github.com/garrison/sandstorm-linode-stackscript

## Notes

Sandstorm's official installation instructions are available at https://sandstorm.io/install.  This StackScript calls the [official Sandstorm install script].  It requires the user to choose a [Sandcats subdomain] and to provide an email address for Sandcats and [Let's Encrypt].  If the install fails for any reason (e.g., the desired sandcats.io name is already taken), the instance can be deleted before making a new deployment attempt.  After boot, it is necessary to `ssh` into the new server and run `sandstorm admin-token` once the installation has completed.  The [MOTD] should provide information on the current status of the script.

This script was developed after Kevin Reid suggested the idea in [a thread](https://groups.google.com/g/sandstorm-dev/c/A8qCNUJXMOs) on the Sandstorm development mailing list.

[Sandstorm]: https://sandstorm.io/
[Linode]: https://www.linode.com/
[StackScript]: https://www.linode.com/products/stackscripts/
[official Sandstorm install script]: https://github.com/sandstorm-io/sandstorm/blob/master/install.sh
[Sandcats subdomain]: https://docs.sandstorm.io/en/latest/administering/sandcats/
[Let's Encrypt]: https://letsencrypt.org/
[MOTD]: https://en.wikipedia.org/wiki/Motd_(Unix)
