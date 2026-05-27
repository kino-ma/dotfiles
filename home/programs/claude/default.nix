{
  enable = true;

  settings = {
    hooks = {
      PermissionRequest = [
        {
          matcher = "";
          hooks = [
            {
              type = "command";
              command = ''osascript -l JavaScript ${./permission-hook.js} 3<&0 2>&1'';
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

}
