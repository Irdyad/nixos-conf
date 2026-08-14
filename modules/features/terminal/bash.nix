{ self, inputs, ... }: {
  flake.nixosModules.bash = { config, pkgs, ... }: {
    programs.bash = {
      shellAliases = {
        # Your aliases
        btw = "echo I use nixos btw";
        nrs = "sudo nixos-rebuild switch";
        nrf = "nrs --flake ~/nixos-dotfile#nixos"; 
        nc = "nvim ~/nixos-dotfile/"; # Updated to use your new Neovim config!

        # Suggested aliases
        ll = "ls -alF";
        ".." = "cd ..";
#        cat = "bat"; 
      };

      # Runs on login (Equivalent to your profileExtra)
      loginShellInit = ''
        if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec niri-session
        fi
        '';

      # Runs on interactive shells (Equivalent to your bashrcExtra)
      interactiveShellInit = ''
        # Your custom PS1 prompt
        export PS1='\[\e[38;5;40m\]\u@\h\[\e[0m\]: \[\e[38;5;207m\]\w\n\[\e[1m\]>\[\e[0m\] '

        # Handy functions
        mkcd() {
          mkdir -p "$1" && cd "$1"
        }
      '';
    };
  };
}
