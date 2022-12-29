# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;  
  
  # Plymouth
  boot.plymouth.enable = true;
  
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.initrd.systemd.enable = true;
  # Enable swap on luks
  boot.initrd.luks.devices."luks-722b634f-9ea2-437a-a033-f5e489f3b58a".device = "/dev/disk/by-uuid/722b634f-9ea2-437a-a033-f5e489f3b58a";
  boot.initrd.luks.devices."luks-722b634f-9ea2-437a-a033-f5e489f3b58a".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.fwupd.enable = true;  
  hardware.bluetooth.enable = true;
    
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  
  # Enable GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Exclude extra GNOME applications
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
    gnome-text-editor
    gnome-console
  ]) ++ (with pkgs.gnome; [
    epiphany
    geary
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
    gnome-contacts
    gnome-weather
    gnome-clocks
    gnome-maps
    gnome-calendar
    gnome-software
  ]);
  
  # Enable steam
  programs.steam.enable = true;
         
  # Configure keymap in X11
  services.xserver = {
    layout = "in";
    xkbVariant = "eng";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable VA-API
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };  
  
  nix.extraOptions = ''experimental-features = nix-command flakes'';
  
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver 
      vaapiIntel         
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;  

  security.doas.enable = true;
  security.sudo.enable = false;

  # Configure doas
  security.doas.extraRules = [{
  users = [ "agoel" ];
  keepEnv = true;
  persist = true;  
  }];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.agoel = {
    isNormalUser = true;
    description = "Ansh Goel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      freetube
      ungoogled-chromium
      git
      sublime4
      tdesktop
      qbittorrent
      figlet
      gh
    ];
  };
  
  #  virtualisation = {
  #    podman = {
  #      enable = true;
  #
  #      # Create a `docker` alias for podman, to use it as a drop-in replacement
  #      dockerCompat = true;
  #
  #      # Required for containers under podman-compose to be able to talk to each other.
  #      defaultNetwork.dnsname.enable = true;
  #    };
  #  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.flatpak.enable = true;
       
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable Dconf
  programs.dconf.enable = true;
  
  # Set ZSH as default shell
  programs.zsh.enable = true;
  programs.xonsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh xonsh];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    neofetch
    firefox
    papirus-icon-theme
    inter
    cascadia-code
    libva-utils
    lutris
    appimage-run
    wine-staging
    ark
    unrar
    p7zip
    aria
    gamemode
    mangohud
    gcc
    gnumake
    gparted
    ntfs3g
    mpv
    topgrade
    vistafonts
    corefonts
    wirelesstools
    yt-dlp
    vlc
    adw-gtk3
    pkgs.gnome.gnome-tweaks
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome.gnome-terminal
    caffeine-ng
    python3Full
    gnome-podcasts
    libreoffice-fresh
    hunspell
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    vulkan-headers
    amdvlk
    file
  ];

  # Enable WEP support in wpa_supplicant
  nixpkgs.overlays = [
    (self: super: {
      wpa_supplicant = super.wpa_supplicant.overrideAttrs (oldAttrs: rec {
        extraConfig = oldAttrs.extraConfig + ''
	  CONFIG_WEP=y
	'';
      });
    })
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
