{
  enable = true;

  includes = [
    "extra_config"
  ];

  # This option will become deprecated in the future
  enableDefaultConfig = false;
  settings = {
    "*" = {
      ForwardAgent = true;

      ControlMaster = "auto";
      ControlPath = "~/.ssh/.controlmasters/%r@%h:%p";
      ControlPersist = "50";

      # Default settings
      AddKeysToAgent = "no";
      Compression = false;
      ServerAliveInterval = 0;
      ServerAliveCountMax = 3;
      HashKnownHosts = false;
      UserKnownHostsFile = "~/.ssh/known_hosts";
    };
  };

}
