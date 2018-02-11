# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  fileSystems."/home/alli/media" =
    { device = "/dev/nvme0n1p4";
      fsType = "ext4";
    };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  # networking.hostName = "Brooks3"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # for chrome :(
  nixpkgs.config.allowUnfree = true;

  # for keepkey:(
  services.udev = {
   extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2b24", ATTR{idProduct}=="0001", MODE="0666", GROUP="dialout", SYMLINK+="keepkey%n"
    KERNEL=="hidraw*", ATTRS{idVendor}=="2b24", ATTRS{idProduct}=="0001",  MODE="0666", GROUP="dialout"
   '';
  };


  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    	wget
	vim
	git
	firefox
	zsh
	rxvt_unicode
	kakoune
	xsel
  	htop
	mutt
	texlive.combined.scheme-full
	pandoc
	w3m
	mupdf
	cacert
	unzip
    zip
	stack
	ghc
	gnumake
	zlib
	glib
	cairo
	gtk2-x11
	binutils
	mpv
	bc
	haskellPackages.pandoc-citeproc
    imagemagick
    inkscape
    python
    python3
    youtube-dl
    google-chrome
    file
    hledger
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # redshift
  services.redshift = {
    enable = true;
    latitude = "40";
    longitude = "-88";
    temperature.day = 5500;
    temperature.night = 2700;
    brightness.day = "1.0";
    brightness.night = "0.7";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput.enable = true; # touchpad
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    windowManager.i3.enable = true;

    displayManager.sessionCommands =  ''
       xrdb "${pkgs.writeText  "xrdb.conf" ''
		
            URxvt*.background:   #000000
            URxvt*.foreground:   #ffffff

            urxvt*transparent: true
            urxvt*shading: 10

            URxvt*.scrollBar:    false

            !URxvt.font:         9x15
            URxvt*.font:         xft:terminus:size=14
            !disable weird keycap modes
            URxvt*.iso14755:     false
            URxvt*.iso14755_52:  false

            ! Common

            #define S_yellow        #b58900
            #define S_orange        #cb4b16
            #define S_red           #dc322f
            #define S_magenta       #d33682
            #define S_violet        #6c71c4
            #define S_blue          #268bd2
            #define S_cyan          #2aa198
            #define S_green         #859900


            ! Dark

            #define S_base03        #002b36
            #define S_base02        #073642
            #define S_base01        #586e75
            #define S_base00        #657b83
            #define S_base0         #839496
            #define S_base1         #93a1a1
            #define S_base2         #eee8d5
            #define S_base3         #fdf6e3

            *background:              S_base03
            *foreground:              S_base0
            *fading:                  40
            *fadeColor:               S_base03
            *cursorColor:             S_base1
            *pointerColorBackground:  S_base01
            *pointerColorForeground:  S_base1
            *color0:                  S_base02
            *color1:                  S_red
            *color2:                  S_green
            *color3:                  S_yellow
            *color4:                  S_blue
            *color5:                  S_magenta
            *color6:                  S_cyan
            *color7:                  S_base2
            *color9:                  S_orange
            *color8:                  S_base03
            *color10:                 S_base01
            *color11:                 S_base00
            *color12:                 S_base0
            *color13:                 S_violet
            *color14:                 S_base1
            *color15:                 S_base3

       ''}"
    '';

  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
	dejavu_fonts
	inconsolata
	terminus_font
    ];
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.alli = {
    name = "alli";
    group = "users";
    extraGroups = [
        "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
    ];
    createHome = true;
    isNormalUser = true;
    uid = 1000;
    home = "/home/alli";
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
