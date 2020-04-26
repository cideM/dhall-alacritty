let common = ./common.dhall

let keysMacos = ../keys/macos.dhall

let MouseIn
    : Type
    = common.MousebindingIn keysMacos.Action

let showBindings
    : List MouseIn → List common.Mousebinding
    = common.showBindings keysMacos.Action keysMacos.showAction

in  { showBindings, Mbd = MouseIn }
