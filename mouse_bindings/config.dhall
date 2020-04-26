let Action = ./action.dhall

let Input = ./input.dhall

in  { mouse_bindings : List { mouse : Input, action : Action } }
