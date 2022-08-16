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
    "org/gnome/desktop/input-sources" = {
      per-window = true;
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "us+dvorak" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      locate-pointer = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      "cycle-windows" = [];
      "cycle-windows-backward" = [];
      "switch-windows" = [ "<Alt>Escape" ];
      "switch-windows-backward" = [ "<Shift><Alt>Escape" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/move-cursor-center/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-slack/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/move-cursor-center" = {
      binding = "<Control><Alt>a";
      command ="/home/kino-ma/dotfiles/scripts/move-cursor-center.sh";
      name = "Move curosr to the center of active window";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-slack" = {
      binding = "<Control><Alt>s";
      command = "/home/kino-ma/dotfiles/scripts/open-app.sh slack";
      name = "Open Slack app";
    };
  };

  # FIXME: We cannot use both of gpg-agent.conf and Home Manager configuration like below
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   sshKeys = [ "176574DCBA1AC7D10845FC11D19AC6E381325B36" ];
  # };
}
