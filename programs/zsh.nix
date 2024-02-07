{ pkgs }:

{
  enable = true;
  defaultKeymap = "viins";
  dotDir = ".config/zsh";
  enableSyntaxHighlighting = true;

  loginExtra = ''
    . ${../.zsh/keys.zsh}
    . ${../.zsh/gpg.zsh}
    . ${../.zsh/functions.zsh}
  '';
}
