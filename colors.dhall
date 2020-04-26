let Block =
      { black : Text
      , red : Text
      , green : Text
      , yellow : Text
      , blue : Text
      , magenta : Text
      , cyan : Text
      , white : Text
      }

let IndexColor = { index : Natural, color : Text }

let Selection = { text : Text, background : Text }

let Cursor = { text : Text, cursor : Text }

let Schema =
      { Type =
          { primary :
              { background : Text
              , foreground : Text
              , dim_foreground : Optional Text
              , dim_background : Optional Text
              }
          , normal : Block
          , bright : Block
          , dim : Optional Block
          , cursor : Optional Cursor
          , vi_mode_cursor : Optional Cursor
          , selection : Optional Selection
          , indexed_colors : List IndexColor
          }
      , default =
        { primary =
          { background = "#000000"
          , foreground = "#eaeaea"
          , dim_foreground = Some "#9a9a9a"
          , dim_background = Some "#ffffff"
          }
        , cursor = Some { text = "#000000", cursor = "#ffffff" }
        , vi_mode_cursor = Some { text = "#000000", cursor = "#ffffff" }
        , selection = Some { text = "#eaeaea", background = "#404040" }
        , normal =
          { black = "#000000"
          , red = "#d54e53"
          , green = "#b9ca4a"
          , yellow = "#e6c547"
          , blue = "#7aa6da"
          , magenta = "#c397d8"
          , cyan = "#70c0ba"
          , white = "#eaeaea"
          }
        , bright =
          { black = "#666666"
          , red = "#ff3334"
          , green = "#9ec400"
          , yellow = "#e7c547"
          , blue = "#7aa6da"
          , magenta = "#b77ee0"
          , cyan = "#54ced6"
          , white = "#ffffff"
          }
        , dim = Some
          { black = "#000000"
          , red = "#8c3336"
          , green = "#7a8530"
          , yellow = "#97822e"
          , blue = "#506d8f"
          , magenta = "#80638e"
          , cyan = "#497e7a"
          , white = "#9a9a9a"
          }
        , indexed_colors = [] : List IndexColor
        }
      }

in  { Schema, Block, IndexColor, Selection, Cursor }
