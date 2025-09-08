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

  home.file.".tmux/plugins/tpm" = {
    source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.1.0";
      sha256 = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
    };
    recursive = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    tmux
    neovim
    lazygit
    lazydocker

    gcc
    cargo
    python313
    nodejs_24

    xclip
    xkb-switch
    kitty
    polybar
    rofi
    rofi-power-menu
  ];
}
