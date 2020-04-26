let Action = ./action.dhall

let Command = ./command.dhall

let Mod = ./modifiers.dhall

let Raw =
      { Type =
          { key : Text
          , mods : Optional (List Mod)
          , action : Optional Action
          , chars : Optional Text
          , command : Optional Command
          }
      , default =
        { command = None Command
        , mods = [] : List Mod
        , chars = None Text
        , action = None Action
        }
      }

let Keybind
    : Type
    = { key : Text
      , mods : Optional Text
      , action : Optional Text
      , chars : Optional Text
      , command : Optional Command
      }


in  { Raw, Keybind }
