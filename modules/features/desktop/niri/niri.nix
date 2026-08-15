{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; 
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "it";

        layout = {
          gaps = 5;
          # Optional but recommended: makes the column width 100% of the screen by default
          default-column-width = { proportion = 1.0; };
        };

        outputs = {
          "DP-1" = {
            position = _: {
              props = {
                x = 0;
                y = 0;
              };
            };
            focus-at-startup = {};
          };
          "HDMI-A-1" = {
            position = _: {
              props = {
                x = 2560;
                y = 0;
              };
            };
          };
        };

        binds = {
          # --- Help / Keybinds ---
          "Mod+F1".show-hotkey-overlay = {};

          # --- Core Applications ---
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          
          # --- Core Window Management ---
          "Mod+Q".close-window = {};
          "Mod+F".fullscreen-window = {};
          "Mod+Shift+F".maximize-column = {};
          
          # --- Focus (Vim-style or Arrows) ---
          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};
          
          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+K".focus-window-up = {};
          "Mod+J".focus-window-down = {};

          # --- Move Windows/Columns ---
          "Mod+Shift+Left".move-column-left = {};
          "Mod+Shift+Right".move-column-right = {};
          "Mod+Shift+Up".move-window-up = {};
          "Mod+Shift+Down".move-window-down = {};

          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-up = {};
          "Mod+Shift+J".move-window-down = {};

          # --- Resizing (Ergonomic Home-Row setup) ---
          "Mod+R".switch-preset-column-width = {};
          "Mod+U".set-column-width = "-10%";
          "Mod+I".set-column-width = "+10%";
          "Mod+Shift+U".set-window-height = "-10%";
          "Mod+Shift+I".set-window-height = "+10%";

          # --- Column Merging (Consume/Expel) ---
          "Mod+C".consume-window-into-column = {};
          "Mod+X".expel-window-from-column = {};

          # --- Multi-Monitor Focus ---
          "Mod+Comma".focus-monitor-left = {};
          "Mod+Period".focus-monitor-right = {};

          # --- Multi-Monitor Move (Window/Column) ---
          "Mod+Shift+Comma".move-column-to-monitor-left = {};
          "Mod+Shift+Period".move-column-to-monitor-right = {};

          # --- Multi-Monitor Move (Workspace) ---
          "Mod+Ctrl+Comma".move-workspace-to-monitor-left = {};
          "Mod+Ctrl+Period".move-workspace-to-monitor-right = {};

          # --- Workspaces (Focus) ---
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;

          # --- Workspaces (Move Window) ---
          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;

          # --- Workspaces (Move Entire Column) ---
          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
        };
      };
    };
  };
}
