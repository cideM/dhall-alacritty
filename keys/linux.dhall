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
    , Modifier = common.Modifier
    , Mode = common.Mode
    , showAction
    , Command = common.Command
    , Binding = common.Keybinding
    }
