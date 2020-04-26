# Read This First!

In a nutshell, the actions which can be bound to keyboard and mouse keys can easily be expressed as one big union type. Unfortunately there is not yet support for extending union types in Dhall (https://github.com/dhall-lang/dhall-lang/issues/175). But I also didn't want to duplicate the long list of actions. So I made the `action` polymorphic. A keybinding (or mousebinding) can be one of three kinds: chars, command or action. The last kind, action, is polymorphic. To create a concrete keybinding you need to pass **both the action type and the showAction function**.


```dhall
let Action
    : Type
    = < ToggleViMode
      | Copy
      >

let showAction
    : Action → Text
    =   λ(a : Action)
      → merge
          { ToggleViMode = "ToggleViMode"
          , Copy = "Copy"
          }
          a

let showBindings
    :   ∀(action : Type)
      → ∀(show : action → Text)
      → List (KeybindingIn action)
      → List Keybinding

let showCommonBindings = showBindings Action showAction
```

The above example shows both the type signature of the polymorphic `showBindings` function and also how it's used to create a more concrete version of `showBindings` which can show the common bindings. The same is done for each platform. It's essentially **really simple**, don't be scared of by the complicated looking type signature. But it's just passing around the type of the action and how to show the action (meaning turn an action into a text).
