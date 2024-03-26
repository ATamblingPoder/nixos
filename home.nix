{ config, pkgs, ... }:

{
  home.username = "agoel";
  home.homeDirectory = "/home/agoel";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.telegram-desktop
    pkgs.fastfetch
    pkgs.ani-cli
    pkgs.topgrade
    pkgs.neovim
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = "export PATH=/home/agoel/.local/bin:$PATH";
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    userEmail = "117522662+ATamblingPoder@users.noreply.git";
    userName = "ATamblingPoder";
  };

  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.uosc pkgs.mpvScripts.sponsorblock  ];
    config = {
      hwdec = "nvdec";
      gpu-api = "vulkan";
    };
  };

  services.gammastep = {
    enable = true;
    latitude = "28.58";
    longitude = "77.33";
    tray = true;
    temperature = {
      day = 4000;
      night = 3200;
    };
  };

  programs.home-manager.enable = true;
}
