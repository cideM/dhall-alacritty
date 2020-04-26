let Mod = ./modifiers.dhall

let showMod =
        λ(m : Mod)
      → merge
          { Command = "Command"
          , Super = "Super"
          , Control = "Control"
          , Shift = "Shift"
          , Alt = "Alt"
          , Option = "Option"
          }
          m

in  showMod
