{ config, lib, pkgs, ... }:

{
#  imports =
#    [
#      ./hardware-configuration.nix
#    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "darius-nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        #Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        #FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [i3status dmenu];
    };
  };
  services.displayManager.defaultSession = "none+i3";


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "kubectl" ];
      theme = "robbyrussell";
    };
    interactiveShellInit = ''
      [ -f "$HOME/dotfiles/shell_functions.sh" ] && source "$HOME/dotfiles/shell_functions.sh"
    '';
  };

  users = {
    users.darius = {
      isNormalUser = true;
      description = "Darius";
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "change-me";
    };
    defaultUserShell = pkgs.zsh; 
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #programs.home-manager.enable = true;
  #home-manager.users.darius = {
  #  home = {
  #    packages = with pkgs; [
  #      lazygit
  #      lazydocker
  #    ];

  #    xdg.configFile."nvim".source = ./dotfiles/nvim;
  #  };
  #};

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    kitty
    wget
    git
    tmux
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";

}

