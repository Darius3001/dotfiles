{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "darius";
    homeDirectory = "/home/darius";
    stateVersion = "25.05";

    file = {
      ".config/nvim" = {
        source = ./../nvim;
        recursive = true;
      };

      ".config/polybar" = {
        source = ./../polybar;
        recursive = true;
      };

      ".config/rofi" = {
        source = ./../rofi;
        recursive = true;
      };

      ".tmux.conf" = {
        source = ./../.tmux.conf;
      };

      ".tmux/plugins/tpm" = {
        source = pkgs.fetchFromGitHub {
          owner = "tmux-plugins";
          repo = "tpm";
          rev = "v3.1.0";
          sha256 = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
        };
        recursive = true;
      };
    };

    packages = with pkgs; [
      ripgrep
      fd
      tmux
      neovim
      lazygit
      lazydocker
      fzf
      btop

      gcc
      cargo
      python313
      nodejs_24

      xclip
      xkb-switch
      brightnessctl
      pamixer
      polybar
      rofi
      rofi-power-menu

      kitty
    ];
  };
}
