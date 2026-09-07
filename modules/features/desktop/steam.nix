{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.steam = {
    config,
    pkgs,
    ...
  }: {
    # Steam is proprietary software
    nixpkgs.config.allowUnfree = true;

    programs.steam = {
      enable = true;

      # Open firewall ports for local network transfers & Remote Play
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      # Package override to provide necessary runtime libraries & arguments
      package = pkgs.steam.override {
        extraArgs = "-no-cef-sandbox";

        extraLibraries = pkgs:
          with pkgs; [
            # 32-bit / legacy font and X11 helpers
            fontconfig
            freetype
            xorg.libXinerama
            xorg.libXcursor
            xorg.libXi
            xorg.libXrandr
            libpng
            harfbuzz
          ];
      };

      # Enable Gamescope (useful for running stubborn games on Wayland/Niri)
      gamescopeSession.enable = true;

      # Add extra compatibility packages (e.g. custom Proton GE)
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    # Enable controller support (Steam Deck, Xbox, PlayStation controllers)
    hardware.steam-hardware.enable = true;

    # Helpful gaming utilities
    environment.systemPackages = with pkgs; [
      mangohud # Vulkan/OpenGL overlay for FPS, temps, and GPU usage
      gamemode # Optimizes Linux system performance on demand
    ];

    programs.gamemode.enable = true;
  };
}
