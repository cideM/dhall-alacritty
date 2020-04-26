let Font = ./font/package.dhall

let Keys = ./keys/package.dhall

let Window = ./window/package.dhall

let Env = ./env/package.dhall

let Shell = ./shell/package.dhall

let Scrolling = ./scrolling/package.dhall

let Debug = ./debug/package.dhall

let VisualBell = ./visual/package.dhall

let Opacity = ./opacity/package.dhall

let MouseBindings = ./mouse_bindings/package.dhall

let Mouse = ./mouse/package.dhall

let Misc = ./misc/package.dhall

let Cursor = ./cursor/package.dhall

let Colors = ./colors/package.dhall

let OS = ./os.dhall

let makeConfig =
        λ(os : OS)
      → let ConfigType =
                Env.Config
              ⩓ Window.Config os
              ⩓ Scrolling.Config
              ⩓ Font.Config os
              ⩓ Debug.Config
              ⩓ VisualBell.Config
              ⩓ Opacity.Config
              ⩓ Keys.Config
              ⩓ Shell.Config
              ⩓ MouseBindings.Config
              ⩓ Mouse.Config
              ⩓ Misc.Config
              ⩓ Cursor.Config
              ⩓ Colors.Config

        let W = Window ⫽ { Startup = ./window/startup.dhall os }

        in  { Config = ConfigType
            , Font
            , Keys
            , Env
            , Shell
            , Scrolling
            , Debug
            , Window = W
            , VisualBell
            , Opacity
            , MouseBindings
            , Mouse
            , Misc
            , Cursor
            , Colors
            }

in  makeConfig
