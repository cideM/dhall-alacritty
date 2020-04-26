let Style = < Block | Underline | Beam >

let ViStyle = < Block | Underline | Beam | None >

let Schema =
      { Type =
          { style : Style
          , unfocused_hollow : Bool
          , vi_mode_style : ViStyle
          , thickness : Double
          }
      , default =
        { style = Style.Block
        , vi_mode_style = ViStyle.None
        , unfocused_hollow = True
        , thickness = 0.15
        }
      }

in  { Schema, Style, ViStyle }
