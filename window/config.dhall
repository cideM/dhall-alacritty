let OS = ../os.dhall

in    λ(os : OS)
    → { window :
          { dimensions : { columns : Natural, lines : Natural }
          , padding : { x : Natural, y : Natural }
          , dynamic_padding : Bool
          , decorations : ./decoration.dhall
          , startup_mode : ./startup.dhall os
          }
      }
