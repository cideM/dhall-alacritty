let common = ./common.dhall

let Schema =
      { Type = common.Schema.Type
      , default =
            common.Schema.default
          ⫽ { url =
                  common.Schema.default.url
                ⫽ { launcher =
                        common.Schema.default.url.launcher
                      ⫽ { program = "explorer" }
                  }
            }
      }

in  { Schema
    , Modifier = common.Modifier
    , handleModifier = common.handleModifier
    , CommonModifier = common.Modifier
    }
