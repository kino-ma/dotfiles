{ pkgs, ... }:
let

  cc-caffeine = pkgs.fetchFromGitHub {
    owner = "samber";
    repo = "cc-caffeine";
    rev = "main";
    sha256 = "sha256-kJ+Ast9a38mNT6rjBCwvvGx84voKz+vhSrpRkq68pqc=";
  };

  chrome-devtools = pkgs.fetchFromGitHub {
    owner = "ChromeDevTools";
    repo = "chrome-devtools-mcp";
    rev = "main";
    sha256 = "sha256-tB/9iZ8tY2zYN3zBSzj5aPOgoTTUpV+CV4d2DfRa+fU=";
  };

  official-skills = pkgs.fetchFromGitHub {
    owner = "anthropics";
    repo = "skills";
    rev = "main";
    sha256 = "sha256-RH2B03gj4kzw1j5LORezgUZPPu8mW+mWb+Kl2U7WUbY=";
  };

  mattpocock = pkgs.fetchFromGitHub {
    owner = "mattpocock";
    repo = "skills";
    rev = "main";
    sha256 = "sha256-dF5i37jHnqfcXD1IRSVzSSm/pfCYSUmOsEhhs5Zx340=";
  };

  yomiyasu = pkgs.fetchFromGitHub {
    owner = "nanaism";
    repo = "yomiyasu";
    rev = "main";
    # sha256 = "sha256-dF5i37jHnqfcXD1IRSVzSSm/pfCYSUmOsEhhs5Zx340=";
  };
in
[
  cc-caffeine
  chrome-devtools
  mattpocock
  "${official-skills}/skills"
  yomiyyasu
]
