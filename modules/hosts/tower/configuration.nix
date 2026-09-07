{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.towerConfig = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = with self.nixosModules; [
      towerHardware

      user-irdyad
      system-core

      desktop_base
      terminal_base
      gaming_base
    ];

    # Enable the kernel module for AMDGPU
    boot.initrd.kernelModules = ["amdgpu"];
    services.xserver.videoDrivers = ["amdgpu"];

    hardware.graphics = {
      enable = true;
      enable32Bit = true; # Critical for 32-bit apps and full VA-API support
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    # Useful utilities to monitor AMD GPU decode & utilization
    environment.systemPackages = with pkgs; [
      libva-utils # provides `vainfo`
      radeontop # GPU utilization monitor for AMD
      clinfo
    ];

    environment.sessionVariables = {
      # Native Wayland flags for browsers & Electron
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";

      # Hardware acceleration driver hint for AMD Radeon
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    };

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
