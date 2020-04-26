let common = ./common.dhall

in  { Type = common.Type ⩓ { use_thin_strokes : Bool }
    , default =
          common.default
        ⫽ { normal = { family = "Menlo", style = "Regular" }
          , bold = { family = "Menlo", style = "Bold" }
          , italic = { family = "Menlo", style = "Italic" }
          , bold_italic = { family = "Menlo", style = "Bold Italic" }
          , use_thin_strokes = True
          }
    }
