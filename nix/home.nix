{ config, pkgs, ... }:

{
  home.username = "darius";
  home.homeDirectory = "/home/darius";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.file.".config/nvim" = {
    source = ./../nvim;
    recursive = true;
  };

  home.file.".config/polybar" = {
    source = ./../polybar;
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = ./../rofi;
    recursive = true;
  };

  home.file.".tmux.conf" = {
    source = ./../.tmux.conf;
  };

  home.packages = with pkgs; [ 
    ripgrep 
    fd 
    kitty
    polybar
    rofi
    rofi-power-menu
  ];
}
