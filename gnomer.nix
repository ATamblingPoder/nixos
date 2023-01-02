{ config, lib, pkgs, ... }:
{
  # Enable dconf
  programs.dconf.enable = true;
  
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

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

  # Enable GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    adw-gtk3
    pkgs.gnome.gnome-tweaks
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.gamemode
    gnome.gnome-terminal
    caffeine-ng
    gnome-podcasts
    gnome.libgnome-keyring
  ];
}
