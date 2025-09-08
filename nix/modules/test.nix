{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      configFile = ./../../i3/config;
    };
  };
  services.displayManager.defaultSession = "none+i3";

  services.xserver.xkb.layout = "us,de";

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };

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

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio
    vim
    wget
    git
  ];

  environment.variables.EDITOR = "vim";

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
}
