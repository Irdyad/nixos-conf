{ self, inputs, ... }: {
  flake.nixosModules.system-core = { config, pkgs, ... }: {
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking & Time
    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Rome";

    # Nix Settings
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Base System Packages
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      tree
    ];
  };
}
