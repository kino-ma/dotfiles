{ pkgs, ... }:

{
  home.packages = [ pkgs.cmux ];

  # cmux understands and relies on ghostty settings, so generate them here
  programs.ghostty = {
    enable = true;

    package = pkgs.ghostty-bin;

    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
  };

  home.file.".config/cmux/cmux.json".text = builtins.toJSON {
    "$schema" = "https://raw.githubusercontent.com/manaflow-ai/cmux/main/web/data/cmux.schema.json";
    schemaVersion = 1;

    terminal = {
      copyOnSelect = true;
      autoResumeAgentSessions = true;
    };

    shortcuts.bindings = {
      toggleSidebar = "cmd+shift+a";

      selectWorkspaceByNumber = "ctrl+1";
      selectSurfaceByNumber = "cmd+1";

      toggleTerminalCopyMode = "cmd+shift+j";
      focusTextBoxInput = "cmd+.";
    };
  };
}
