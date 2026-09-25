# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./steam.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "thinknix"; # Define your hostname.

  networking.networkmanager = {
    #enable = true;  # Easiest to use and most distros use this by default.
    wifi.backend = "iwd";
  };
  networking.wireless.iwd = {
    enable = true; # wireless networking backend
    settings = {
      Network = {
        EnableIPv6 = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Logind
  #services.logind.powerKey = "suspend"; # TODO: doesn't work
  services.logind.settings.Login.HandlePowerKey = "suspend";
  services.logind.settings.Login.HandleSuspendKey = "suspend";
  services.logind.settings.Login.HandleHibernateKey = "hibernate";
  services.logind.settings.Login.HandleLidSwitch = "suspend";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Here are the unfree packages I want: _1password-cli
  # nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.paul = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "video" "docker"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # docker
  virtualisation.docker.enable = true;

  ##### PROGRAMS #####
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = false;
    };
    waybar.enable = true;
    hyprlock.enable = true;
    zsh.enable = true;

/* 
    zsh = {
      enable = true; # how to enable for only one user
      # This shit isn't working: 
      interactiveShellInit = ''
        bindkey "^[OA" up-line-or-beginning-search
        bindkey "^[OB" down-line-or-beginning-search
        bindkey "^K" up-line-or-beginning-search
        bindkey "^J" down-line-or-beginning-search
      '';
    };

    zsh.ohMyZsh = {
      enable = true;
      #theme = "agnoster";
      # theme = "superjarin";
      theme = "sunrise";
      plugins = [ "git" ];
    };
*/

/* # TODO REMOVE
    # This configures for all users, so this is a no go
    git = {
      enable = true;
      config = { 
        user.name = "Paul Yates";
        user.email = "paul.maxyat@gmail.com";
        core.editor =  "vim";
        push.default = "simple";
        color.ui = "auto";
        pull.rebase = "true";
        diff.tool = "vimdiff";
        merge.ff = "only";
        rerere.enable = "false";
        aliases = {
         graph = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        };
      };
    };
*/
  };

  #programs.brightnessctl.enable = true;
  programs.kbdlight.enable = true;
  hardware.acpilight.enable = true;

  hardware.bluetooth = { 
    enable = true;
    powerOnBoot = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git

    wl-clipboard # wayland clipboard support

    # hypr ecosystem
    hyprlang
    hypridle
    hyprlock
    hyprlauncher
    hyprtoolkit
    hyprpicker
    hyprsunset

    home-manager

    # TODO: move these to homemanager
    fastfetch
    inputs.anifetch.packages.${pkgs.stdenv.hostPlatform.system}.default 

    libgcc
    # dislocker # mount windows partition TODO
  ];

  # Include more man pages
  documentation.dev.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use Wayland
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Fix backlight keybinding
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; # doesn't work with flake-based config

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

  # Mount windows C drive (doesn't work TODO)
/*
  fileSystems."/mnt/bitlocker" = {
    #device = "/dev/disk/by-partlabel/Basic\\x20data\\x20partition"; # nvme0n1p3 on my machine
    device = "/dev/nvme0n1p3";
    fsType = "fuse.dislocker";
    options = [ "users" "nofail"];
  };

  fileSystems."/mnt/windows" = {
    device = "/mnt/bitlocker/dislocker-file";
    fsType = "ntfs";
    options = [ "users" "nofail" ];
  };
*/

}

