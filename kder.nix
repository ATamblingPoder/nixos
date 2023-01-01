{ config, lib, pkgs, ... }:
{
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    sassc
    libsForQt5.qtstyleplugin-kvantum
  ];

}
