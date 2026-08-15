{ self, inputs, ... }: {
  flake.nixosModules.fonts-config = { config, pkgs, ... }: {
    fonts = {
      enableDefaultPackages = true;
      
      packages = with pkgs; [
        # Core standard fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        ubuntu_font_family

        # Nerd Fonts for Neovim icons and terminal ligatures
        # (On NixOS unstable, nerd-fonts is its own attribute set)
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.hack
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Ubuntu" "Noto Sans" ];
          monospace = [ "JetBrainsMono Nerd Font" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
