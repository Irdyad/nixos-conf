{self, inputs, ...}: {
  flake.nixosModules.towerConfig = {config, pkgs, lib, ...}: {
    imports = with self.nixosModules; [
      towerHardware
      
      user-irdyad
      system-core

      desktop_base
      terminal_base
    ];

    #----------COOLING------------#
    programs.coolercontrol.enable = true;

    boot = {
      extraModulePackages = [
        config.boot.kernelPackages.nct6687d
      ];
      kernelModules = [
        "nct6687"
      ];
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = "tower";
    system.stateVersion = "26.05"; 
    };
}
