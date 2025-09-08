{ config, pkgs, ... }:

{
  home.username = "darius";
  home.homeDirectory = "/home/darius";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Your nvim config repo
  home.file.".config/nvim" = {
    source = ./../nvim;
    recursive = true;
  };

  # Extras
  home.packages = with pkgs; [ ripgrep fd ];
}
