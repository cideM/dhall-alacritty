let Variant = { family : Text, style : Text }

in  { Type =
        { normal : Variant
        , bold : Variant
        , italic : Variant
        , bold_italic : Variant
        , size : Double
        , offset : { x : Integer, y : Integer }
        , glyph_offset : { x : Integer, y : Integer }
        }
    , default =
      { normal = { family = "monospace", style = "Regular" }
      , bold = { family = "monospace", style = "Bold" }
      , italic = { family = "monospace", style = "Italic" }
      , bold_italic = { family = "monospace", style = "Bold Italic" }
      , size = 11.0
      , offset = { x = +0, y = +0 }
      , glyph_offset = { x = +0, y = +0 }
      }
    }
