# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];
  boot.loader.grub = {
	enable=true;
	version = 2;
	device = "nodev";
	efiSupport = true;
	useOSProber = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "hyprland-btw"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Detroit";

  services.getty.autologinUser = "shalamar";
  
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };

  services.pipewire = {
  	enable = true;
  	pulse.enable = true;
  };

  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shalamar = {
  	isNormalUser = true;
    	extraGroups = [ "wheel" ];
	packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
 	vim
  	wget
	zsh
	git
	kitty
	waybar
	hyprpaper
	inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	pkgs.godot
  ];

  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

