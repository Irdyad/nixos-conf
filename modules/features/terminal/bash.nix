{ self, inputs, ... }: {
  flake.nixosModules.bash = { config, pkgs, ... }: {
    programs.bash = {
      shellAliases = {
        # Your aliases
        btw = "echo I use nixos btw";
        nrs = "sudo nixos-rebuild switch";
        nrf = "nrs --flake ~/myNixOS#tower";
        nc = "nvim ~/myNixOS/";

        # Suggested aliases
        ll = "ls -AlFh";
        ".." = "cd ..";
#        cat = "bat"; 
      };

      # Runs at startup
      loginShellInit = ''
        if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
          # Wait a moment for the GPU (KMS/DRM) and logind to finish initializing
          echo "Waiting for graphics drivers to initialize..."
          sleep 2 
          
          echo "Starting Niri..."
          
          # Run Niri, but save all of its hidden terminal output to a file
          niri &> /tmp/niri-boot.log
          
          echo "Niri exited. Sleeping for 5 seconds..."
          sleep 5
        fi
      '';

      # Runs on interactive shells (Equivalent to your bashrcExtra)
      interactiveShellInit = ''
        # Handy functions
        mkcd() {
          mkdir -p "$1" && cd "$1"
        }
      '';

      # Specifically overrides the default NixOS PS1 prompt
      promptInit = ''
        export PS1='\[\e[38;5;40m\]\u@\h\[\e[0m\]: \[\e[38;5;207m\]\w\n\[\e[1m\]>\[\e[0m\] '
      '';
    };
  };
}
