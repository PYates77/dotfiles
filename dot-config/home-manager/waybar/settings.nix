{ ... }:
# TODO: inherit this color scheme from somewhere? don't reuse in waybar/style.nix
let
  custom = {
    font = "Font Awesome";
    font_size = "12px";
    #font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.settings.mainBar = with custom; {
    position = "top";
    layer = "top";
    height = 28;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "tray"
    ];
    modules-center = [ 
      "hyprland/window"
      "clock"
    ];
    modules-right = [
      "cpu"
      "memory"
      "pulseaudio"
      "network"
      "bluetooth"
      "backlight"
      "battery"
      #"hyprland/language"
      "custom/notification"
      "custom/power"
    ];
    clock = {
      calendar = {
        format = {
          today = "<span color='#98971A'><b>{}</b></span>";
        };
      };
      format = "  {:%H:%M}";
      format-alt = "  {:%d/%m -   %H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
    "hyprland/window" = {
      format = "{initialTitle}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "I";
        "2" = "II";
        "3" = "III";
        "4" = "IV";
        "5" = "V";
        "6" = "VI";
        "7" = "VII";
        "8" = "VIII";
        "9" = "IX";
        "10" = "X";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
      };
      special-visible-only =  true;
      show-special = true;
    };
    cpu = {
      format = "<span foreground='${green}'> </span> {usage}%";
      format-alt = "<span foreground='${green}'> </span> {avg_frequency} GHz";
      interval = 2;
      #on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float-kitty btop'";
      on-click-right = "hyprctl eval 'hl.exec_cmd(\"kitty --title float-kitty btop\")'";
    };
    memory = {
      format = "<span foreground='${cyan}'>󰟜 </span>{}%";
      format-alt = "<span foreground='${cyan}'>󰟜 </span>{used} GiB"; # 
      interval = 2;
      #on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float-kitty btop'";
      on-click-right = "hyprctl eval 'hl.exec_cmd(\"kitty --title float-kitty btop\")'";
    };
    disk = {
      # path = "/";
      format = "<span foreground='${orange}'>󰋊 </span>{percentage_used}%";
      interval = 60;
      #on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float-kitty btop'";
      on-click-right = "hyprctl eval 'hl.exec_cmd(\"kitty --title float-kitty ncdu\")'";
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon} {percent:>2}%";
      format-icons = ["" "" "" "" "" "" "" "" ""];
    };
    network = {
      format-wifi = "<span foreground='${magenta}'> </span> {essid}({signalStrength}%)";
      format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      tooltip-format-disconnected = "Disconnected";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
      #on-click = "kitty nmtui"; # TODO: terminal agnostic, call script
      #on-click = "networkmanager_dmenu";
      on-click = "hyprctl eval 'hl.exec_cmd(\"kitty --title float-kitty impala\")'";
    };
    bluetooth = {
      format = "<span foreground='${cyan}'></span> {status}";
      format-connected = "<span foreground='${cyan}'></span> {device_alias}";
      format-connected-battery = "<span foreground='${cyan}'></span> {device_alias} ({device_battery_percentage}%)";
      #format-device-preference = [ "device1" "device2" ]; // preference list deciding the displayed device
      tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}"; tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
      tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t({device_battery_percentage}%)";
      on-click = "hyprctl eval 'hl.exec_cmd(\"kitty --title float-kitty bluetui\")'";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "<span foreground='${blue}'> </span> {volume}%";
      format-icons = {
        default = [ "<span foreground='${blue}'> </span>" ];
      };
      scroll-step = 2;
      on-click = "pamixer -t";
      #on-click-right = "pavucontrol";
      on-click-right = "hyprctl eval 'hl.exec_cmd(\"kitty --title float-kitty wiremix\")'";
    };
    battery = {
      format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
      format-full = "<span foreground='${yellow}'> </span>{capacity}%";
      format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "hyprland/language" = {
      format = "<span foreground='#FABD2F'> </span> {}";
      format-fr = "FR";
      format-en = "US";
    };
    "custom/launcher" = {
      format = "";
      on-click = "wofi --show drun";
      on-click-right = "random-wallpaper";
      tooltip = "true";
      tooltip-format = "Run";
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        none = "  <span foreground='${red}'></span>";
        dnd-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        dnd-none = "  <span foreground='${red}'></span>";
        inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        inhibited-none = "  <span foreground='${red}'></span>";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        dnd-inhibited-none = "  <span foreground='${red}'></span>";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
    "custom/power" = {
      "format" = "{icon}";
      "format-icons" = " "; #  
      "exec-on-event" = "true";
      "on-click" = "wofi-power-menu";
      "tooltip-format" = "Power Menu";
    };
  };
}
