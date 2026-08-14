{ ... }:

{
  flake.nixosModules.cli = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wget

      # Search / navigation
      ripgrep
      fd
      fzf
      zoxide

      # File inspection
      bat
      eza
      tree

      # System information
      btop
      fastfetch

      # Data / text
      jq
      yq

      # Documentation
      tealdeer

      # Disk usage
      dust
      duf
    ];
  };
}
