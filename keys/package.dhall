let Action = ./action.dhall

let Command = ./command.dhall

let Config = ./config.dhall

let Keybind = ./keybinding.dhall

let makeKeybinds = ./makeKeybinds.dhall

let makeMods = ./makeMods.dhall

let Mod = ./modifiers.dhall

let showAction = ./showAction.dhall

let showMod = ./showMod.dhall

in  { Action
    , Command
    , Config
    , Keybind
    , makeKeybinds
    , makeMods
    , Mod
    , showAction
    , showMod
    }
