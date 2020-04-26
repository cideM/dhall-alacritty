let Level = < None | Error | Warn | Info | Debug | Trace >

let Schema =
      { Type =
          { render_timer : Bool
          , persistent_logging : Bool
          , log_level : Level
          , print_events : Bool
          , ref_test : Bool
          }
      , default =
        { render_timer = False
        , persistent_logging = False
        , log_level = Level.Warn
        , print_events = False
        , ref_test = False
        }
      }

in  { Schema, Level }
