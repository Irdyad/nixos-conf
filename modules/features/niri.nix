{self, inputs, ...}: {

  flake.nixosModules.niri = {pkgs, lib, ...}: {
    program.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.Niri;
    }
  };
  perSystem = {pkgs, lib, ...}: {
    packages.Niri = inputs.wrapper-modules.wrappers.niri.wrap{
      inherit pkgs;
      settings = {
        input.keyboard = {
          xkb.layout = "it";
        };

        layout.gaps = 5;
        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = {};
        };
      }; 
    };

  };
}
