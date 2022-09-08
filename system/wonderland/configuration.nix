{ config, pkgs, home-manager, ... }:
{
  imports = [
    ../../modules/system/base
    ../../modules/system/desktop
    ../../modules/system/runtimes
    ./hardware-configuration.nix
  ];
  
  nixpkgs.overlays = [
    (import ../../overlays/discord.nix)
    (import ../../overlays/electron.nix)
    (import ../../overlays/waybar.nix)
  ];

  # Allow the installation of non-FOSS packages.
  nixpkgs.config.allowUnfree = true;

  # Manage the user accounts using home manager.
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.alice = import ./users/alice/home.nix;

  # Create User. Don't forget to change password.
  users.users.alice = {
    isNormalUser = true;
    description = "alice";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "adbusers"
    ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Disable sudo password.
  security = {
    sudo.wheelNeedsPassword = false;
  };
  
  # Packages relegated to the entire system.
  environment.systemPackages = with pkgs; [
  ];

  # Programs and configuring them.
  programs.java = {
    enable = true;
    additionalRuntimes = { inherit (pkgs) jdk17 jdk11 jdk8; };
    package = pkgs.jdk17;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Time zone and localization.
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  # Fonts.
  fonts.fonts = with pkgs; [
    inconsolata
    mononoki
    fira-code
    font-awesome
    powerline-fonts
  ];
  
  # Shell.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # MTP Devices.
  services.gvfs.enable = true;
  programs.adb.enable = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # Kernel Parameters.
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];

  # Modules to load with kernel.
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable silent boot.
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  # Bootloader.
  boot.loader.systemd-boot.enable = false;  

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Networking.
  networking.hostName = "wonderland";
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Display drivers & Options.
  services.xserver.videoDriver = [ "amdgpu" ];
  hardware.opengl.enable = true;
  
  # Enable CUPS for printing documents.
  services.printing.enable = true;

  # Set keymap for X11.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
   
  # Default Apps
  xdg.mime.defaultApplications = {
    "text/html" = "brave-browser.desktop";
    "x-scheme-handler/http" = "brave-browser.desktop";
    "x-scheme-handler/https" = "brave-browser.desktop";
    "x-scheme-handler/about" = "brave-browser.desktop";
    "x-scheme-handler/unknown" = "brave-browser.desktop";
  };

  ### SYSTEM INSTALL VERSION ---------- {{{
  # DO NOT CHANGE UNLESS YOU'RE CERTAIN YOUR CONFIGS WILL WORK WITH THE NEWER VERSION!!!
  system.stateVersion = "22.05";
  ### }}}
}