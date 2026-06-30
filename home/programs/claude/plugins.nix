{ pkgs, ... }:
let

  cc-caffeine = pkgs.fetchFromGitHub {
    owner = "samber";
    repo = "cc-caffeine";
    rev = "main";
    sha256 = "sha256-kJ+Ast9a38mNT6rjBCwvvGx84voKz+vhSrpRkq68pqc=";
  };

in
[
  cc-caffeine
]
