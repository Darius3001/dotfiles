{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "darius-nixos";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";

}

