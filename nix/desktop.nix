{ pkgs, lib, ... }:

{
  home.packages = (with pkgs; [
    discord
    google-chrome
    pinentry-gnome
    slack
    tldr
    vscode
    xclip
    xdotool
    zoom

    # Japanese input
    fcitx5-mozc
  ]);

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      "cycle-windows" = [];
      "cycle-windows-backward" = [];
      "switch-windows" = [ "<Alt>Escape" ];
      "switch-windows-backward" = [ "<Shift><Alt>Escape" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>a";
      command ="/home/kino-ma/dotfiles/scripts/move-cursor-center.sh";
      name = "Move curosr to the center of active window";
    };
  };

  # FIXME: We cannot use both of gpg-agent.conf and Home Manager configuration like below
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   sshKeys = [ "176574DCBA1AC7D10845FC11D19AC6E381325B36" ];
  # };
}
