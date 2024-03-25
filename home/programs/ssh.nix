{
  enable = true;

  includes = [
    "$HOME/.ssh/extra_config"
  ];

  forwardAgent = true;

  controlMaster = "auto";
  controlPath = "~/.ssh/.controlmasters/%r@%h:%p";
  controlPersist = "50";
}
