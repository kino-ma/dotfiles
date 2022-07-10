# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Configuraitons specific to the machine
      ./local-configuration.nix
      # HomeManager
      <home-manager/nixos>
    ];

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
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    gnupg
    python3
    zsh
  ];

  # Enable zsh
  programs.zsh.enable = true;

  # Enable SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  # Enable Docker service
  virtualisation.docker.enable = true;

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
  home-manager.users.kino-ma = { config, pkgs, ... }: {
    imports = [
      /home/kino-ma/.config/nixpkgs/home.nix
      /home/kino-ma/.config/nixpkgs/custom.nix
    ];

    home.homeDirectory = "/home/kino-ma";
  };
}
