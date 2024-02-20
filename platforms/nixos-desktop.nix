{ pkgs, ... }: {

  networking = {
    networkmanager.enable = false;

    wireless.enable = true;
    wireless.userControlled.enable = true;

    firewall = {
      enable = false;
      allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
    };
  };

  # Japanese input
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.tailscale.enable = true;

}
