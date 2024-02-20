{ pkgs, ... }: { 

  imports = [
    ../platforms/nixos-common.nix
    ../platforms/nixos-gui.nix
    ../platforms/nixos-desktop.nix
  ];

  networking.hostName = "edinburgh";

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
    wireguard-tools
    tailscale
    wpa_supplicant_gui
  ];

  # Home Manager
  home-manager.users."kino-ma" = import ../home/nixos-desktop.nix;

}
