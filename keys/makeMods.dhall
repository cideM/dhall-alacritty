let Prelude =
      https://prelude.dhall-lang.org/package.dhall sha256:6b90326dc39ab738d7ed87b970ba675c496bed0194071b332840a87261649dcd

let Mod = ./modifiers.dhall

let showMod = ./showMod.dhall

let makeMods
    : List Mod → Text
    = λ(mods : List Mod) → Prelude.Text.concatMapSep "|" Mod showMod mods

in  makeMods
