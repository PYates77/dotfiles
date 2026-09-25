{ ... }:
{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/wofi-power-menu.toml".text = ''
[menu.shutdown]
title="shutdown"
requires_confirmation="true"

[menu.reboot]
title="reboot"
requires_confirmation="true"

[menu.suspend]
title="suspend"
requires_confirmation="false"

[menu.hibernate]
title="hibernate"
requires_confirmation="true"

[menu.logout]
enabled="true"
title="logout"
requires_confirmation="false"

[menu.lock-screen]
title="lock screen"
cmd="hyprlock"
  '';

}
