{
  enable = false;
  enableZshIntegration = true;
  extraConfig = builtins.readFile ./wezterm.lua;
}
