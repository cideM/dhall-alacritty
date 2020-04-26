let common = ./common.dhall

in  { Type = common.Type
    , default = Some { program = "powershell", args = [] : List Text }
    }
