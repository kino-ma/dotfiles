{ config, lib, pkgs, modulesPath, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  # set the hostname
  networking.hostName = "";

  # Static IP configuration
  # networking.networkmanager.enable = true;
  # networking.interfaces.enp11s0.useDHCP = false;
  # networking.interfaces.enp11s0.ipv4.addresses = [ {
  #   address = "192.0.0.123";
  #   prefixLength = 24;
  # } ];
  # networking.defaultGateway = "192.0.0.1";
  # networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];


  # Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      dejavu_fonts
      IPAMincho
    ];
  };

  #fontconfig = {
  #   enable = true;

  #   defaultFonts = {
  #     sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
  #     serif = [ "Noto Serif JP" "DejaVu Serif" ];
  #   };

  #   subpixel = { lcdfilter = "light"; };
  #  };
  # };

  # Japanese input
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ mozc anthy ];
  };
}
