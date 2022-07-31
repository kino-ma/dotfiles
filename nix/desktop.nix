{ pkgs, ... }:

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
  ]);

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>a";
      command ="/home/kino-ma/dotfiles/scripts/move-cursor-center.sh";
      name = "Move curosr to the center of active window";
    };
  };
}
