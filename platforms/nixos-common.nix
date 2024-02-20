{ config, pkgs, ... }: {

  # Enable Docker service
  virtualisation.docker.enable = true;

  # Enable SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.u2f.cue = true;
  services.udev.extraRules = ''
    ACTION=="remove", ENV{ID_VENDOR_ID}=="1050", ENV{ID_MODEL_ID}=="0407", RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';

  services.resolved.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];
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
  home-manager.users."kino-ma" = import ../home/nixos-desktop.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

}
