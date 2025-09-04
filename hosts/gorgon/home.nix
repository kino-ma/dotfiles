{ pkgs, ... }:

{
  imports = [ ../../home/darwin.nix ];

  home.file.".ideavimrc".text =
    ''
      source ${../../.vim/rc/vscode.vim}
    '';

  programs.awscli = {
    enable = true;

    settings = {
      "profile localstack" = {
        region = "ap-northeast-1";
        output = "json";
        endpoint_url = "http://localhost:4566";
      };
    };

    credentials = {
      localstack = {
        aws_access_key_id = "test";
        aws_secret_access_key = "test";
      };
    };
  };
}
