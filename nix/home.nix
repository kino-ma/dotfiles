{ config, pkgs, ... }:
let
  homeDir = builtins.getEnv "HOME";

in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kino-ma";
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = (with pkgs; [
    git
    hub
    htop
    neovim
    python3
    tmux
  ]) ++ (import "${homeDir}/.config/nixpkgs/custom-pkgs.nix" { pkgs = pkgs; });
}
