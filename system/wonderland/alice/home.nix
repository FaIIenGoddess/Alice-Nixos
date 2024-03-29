#################################################################################
#  _   _  ___  __  __ _____      __  __    _    _   _    _    ____ _____ ____   #
# | | | |/ _ \|  \/  | ____|    |  \/  |  / \  | \ | |  / \  / ___| ____|  _ \  #
# | |_| | | | | |\/| |  _| _____| |\/| | / _ \ |  \| | / _ \| |  _|  _| | |_) | #
# |  _  | |_| | |  | | |__|_____| |  | |/ ___ \| |\  |/ ___ \ |_| | |___|  _ <  #
# |_| |_|\___/|_|  |_|_____|    |_|  |_/_/   \_\_| \_/_/   \_\____|_____|_| \_\ #
#################################################################################
{ config, pkgs, ... }:
{
  imports = [
    ../../../modules/home
  ];

  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
    # Browswer
    firefox

    # Terminal
    kitty

    # Terminal Apps
    starship
    ranger
    zathura

    # Launchers
    wofi

    # Utilities
    wl-clipboard
    autotiling
    mako
    libnotify
    waybar
    eww-wayland
    polychromatic
    gnome.nautilus
    tree

    # Gaming
    discord
    steam
    prismlauncher
    retroarchFull

    # CLI tools
    neofetch
    pfetch
    figlet
    cbonsai
    grim
    slurp
    pavucontrol
    wlr-randr
    mpv

    # Programming Languages
    gcc
    gdb
    gnumake
    python3
    lua
    rustc
    cargo
    nasm
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  programs.git = {
    enable = true;
    userName  = "alicetabby";
    userEmail = "Jacobtrippy124@gmail.com";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
  
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
