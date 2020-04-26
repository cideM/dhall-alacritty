let Decoration = < full | transparent | buttonless | none >

let Startup = < Windowed | Maximized | Fullscreen | SimpleFullscreen >

let Config =
        (./common.dhall).Type
      ⩓ { decorations : Decoration, startup_mode : Startup }

let Schema =
      { Type = Config
      , default =
            (./common.dhall).default
          ∧ { decorations = Decoration.full, startup_mode = Startup.Windowed }
      }

in  { Schema, Decoration, Startup }
