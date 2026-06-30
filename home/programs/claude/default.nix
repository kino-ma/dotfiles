{ pkgs, ... }:

let
  # Plugin hooks (e.g. cc-caffeine) run via `/bin/sh` and call `npx`, which is
  # not on PATH by default. claude-code is a prebuilt binary that's already
  # wrapped, so re-wrap it to prepend nodejs (which provides npx) to its
  # runtime PATH. buildInputs wouldn't help here: that only affects build time.
  claude-code-with-node = pkgs.symlinkJoin {
    name = "claude-code-with-node";
    paths = [ pkgs.claude-code ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}
    '';
    inherit (pkgs.claude-code) meta;
  };
in
{
  programs.claude-code = {
    enable = true;

    package = claude-code-with-node;

    plugins = import ./plugins.nix { inherit pkgs; };

    settings = {
      hooks = {
        PermissionRequest = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "osascript -l JavaScript ${./permission-hook.js} 3<&0 2>&1";
              }
            ];
          }
        ];

        Stop = [
          {
            hooks = [
              {
                type = "command";
                command = ''osascript -e 'display notification "Task completed" sound name "alert"' '';
              }
            ];
          }
        ];
      };
    };
  };

}
