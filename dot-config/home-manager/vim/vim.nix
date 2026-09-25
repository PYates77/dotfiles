{ pkgs, ... }  :
{
    programs.vim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          lightline-vim
          vim-wayland-clipboard
        ];
        # use my old vimrc for now
        extraConfig = ''
          source /home/paul/.vimrc
        '';
    };
}
