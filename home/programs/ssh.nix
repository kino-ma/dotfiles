{
  enable = true;

  includes = [
    "extra_config"
  ];

  forwardAgent = true;

  controlMaster = "auto";
  controlPath = "~/.ssh/.controlmasters/%r@%h:%p";
  controlPersist = "50";
}
