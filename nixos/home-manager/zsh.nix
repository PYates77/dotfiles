{ config, pkgs, inputs, dotfilesDir, ... }:
let
    # fix wrong install location of zsh-vi-mode
    # there might be a way to avoid this wit programs.zsh.plugins
    # but it doesn't appear to play nicely with oh-my-zsh?
    zsh-vi-mode = pkgs.zsh-vi-mode.overrideAttrs (oldAttrs: {
        installPhase = ''
        mkdir -p $out/share/oh-my-zsh/custom/plugins/zsh-vi-mode
        cp *.zsh $out/share/oh-my-zsh/custom/plugins/zsh-vi-mode/
        '';
    });
in
    {
    home.packages = with pkgs; [
        zsh-vi-mode
    ];

    # https://wiki.nixos.org/wiki/Zsh
    programs.zsh = {
        enable = true;
        initContent = ''
      #### Keybindings ####
      bindkey "''${terminfo[kcuu1]}" up-line-or-beginning-search
      bindkey "''${terminfo[kcud1]}" down-line-or-beginning-search
      bindkey "^K" up-line-or-beginning-search
      bindkey "^J" down-line-or-beginning-search

      # launch uwsm automatically
      #if uwsm check may-start && uwsm select; then
      #  exec uwsm start default # show uswm tui selector (if using a display manager like greetd)
      #fi
      #if uwsm check may-start; then
      #    exec uwsm start hyprland.desktop # launch hyprland without compositor select
      #fi

      ###### CUSTOM WINDOW TITLE #####
      CUSTOM_TERM_TITLE=""

      # call zshtitle <newtitle> to set custom title
      # call zshtitle with no args to unset custom title
      zshtitle() {
        if [[ -z "$1" ]]; then
          CUSTOM_TERM_TITLE=""
          echo "zsh title reset to auto"
          if [ -n "$functions[omz_termsupport_cwd]" ]; then omz_termsupport_cwd; fi
        else
          echo "Custom title set "
          CUSTOM_TERM_TITLE="$1"
          print -n "\e]0;''${CUSTOM_TERM_TITLE}\a"
        fi
      }

      # Intercept Oh My Zsh hooks with prompt expansion (-P) enabled
      omz_termsupport_cwd() {
        if [[ -n "$CUSTOM_TERM_TITLE" ]]; then
          print -n "\e]0;''${CUSTOM_TERM_TITLE}\a"
        else
          # Added -P so %~ expands to your current path (e.g., ~ or ~/Downloads)
          print -Pn "\e]0;%~ \a"
        fi
      }

      omz_termsupport_preexec() {
        if [[ -n "$CUSTOM_TERM_TITLE" ]]; then
          print -n "\e]0;''${CUSTOM_TERM_TITLE}\a"
        else
          # Added -P so %~ expands, combined with the running command name
          local CMD=''${1[(w)1]}
          print -Pn "\e]0;''${CMD} (%~)\a"
        fi
      }
      ###### END CUSTOM WINDOW TITLE #####
        '';
        #plugins = [
        #    {
        #      name = "zsh-vi-mode";
        #      src = pkgs.zsh-vi-mode.src;
        #    }
        #];
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "zsh-vi-mode"];
            custom = "${config.home.homeDirectory}/.nix-profile/share/oh-my-zsh/custom";
            theme = "sunrise";
            extraConfig = ''
        # oh-my-zsh uses this, neede if custom window title function is going to work (see below)
        export DISABLE_AUTO_TITLE="true"

        # fix the bind for zsh-vi-mode
        # The plugin will auto execute this zvm_after_lazy_keybindings function
        function zvm_after_init() {
            # Insert mode
            zvm_bindkey viins '^J' down-line-or-beginning-search
            zvm_bindkey viins '^K' up-line-or-beginning-search
            zvm_bindkey viins "''${terminfo[kcud1]}" down-line-or-beginning-search
            zvm_bindkey viins "''${terminfo[kcuu1]}" up-line-or-beginning-search
        }

        function zvm_after_lazy_keybindings() {
            # Normal mode
            zvm_bindkey vicmd '^J' down-line-or-beginning-search
            zvm_bindkey vicmd '^K' up-line-or-beginning-search
            zvm_bindkey vicmd "''${terminfo[kcud1]}" down-line-or-beginning-search
            zvm_bindkey vicmd "''${terminfo[kcuu1]}" up-line-or-beginning-search
        }

            '';
        };
    };

    # doing the above extrConfig bs instead
    # so that the nix installer gives us whatever benefit it thinks it is doing...
    #home.file.".zshrc" = {
    #  source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/dot-zshrc";
    #};
    #xdg.configFile."oh-my-zsh.sh" = {
    #  source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/dot-config/oh-my-zsh.sh";
    #};
}


