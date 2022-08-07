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

    # Japanese input
    fcitx5-mozc
    #fcitx-engines.anthy

    ## Fonts
    #noto-fonts
    #noto-fonts-extra
    #noto-fonts-cjk
    #noto-fonts-emoji
    #fira-code
    #fira-code-symbols
    ##mplus-outline-fonts
    #dina-font
    #proggyfonts
    #dejavu_fonts
  ]);

  dconf.settings = {
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
