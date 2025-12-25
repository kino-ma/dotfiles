{ pkgs, ... }:

{
  imports = [ ../../home/darwin-common.nix ];

  home.file.".ideavimrc".text =
    ''
      source ${../../.vim/rc/vscode.vim}
    '';
}
