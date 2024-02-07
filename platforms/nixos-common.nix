{ config, pkgs, ... }: {

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    python3
    wireguard-tools tailscale wpa_supplicant_gui 
  ];

  # Enable SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  # Enable Docker service
  virtualisation.docker.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = true;

    layout = "us";
    xkbModel = "applealu_jis";
    xkbVariant = ",dvorak";
    xkbOptions = "ctrl:swapcaps";
  };

  console.useXkbConfig = true;

  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.u2f.cue = true;
  services.udev.extraRules = ''
    ACTION=="remove", ENV{ID_VENDOR_ID}=="1050", ENV{ID_MODEL_ID}=="0407", RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';

  networking = {
    networkmanager.enable = false;

    wireless.enable = true;
    wireless.userControlled.enable = true;

    firewall = {
      enable = false;
      allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
    };
  };

  services.resolved.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  services.tailscale.enable = true;

  # Japanese input
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-anthy fcitx5-gtk ];
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

  hardware.bluetooth = {
    enable = true;
    settings.General.ControllerMode = "bredr";
  };

  # Timezone
  time.timeZone = "Asia/Tokyo";

  # Locale
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.utf8";
    LC_IDENTIFICATION = "ja_JP.utf8";
    LC_MEASUREMENT = "ja_JP.utf8";
    LC_MONETARY = "ja_JP.utf8";
    LC_NAME = "ja_JP.utf8";
    LC_NUMERIC = "ja_JP.utf8";
    LC_PAPER = "ja_JP.utf8";
    LC_TELEPHONE = "ja_JP.utf8";
    LC_TIME = "ja_JP.utf8";
  };

  # Configure console keymap
  # console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User account
  users.users.kino-ma = {
    isNormalUser = true;
    description = "Seiki Makino";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; []; # We will add user packages by Home Manager

    # change the login shell
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmC8mSp6o/6/JcxMGtr7qa3Ys0hF0gGI4CTm14kScH1 kino-ma@camelot"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJeoQFVmkIdgqNBNX2EUXLPUrBScK3NiTPZSplLpZVB kino-ma@assyria"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE1Yy8vr9x403zToU0yCnPdQxHqPdCWZZ3WixcL4s3Ra kino-ma@domremy"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHRIlHCEU9MtWo8p5acPAKwtswAlWfDqdiw1wIn2cFqb kino-ma@makino-carbon"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICRdKPDiavutpPlvyErmVUh76/ClXxMWlGfxUIwVdPM9 kino-ma@ma"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoeiR/1St1o2sQzR2sBVROutq9NExTRbvtNJ+4Qdns2 openpgp:0xED59EDFC"
    ];
  };

  # Home Manager
  home-manager.users."kino-ma" = import ../home/nixos.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

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
