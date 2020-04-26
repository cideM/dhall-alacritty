let common = ./common.dhall

let Action = < CopySelection >

let showAction
    : Action → Text
    = λ(a : Action) → merge { CopySelection = "CopySelection" } a

let KeybindingInput
    : Type
    = common.KeybindingIn Action

let showBindings
    : List KeybindingInput → List common.Keybinding
    = common.showBindings Action showAction

in  { showBindings
    , KbdIn = KeybindingInput
    , Action
    , showAction
    , Modifier = common.Modifier
    , Mode = common.Mode
    , Command = common.Command
    , Kbd = common.Keybinding
    , CommonAction = common.Action
    }
