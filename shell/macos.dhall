let common = ./common.dhall

in  { Type = common.Type
    , default = Some { program = "/bin/bash", args = [ "--login" ] }
    }
