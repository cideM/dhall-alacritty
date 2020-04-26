let Prelude =
      https://prelude.dhall-lang.org/package.dhall sha256:6b90326dc39ab738d7ed87b970ba675c496bed0194071b332840a87261649dcd

let Mods = ./modifiers.dhall

let Keybind = ./keybinding.dhall

let Action = ./action.dhall

let showAction = ./showAction.dhall

let showMod = ./showMod.dhall

let makeMods
    : List Mods → Text
    = λ(mods : List Mods) → Prelude.Text.concatMapSep "|" Mods showMod mods

let makeKeybind
    : Keybind.Raw.Type → Keybind.Keybind
    =   λ(opts : Keybind.Raw.Type)
      → let mods = Prelude.Optional.map (List Mods) Text makeMods opts.mods

        let action = Prelude.Optional.map Action Text showAction opts.action

        in  { key = opts.key
            , mods
            , chars = opts.chars
            , action
            , command = opts.command
            }

let makeKeybinds
    : List Keybind.Raw.Type → List Keybind.Keybind
    = Prelude.List.map Keybind.Raw.Type Keybind.Keybind makeKeybind

in  makeKeybinds
