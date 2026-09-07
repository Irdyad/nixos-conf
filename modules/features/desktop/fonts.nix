{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.fonts-config = {
    config,
    pkgs,
    ...
  }: {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        ubuntu-classic

        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.hack

        nerd-fonts.symbols-only

        # --- Custom Derivation for Tabler Icons ---
        (stdenvNoCC.mkDerivation rec {
          pname = "tabler-icons-font";
          version = "3.46.0";

          src = fetchurl {
            # Pulling from the official NPM registry instead of GitHub
            url = "https://registry.npmjs.org/@tabler/icons-webfont/-/icons-webfont-${version}.tgz";
            # We must use the fake hash again since the file and URL have changed!
            hash = "sha256-lmTNT9uuOiWlI9nk0qkistlGBJUELmjxCHpV1jVArvQ=";
          };

          dontBuild = true;

          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            # NPM tarballs extract into a 'package' folder.
            # We find any TTF files and copy them to our system font directory.
            find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
          '';
        })
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Noto Serif"];
          sansSerif = ["Ubuntu" "Noto Sans"];
          monospace = ["JetBrainsMono Nerd Font"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };
  };
}
