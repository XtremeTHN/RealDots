hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    
    border_size = 1,
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",

    col = {
      active_border = primary,
      inactive_border = 0x595959aa
    },
  }
})

hl.config ({
  decoration = {
    rounding = 8,
    rounding_power = 2,

    active_opacity = 1,
    inactive_opacity = 0.8,

    shadow = {
      enabled = false
    },

    blur = {
      enabled = true,
      new_optimizations = true,
      size = 6,
      vibrancy = 0.1696,
      passes = 4,
      noise = 0.0117,
      contrast = 0.89,
      brightness = 0.82,
      acrylic = {
        tint = 0x000000FF
      },
    }
  }
})

hl.curve("linear",        { type = "bezier", points = { {0, 0},      {1, 1}      } })
hl.curve("md3_standard",  { type = "bezier", points = { {0.2, 0},    {0, 1}      } })
hl.curve("md3_decel",     { type = "bezier", points = { {0.05, 0.7}, {0.1, 1}    } })
hl.curve("md3_accel",     { type = "bezier", points = { {0.3, 0},    {0.8, 0.15} } })
hl.curve("overshot",      { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1}  } })
hl.curve("crazyshot",     { type = "bezier", points = { {0.1, 1.5},  {0.76, 0.92} } })
hl.curve("hyprnostretch", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0}  } })
hl.curve("menu_decel",    { type = "bezier", points = { {0.1, 1},    {0, 1}      } })
hl.curve("menu_accel",    { type = "bezier", points = { {0.38, 0.04}, {1, 0.07}  } })
hl.curve("easeInOutCirc", { type = "bezier", points = { {0.85, 0},   {0.15, 1}   } })
hl.curve("easeOutCirc",   { type = "bezier", points = { {0, 0.55},   {0.45, 1}   } })
hl.curve("easeOutExpo",   { type = "bezier", points = { {0.16, 1},   {0.3, 1}    } })
hl.curve("softAcDecel",   { type = "bezier", points = { {0.26, 0.26}, {0.15, 1}  } })
hl.curve("md2",           { type = "bezier", points = { {0.4, 0},    {0.2, 1}    } }) -- use with .2s duration

hl.animation({ leaf = "windows",          enabled = true, speed = 3,   bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 3,   bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3,   bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border",           enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3,   bezier = "md3_decel" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 1.5, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1.6, bezier = "menu_accel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 2,   bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 7,   bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "md3_decel", style = "slidevert" })
