let common = ./common.dhall

let keysWindows = ../keys/windows.dhall

let MouseIn
    : Type
    = common.MousebindingIn keysWindows.Action

let showBindings
    : List MouseIn → List common.Mousebinding
    = common.showBindings keysWindows.Action keysWindows.showAction

in  { showBindings, Mbd = MouseIn }
