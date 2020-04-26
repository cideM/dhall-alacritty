let Level = ./level.dhall

in  { debug :
        { render_timer : Bool
        , persistent_logging : Bool
        , log_level : Level
        , print_events : Bool
        , ref_test : Bool
        }
    }
