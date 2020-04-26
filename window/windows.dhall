let Decoration = < full | none >

let Startup = < Windowed | Maximized | Fullscreen >

let Config =
        (./common.dhall).Type
      ⩓ { decorations : Decoration
        , startup_mode : Startup
        , class : { instance : Text, general : Text }
        , gtk_theme_variant : Text
        }

let Schema =
    -- TODO: Fix the None here
      { Type = Config
      , default =
            (./common.dhall).default
          ⫽ { decorations = Decoration.full
            , startup_mode = Startup.Windowed
            , class = { instance = "Alacritty", general = "Alacritty" }
            , gtk_theme_variant = "None"
            }
      }

in  { Schema, Decoration, Startup }
