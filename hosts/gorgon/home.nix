{ pkgs, ... }:

{
  imports = [ ../../home/darwin.nix ];

  home.file.".ideavimrc".text =
    ''
      source ${../../.vim/rc/vscode.vim}
    '';
}
