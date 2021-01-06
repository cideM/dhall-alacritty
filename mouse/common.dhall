let keys = ../keys/common.dhall

let Modifier
    : Type
    = < Empty | Common : List keys.Modifier >

let handleModifier
    : Modifier → Text
    = λ(m : Modifier) →
        merge
          { Empty = "None"
          , Common = λ(mods : List keys.Modifier) → keys.makeMods mods
          }
          m

let Schema =
      { Type =
          { double_click : { threshold : Natural }
          , triple_click : { threshold : Natural }
          , hide_when_typing : Bool
          , url :
              { launcher : { program : Text, args : List Text }
              , modifiers : Text
              }
          }
      , default =
        { double_click.threshold = 300
        , triple_click.threshold = 300
        , hide_when_typing = False
        , url =
          { launcher = { program = "", args = [] : List Text }
          , modifiers = handleModifier Modifier.Empty
          }
        }
      }

in  { Schema, Modifier, handleModifier, CommonModifier = keys.Modifier }
