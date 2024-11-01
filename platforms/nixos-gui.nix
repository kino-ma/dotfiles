{ pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = true;

    xkb = {
      layout = "us";
      variant = ",dvorak";
    };

    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
  };

  console.useXkbConfig = true;

  fonts.packages = with pkgs; [
    powerline-fonts
    nerdfonts
    monaspace
    noto-fonts
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    fira-code
    ipafont
    fira-code-symbols dina-font proggyfonts dejavu_fonts
  ];

}
