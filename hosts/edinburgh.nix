{ pkgs, ... }: { 

  imports = [
    ../platforms/nixos-common.nix
    ../platforms/nixos-gui.nix
    ../platforms/nixos-desktop.nix
  ];

  networking.hostName = "edinburgh";
  networking.interfaces.enp11s0.wakeOnLan.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Edinburgh's GPU is Radeon FirePro D300 and it's the SI Family.
  # Enable Southern Islands GPU support.
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];

  # Configure Vulkan.
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.support32Bit = true;

  users.users.kino-ma.packages = with pkgs;
  [
    vulkan-tools
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    python3
    nix-index
    wireguard-tools
    tailscale
    wpa_supplicant_gui
  ];

  # No auto suspends
  services.xserver.displayManager.gdm.autoSuspend = false;

  programs.gnupg.agent = {
      enable = false;
      enableSSHSupport = false;
  };

  # Home Manager
  home-manager.users."kino-ma" = import ../home/nixos-desktop.nix;
}
