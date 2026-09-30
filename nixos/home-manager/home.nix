{ config, pkgs, inputs, dotfilesDir, ... }:
{
  # You can import other home-manager modules here
  imports = [
    ./gtk.nix
    ./zsh.nix
    ./vim/neovim.nix
    ./vim/vim.nix
    ./waybar/default.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ## desktop environment required # TODO: move to top-level nix?
    libnotify

    ## shell

    ## tools
    ripgrep # rg
    fd # find alternative
    fzf # fuzzy finder
    tree # recursive ls
    bat # syntax highlighter cat

    ## gui apps
    wofi
    networkmanager_dmenu # deprecated by impala?
    # wofi-power-menu # not satisfied with this?

    ## cli apps
    bluez

    ## tui applets
    bluetui # bluetooth
    yazi # file browser
    impala # networking
    wiremix # audio
    ncdu # disk usage
    btop # system status 

    ## dev
    libclang
    jq # json parser

    ## toys
    fastfetch
    astroterm
    pipes
    sl
    cmatrix
    unimatrix # improvement on cmatrix
    cbonsai
    cowsay
    drift

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # https://wiki.nixos.org/wiki/Hyprland
  wayland.windowManager.hyprland = { 
    enable = true;
    systemd.enable = false; # prevent conflict with UWSM
  };

  # moved to nixos config
  #fonts.fontconfig.enable = true; # you still have to add fonts in pakages after turning this on

  # honestly I'm not stoked on the crursor
  home.pointerCursor = {
    enable = true;
    #name = "Bibata-Modern-Classic";
    #package = pkgs.bibata-cursors;
    #name = "everforest-cursors";
    #package = pkgs.everforest-cursors;
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
  };


  programs = {
    # https://wiki.nixos.org/wiki/Kitty
    kitty = {
      enable = true;
      font = {
        name = "Hack Nerd Font";
        #package = pkgs.nerd-fonts.hack;
      };
      keybindings = {
        "ctrl+shift+l" = "next_tab";
        "ctrl+shift+h" = "prev_tab";
        "ctrl+shift+:" = "browse_scrollback_in_pager";
      };
      extraConfig = ''
        shell_integration no-title
      '';
    };
    # https://wiki.nixos.org/wiki/Git
    git = {
      enable = true;
      settings = { 
        user.name = "Paul Yates";
        user.email = "paul.maxyat@gmail.com";
        core.editor =  "nvim";
        push.default = "simple";
        color.ui = "auto";
        pull.rebase = "true";
        diff.tool = "vimdiff";
        rerere.enable = "false";
        alias = {
          graph = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        };
      };
    };
    # https://nixos.wiki/wiki/Librewolf
    librewolf = {
      enable = true;
      # Enable WebGL, cookies and history
      # these are popular options but they impact privacy
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0;
      };
    };
  };

  # Set kitty as default for opening termial apps from .desktop files
  # (idk why programs.kitty can't do this?)
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };

  # enables bluetooth device buttons
  services.mpris-proxy.enable = true;

  # notification client
  services.swaync.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/paul/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
