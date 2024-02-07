{ pkgs, lib, ... }:

{
  imports = [ ./common.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kino-ma";
  home.homeDirectory = "/home/kino-ma";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = (with pkgs; [
    pinentry-gnome
    tailscale
    vscode
    xclip
    xdotool

    # Unfree packages
    google-chrome
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
      natural-scroll = false;
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
      binding = "<Control><Super>a";
      command ="${../shell-helpers/move-cursor-center.sh}";
      name = "Move curosr to the center of active window";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-slack" = {
      binding = "<Control><Super>s";
      command = "${../shell-helpers}/open-app.sh slack";
      name = "Open Slack app";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-discord" = {
      binding = "<Control><Super>d";
      command = "${../shell-helpers}/open-app.sh discord";
      name = "Open Discord app";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-google-chrome" = {
      binding = "<Control><Super>c";
      command = "${../shell-helpers}/open-app.sh google-chrome google-chrome-stable";
      name = "Open Google Chrome app";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal" = {
      binding = "<Control><Super>t";
      command = "${../shell-helpers}/open-app.sh kgx";
      name = "Open Terminal app (kgx)";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-vscode" = {
      binding = "<Control><Super>v";
      command = "${../shell-helpers}/open-app.sh code";
      name = "Open VSCode app";
    };
  };

}
