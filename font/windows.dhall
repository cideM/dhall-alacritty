let common = ./common.dhall

in  { Type = common.Type
    , default =
          common.default
        ⫽ { normal = { family = "Consolas", style = "Regular" }
          , bold = { family = "Consolas", style = "Bold" }
          , italic = { family = "Consolas", style = "Italic" }
          , bold_italic = { family = "Consolas", style = "Bold Italic" }
          }
    }
