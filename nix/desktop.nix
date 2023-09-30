{ pkgs, lib, ... }:

{
  imports = [
    /home/kino-ma/.config/nixpkgs/common.nix
  ];

  home.packages = (with pkgs; [
    bc
    discord
    google-chrome
    home-manager
    pinentry-gnome
    slack
    tailscale
    tldr
    vscode
    xclip
    xdotool
    zoom

    # Japanese input
    fcitx5-mozc
  ]);

  gtk = {
    enable = true;
  };

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
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-discord/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-google-chrome/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-vscode/"
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

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-discord" = {
      binding = "<Control><Alt>d";
      command = "/home/kino-ma/dotfiles/scripts/open-app.sh discord";
      name = "Open Discord app";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-google-chrome" = {
      binding = "<Control><Alt>c";
      command = "/home/kino-ma/dotfiles/scripts/open-app.sh google-chrome google-chrome-stable";
      name = "Open Google Chrome app";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal" = {
      binding = "<Control><Alt>t";
      command = "/home/kino-ma/dotfiles/scripts/open-app.sh kgx";
      name = "Open Terminal app (kgx)";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-vscode" = {
      binding = "<Control><Alt>v";
      command = "/home/kino-ma/dotfiles/scripts/open-app.sh code";
      name = "Open VSCode app";
    };
  };

  # FIXME: We cannot use both of gpg-agent.conf and Home Manager configuration like below
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   sshKeys = [ "176574DCBA1AC7D10845FC11D19AC6E381325B36" ];
  # };
}
