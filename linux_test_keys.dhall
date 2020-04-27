let Alacritty =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/linux.dhall

let keys =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/keys/common.dhall

let keysLinux =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/keys/linux.dhall

let common =
      keys.showCommonBindings
        [ keys.CommonBinding.Action
            { key = "A"
            , mods = None (List keys.Modifier)
            , mode = None keys.Mode
            , action = keys.Action.SpawnNewInstance
            }
        ]

let linuxBindings =
      keysLinux.showBindings
        [ keysLinux.KbdIn.Action
            { key = "B"
            , mods = None (List keysLinux.Modifier)
            , mode = None keysLinux.Mode
            , action = keysLinux.Action.CopySelection
            }
        ]

in  Alacritty.Config::{
    , window = Alacritty.Window.Schema::{
      , decorations = Alacritty.Window.Decoration.full
      , startup_mode = Alacritty.Window.Startup.Fullscreen
      , dynamic_padding = True
      }
    , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
    , key_bindings = common # linuxBindings
    }
