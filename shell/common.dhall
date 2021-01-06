let Default = { program : Text, args : List Text }

in  { Type = Optional Default
    , default = Some { program = "/bin/bash", args = [ "--login" ] }
    , Default
    }
