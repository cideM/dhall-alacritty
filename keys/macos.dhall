let common = ./common.dhall

let Action = < ToggleSimpleFullscreen >

let showAction
    : Action → Text
    =   λ(a : Action)
      → merge { ToggleSimpleFullscreen = "ToggleSimpleFullscreen" } a

let KeybindingInput
    : Type
    = common.KeybindingIn Action

let showBindings
    : List KeybindingInput → List common.Keybinding
    = common.showBindings Action showAction

in  { showBindings
    , Kbd = KeybindingInput
    , Action
    , Modifier = common.Modifier
    , showAction
    , Mode = common.Mode
    , Command = common.Command
    , CommonAction = common.Action
    , Binding = common.Keybinding
    }
