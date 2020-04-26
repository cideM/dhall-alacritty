let common = ./common.dhall

let keysLinux = ../keys/linux.dhall

let MouseIn
    : Type
    = common.MousebindingIn keysLinux.Action

let showBindings
    : List MouseIn → List common.Mousebinding
    = common.showBindings keysLinux.Action keysLinux.showAction

in  { showBindings, Mbd = MouseIn }
