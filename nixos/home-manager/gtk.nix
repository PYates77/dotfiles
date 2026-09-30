{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "DejaVu Sans";
      size = 10;
    };
    theme = {
      name = "Colloid-Grey-Dark";
      package = pkgs.colloid-gtk-theme.override {
        colorVariants = [ "dark" ];
        themeVariants = [ "grey" ];
        tweaks = [
          "rimless"
          "float"
        ];
      };
    };
    #iconTheme = {
    #  name = "Papirus-Dark";
    #  package = pkgs.papirus-icon-theme.override { color = "black"; };
    #};
  };
}
