let Prelude =
    -- *************IMPORTANT*************
    -- **Please see the read_this_first.md in the /keys folder for info on the polymorphism here**
    -- *************IMPORTANT*************
      https://prelude.dhall-lang.org/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let keys = ../keys/common.dhall

let Mouse
    : Type
    = < Left | Middle | Right | Numeric : Natural >

let handleMouse
    : Mouse → Text
    = λ(m : Mouse) →
        merge
          { Left = "Left"
          , Middle = "Middle"
          , Right = "Right"
          , Numeric = λ(n : Natural) → Prelude.Natural.show n
          }
          m

let Mousebinding = { mouse : Text, mods : Optional Text, action : Text }

let MousebindingIn
    : Type → Type
    = λ(action : Type) →
        { mouse : Mouse, mods : Optional (List keys.Modifier), action : action }

let makeBinding
    : ∀(action : Type) →
      ∀(show : action → Text) →
      ∀(bindingIn : MousebindingIn action) →
        Mousebinding
    = λ(action : Type) →
      λ(show : action → Text) →
      λ(b : MousebindingIn action) →
        let mods = keys.makeModsOpt b.mods

        let act = show b.action

        let m = handleMouse b.mouse

        in  { mouse = m, mods, action = act }

let showBindings
    : ∀(action : Type) →
      ∀(show : action → Text) →
      List (MousebindingIn action) →
        List Mousebinding
    = λ(action : Type) →
      λ(show : action → Text) →
      λ(bds : List (MousebindingIn action)) →
        Prelude.List.map
          (MousebindingIn action)
          Mousebinding
          (makeBinding action show)
          bds

let CommonBinding = MousebindingIn keys.Action

let showCommonBindings = showBindings keys.Action keys.showAction

in  { Mousebinding
    , showBindings
    , MousebindingIn
    , CommonBinding
    , showCommonBindings
    }
