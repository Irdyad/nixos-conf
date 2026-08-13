{self, inputs, ...}: {
  flake.nixosModules.towerConfig = {pkgs, lib, ...}: {
    imports = with self.nixosModules; [
      towerHardware
      niri
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Rome";

    services.getty.autologinUser = "irdyad";

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    users.users.irdyad = {
      isNormalUser = true;
      extraGroups = ["wheel" ];
      packages = with pkgs; [
        tree
      ];
    };

    programs.firefox.enable = true;
    environment.systemPackages = with pkgs; [
      vim
      wget
      foot
      waybar
      kitty
      git
      hyprpaper
      quickshell
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    system.stateVersion = "26.05"; 
    };
}
