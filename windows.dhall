let Font = ./font/windows.dhall

let Keys = ./keys/windows.dhall

let Window = ./window/windows.dhall

let Env = ./env.dhall

let Shell = ./shell/windows.dhall

let Scrolling = ./scrolling.dhall

let Debug = ./debug.dhall

let VisualBell = ./visual.dhall

let Opacity = ./opacity.dhall

let MouseBindings = ./mouse_bindings/windows.dhall

let Mouse = ./mouse/windows.dhall

let Cursor = ./cursor.dhall

let Colors = ./colors.dhall

let Misc = ./misc.dhall

let defaultFont =
      { normal = { family = "Consolas", style = "Regular" }
      , bold = { family = "Consolas", style = "Bold" }
      , italic = { family = "Consolas", style = "Italic" }
      , bold_italic = { family = "Consolas", style = "Italic" }
      }

let Config =
      { Type =
            Misc.Type
          ⩓ { font : Font.Type
            , key_bindings : List Keys.Binding
            , window : Window.Schema.Type
            , env : Env.Type
            , shell : Shell.Type
            , scrolling : Scrolling.Type
            , debug : Debug.Schema.Type
            , bell : VisualBell.Schema.Type
            , opacity : Opacity.Type
            , mouse_bindings : List MouseBindings.Mbd
            , mouse : Mouse.Schema.Type
            , cursor : Cursor.Schema.Type
            , colors : Colors.Schema.Type
            }
      , default =
            Misc.default
          ∧ { font = Font::{=} ⫽ defaultFont
            , key_bindings = [] : List Keys.Binding
            , window = Window.Schema::{=}
            , env = Env.default
            , shell = Shell.Type
            , scrolling = Scrolling::{=}
            , debug = Debug.Schema::{=}
            , bell = VisualBell.Schema::{=}
            , opacity = Opacity::{=}
            , mouse = Mouse.Schema::{=}
            , mouse_bindings = [] : List MouseBindings.Mbd
            , cursor = Cursor.Schema::{=}
            , colors = Colors.Schema::{=}
            }
      }

in  { Config
    , Font
    , Keys
    , Window
    , Env
    , Misc
    , Shell
    , Scrolling
    , Debug
    , VisualBell
    , MouseBindings
    , Mouse
    , Cursor
    , Colors
    }
