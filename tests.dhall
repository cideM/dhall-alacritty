let Alacritty =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/linux.dhall sha256:7910af41711cb1b062e95943b3d078c861d52f09fe6866c8b7a83e71e7df192e

let keys =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/keys/common.dhall sha256:d0ce879f656b0e8a75e8ff887411d4ab2fae14e391a9287c7864d34719f989bc

let keysLinux =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/keys/linux.dhall sha256:5f140bb2b3862c77376e9863bc98b2ed3ea2451fc1dc2cc984d02ae8fa8c5fbf

let should_compile_example =
      Alacritty.Config::{
      , window = Alacritty.Window.Schema::{
        , decorations = Alacritty.Window.Decoration.full
        , startup_mode = Alacritty.Window.Startup.Fullscreen
        , dynamic_padding = True
        }
      , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
      }

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

let should_compile_example_with_keys =
      Alacritty.Config::{
      , window = Alacritty.Window.Schema::{
        , decorations = Alacritty.Window.Decoration.full
        , startup_mode = Alacritty.Window.Startup.Fullscreen
        , dynamic_padding = True
        }
      , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
      , key_bindings = common # linuxBindings
      }

in  { should_compile_example, should_compile_example_with_keys }
