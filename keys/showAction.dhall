let Action = ./action.dhall

let showAction =
        λ(a : Action)
      → merge
          { Paste = "Paste"
          , PasteSelection = "PasteSelection"
          , Copy = "Copy"
          , Quit = "Quit"
          , ResetFontSize = "ResetFontSize"
          , IncreaseFontSize = "IncreaseFontSize"
          , DecreaseFontSize = "DecreaseFontSize"
          , SpawnNewInstance = "SpawnNewInstance"
          }
          a

in  showAction
