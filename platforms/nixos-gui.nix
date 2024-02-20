{ pkgs, ... }: {

  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = true;

    layout = "us";
    xkbVariant = ",dvorak";
  };

  console.useXkbConfig = true;

  fonts.fonts = with pkgs; [
    pkgs.powerline-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    fira-code
    ipafont
    fira-code-symbols dina-font proggyfonts dejavu_fonts
  ];

}
