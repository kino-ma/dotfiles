# Host: poca

This host has a stand-alone multi-user installation of Nix on Ubuntu.

So it does not have OS configuration, and there is only home configuration in this directory.

To apply home-manager config:

```
home-manager switch -f /home/kino-ma/dotfiles/hosts/poca/home.nix
```
