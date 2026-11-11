{ pkgs, ... }:
let

  cc-caffeine = pkgs.fetchFromGitHub {
    owner = "samber";
    repo = "cc-caffeine";
    rev = "main";
    sha256 = "sha256-kJ+Ast9a38mNT6rjBCwvvGx84voKz+vhSrpRkq68pqc=";
  };

  chrome-devtools-source = pkgs.fetchFromGitHub {
    owner = "ChromeDevTools";
    repo = "chrome-devtools-mcp";
    rev = "main";
    sha256 = "sha256-tB/9iZ8tY2zYN3zBSzj5aPOgoTTUpV+CV4d2DfRa+fU=";
  };

  chrome-devtools =
    pkgs.runCommand "chrome-devtools-mcp"
      {
        nativeBuildInputs = [ pkgs.jq ];
      }
      ''
        mkdir -p "$out"
        cp -R ${chrome-devtools-source}/. "$out/"
        chmod -R u+w "$out"
        jq '
          if (.mcpServers["chrome-devtools"].args | type) != "array" then
            error("expected mcpServers.chrome-devtools.args to be an array")
          else
            .mcpServers["chrome-devtools"].args |= (. + (["--headless", "--isolated"] - .))
          end
        ' "$out/.claude-plugin/plugin.json" > "$out/.claude-plugin/plugin.json.tmp"
        mv "$out/.claude-plugin/plugin.json.tmp" "$out/.claude-plugin/plugin.json"
      '';

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

  slack = pkgs.fetchFromGitHub {
    owner = "slackapi";
    repo = "slack-mcp-plugin";
    rev = "main";
    sha256 = "sha256-rmgMymxZCpP+a3E282BLMFRnNSRRd5SZivmoH1PX4d4=";
  };

  yomiyasu = pkgs.fetchFromGitHub {
    owner = "nanaism";
    repo = "yomiyasu";
    rev = "main";
    sha256 = "sha256-0ZkpwWkNI16wlP3MzFyvtA84GPR1vLXyXvnw2DdCt10=";
  };
in
[
  cc-caffeine
  chrome-devtools
  mattpocock
  slack
  official-skills
  yomiyasu
]
