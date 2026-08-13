{config, pkgs, ...}: 

{
	home.username = "irdyad";
	home.homeDirectory = "/home/irdyad";
	home.stateVersion = "26.05";

#    programs.git = {
#      enable = true;
#      signing = {
#        key = null;
#        signByDefault = true;
#        format = "ssh";
#      };
#      settings = {
#        user = {
#          name = "Irdyad";
#          email = "lele.depaoli@gmail.com";
#        };
#        gpg = {
#          format = "ssh";
#        };
#      };
#    };

#    programs.ssh = {
#      enable = true;
#      #addKeysToAgent;
#      settings = {
#        "github.com" = {
#          HostName = "github.com";
#          User = "git";
#          IdentityFile = "~/.ssh/ghub_tower";
#        };
#      };
#    };

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos btw";
			nrs = "sudo nixos-rebuild switch";
			nrf = "nrs --flake ~/nixos-dotfile#nixos";
			nc = "vim nixos-dotfile/";
		};
		profileExtra = ''
			if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
				start-hyprland
			fi
		'';
		bashrcExtra = ''
			PS1='\[\e[38;5;40m\]\u@\h\[\e[0m\]: \[\e[38;5;207m\]\w\n\[\e[1m\]>\[\e[0m\] '
		'';
	};

	programs.vim = {
		enable = true;
		extraConfig = ''
			filetype plugin indent on
			set expandtab
			set shiftwidth=4
			set softtabstop=4
			set tabstop=4
			set number
			set relativenumber
			set smartindent
			set showmatch
			set backspace=indent,eol,start
			syntax on
		'';

	};
	services.hyprpaper = {
		enable = true;

		settings = {
			splash = false;
			wallpaper = [
			{
				monitor = "";
				path = "/home/irdyad/nixos-dotfile/config/wallpapers";
				fit_mode = "cover";
				timeout = 300;
			}
			];
		};
	};


	home.file.".config/hypr/hyprland.lua".source = ./config/hypr/hyprland.lua;

}


