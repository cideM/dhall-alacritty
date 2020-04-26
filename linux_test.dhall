let Alacritty = https://github.com/cideM/dhall-alacritty/linux.dhall

in  Alacritty.Config::{
    , window = Alacritty.Window.Schema::{
      , decorations = Alacritty.Window.Decoration.full
      , startup_mode = Alacritty.Window.Startup.Fullscreen
      , dynamic_padding = True
      }
    , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
    }
