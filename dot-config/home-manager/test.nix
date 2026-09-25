#{ pkgs, home, ... }:
#let 
#  snake =  builtins.getFlake "path:/home/paul/dev/snake";
#in
#{
#  home.packages = [
#    snake.packages.${pkgs.system}.snake
#  ];
#}
