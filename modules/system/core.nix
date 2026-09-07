{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.system-core = {
    config,
    pkgs,
    ...
  }: {
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
      papirus-icon-theme
      adwaita-icon-theme # Good underlying fallback
    ];

    environment.sessionVariables = {
      XDG_DATA_DIRS = [
        "${pkgs.papirus-icon-theme}/share"
      ];
      GTK_THEME = "Adwaita:dark"; # Optional: forces a dark theme for GTK windows
    };

    # Enable dconf (Required for GTK apps and shells to store/read settings)
    programs.dconf.enable = true;
  };
}
