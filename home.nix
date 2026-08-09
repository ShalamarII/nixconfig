{ config, pkgs, ...}:

{
	home.username = "shalamar";
	home.homeDirectory = "/home/shalamar";
	home.stateVersion = "26.05";
	programs.git.enable = true;
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use hyprland btw";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
				exec hyprland
			fi
		'';
	};
	programs.git = {
		userName = "ShalamarII";
		userEmail = "hitmanlee3@gmail.com";
	};
}

