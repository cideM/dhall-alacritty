let OS = ../os.dhall

let Variant = ./variant.dhall

let Linux =
      { normal : Variant
      , bold : Variant
      , italic : Variant
      , size : Double
      , offset : { x : Integer, y : Integer }
      , glyph_offset : { x : Integer, y : Integer }
      }

let MacOS = Linux ⩓ { use_thin_strokes : Bool }

in  λ(os : OS) → merge { MacOS, Linux } os
