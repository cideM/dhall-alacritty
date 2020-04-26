let Prelude =
    -- *************IMPORTANT*************
    -- **Please see the read_this_first.md in this folder for info on the polymorphism here**
    -- *************IMPORTANT*************
      https://prelude.dhall-lang.org/package.dhall sha256:6b90326dc39ab738d7ed87b970ba675c496bed0194071b332840a87261649dcd

let Action
    : Type
    = < ToggleViMode
      | Copy
      | Paste
      | PasteSelection
      | IncreaseFontSize
      | DecreaseFontSize
      | ResetFontSize
      | ScrollPageUp
      | ScrollPageDown
      | ScrollLineUp
      | ScrollLineDown
      | ScrollToTop
      | ScrollHalfPageUp
      | ScrollHalfPageDown
      | ScrollToBottom
      | ClearHistory
      | Hide
      | Minimize
      | Quit
      | ToggleFullscreen
      | SpawnNewInstance
      | ClearLogNotice
      | ClearSelection
      | ReceiveChar
      | None
      | Open
      | Up
      | Down
      | Left
      | Right
      | First
      | Last
      | FirstOccupied
      | High
      | Middle
      | Low
      | SemanticLeft
      | SemanticRight
      | SemanticLeftEnd
      | SemanticRightEnd
      | WordRight
      | WordLeft
      | WordRightEnd
      | WordLeftEnd
      | Bracket
      | ToggleNormalSelection
      | ToggleLineSelection
      | ToggleBlockSelection
      | ToggleSemanticSelection
      >

let showAction
    : Action → Text
    =   λ(a : Action)
      → merge
          { ToggleViMode = "ToggleViMode"
          , Copy = "Copy"
          , Paste = "Paste"
          , PasteSelection = "PasteSelection"
          , IncreaseFontSize = "IncreaseFontSize"
          , DecreaseFontSize = "DecreaseFontSize"
          , ResetFontSize = "ResetFontSize"
          , ScrollPageUp = "ScrollPageUp"
          , ScrollPageDown = "ScrollPageDown"
          , ScrollLineUp = "ScrollLineUp"
          , ScrollLineDown = "ScrollLineDown"
          , ScrollToTop = "ScrollToTop"
          , ScrollToBottom = "ScrollToBottom"
          , ScrollHalfPageDown = "ScrollHalfPageDown"
          , ScrollHalfPageUp = "ScrollHalfPageUp"
          , ClearHistory = "ClearHistory"
          , Hide = "Hide"
          , Minimize = "Minimize"
          , Quit = "Quit"
          , ToggleFullscreen = "ToggleFullscreen"
          , SpawnNewInstance = "SpawnNewInstance"
          , ClearLogNotice = "ClearLogNotice"
          , ClearSelection = "ClearSelection"
          , ReceiveChar = "ReceiveChar"
          , None = "None"
          , Open = "Open"
          , Up = "Up"
          , Down = "Down"
          , Left = "Left"
          , Right = "Right"
          , First = "First"
          , Last = "Last"
          , FirstOccupied = "FirstOccupied"
          , High = "High"
          , Middle = "Middle"
          , Low = "Low"
          , SemanticLeft = "SemanticLeft"
          , SemanticRight = "SemanticRight"
          , SemanticLeftEnd = "SemanticLeftEnd"
          , SemanticRightEnd = "SemanticRightEnd"
          , WordRight = "WordRight"
          , WordLeft = "WordLeft"
          , WordRightEnd = "WordRightEnd"
          , WordLeftEnd = "WordLeftEnd"
          , Bracket = "Bracket"
          , ToggleNormalSelection = "ToggleNormalSelection"
          , ToggleLineSelection = "ToggleLineSelection"
          , ToggleBlockSelection = "ToggleBlockSelection"
          , ToggleSemanticSelection = "ToggleSemanticSelection"
          }
          a

let Command
    : Type
    = { program : Text, args : List Text }

let Modifier
    : Type
    = < Command | Super | Control | Shift | Alt | Option >

let showMod =
        λ(m : Modifier)
      → merge
          { Command = "Command"
          , Super = "Super"
          , Control = "Control"
          , Shift = "Shift"
          , Alt = "Alt"
          , Option = "Option"
          }
          m

let makeMods
    : List Modifier → Text
    =   λ(mods : List Modifier)
      → Prelude.Text.concatMapSep "|" Modifier showMod mods

let makeModsOpt
    : Optional (List Modifier) → Optional Text
    =   λ(mods : Optional (List Modifier))
      → Prelude.Optional.map (List Modifier) Text makeMods mods

let Mode
    : Type
    = < AppCursor
      | NotAppCursor
      | AppKeypad
      | NotAppKeypad
      | Alt
      | NotAlt
      | Vi
      | NotVi
      >

let handleMode
    : Mode → Text
    =   λ(m : Mode)
      → merge
          { AppCursor = "AppCursor"
          , NotAppCursor = "~AppCursor"
          , AppKeypad = "AppKeypad"
          , NotAppKeypad = "~AppKeypad"
          , Alt = "Alt"
          , NotAlt = "~Alt"
          , Vi = "Vi"
          , NotVi = "~Vi"
          }
          m

let showMode
    : Optional Mode → Optional Text
    = λ(mode : Optional Mode) → Prelude.Optional.map Mode Text handleMode mode

let Keybinding =
    -- Type for a keybinding rendered to yaml format. Has less type safety than
    -- the input keybinding types, which represent mods as union types for example
      < Action :
          { key : Text
          , mode : Optional Text
          , mods : Optional Text
          , action : Text
          }
      | Chars :
          { key : Text
          , mode : Optional Text
          , mods : Optional Text
          , chars : Text
          }
      | Command :
          { key : Text
          , mode : Optional Text
          , mods : Optional Text
          , command : Command
          }
      >

let CharsBinding =
      { key : Text
      , mode : Optional Mode
      , mods : Optional (List Modifier)
      , chars : Text
      }

let charsHandler =
        λ(cb : CharsBinding)
      → Keybinding.Chars
          { key = cb.key
          , mode = showMode cb.mode
          , chars = cb.chars
          , mods = makeModsOpt cb.mods
          }

let CommandBinding =
      { key : Text
      , mode : Optional Mode
      , mods : Optional (List Modifier)
      , command : Command
      }

let commandHandler =
        λ(cb : CommandBinding)
      → Keybinding.Command
          { key = cb.key
          , mode = showMode cb.mode
          , command = cb.command
          , mods = makeModsOpt cb.mods
          }

let ActionBinding
    : ∀(action : Type) → Type
    =   λ(action : Type)
      → { key : Text
        , mode : Optional Mode
        , mods : Optional (List Modifier)
        , action : action
        }

let actionHandler
    :   ∀(action : Type)
      → ∀(show : action → Text)
      → ∀(bdg : ActionBinding action)
      → Keybinding
    =   λ(action : Type)
      → λ(show : action → Text)
      → λ(bdg : ActionBinding action)
      → Keybinding.Action
          { key = bdg.key
          , mode = showMode bdg.mode
          , action = show bdg.action
          , mods = makeModsOpt bdg.mods
          }

let KeybindingIn
    : ∀(action : Type) → Type
    =   λ(action : Type)
      → < Action : ActionBinding action
        | Chars : CharsBinding
        | Command : CommandBinding
        >

let handleBinding
    :   ∀(action : Type)
      → ∀(show : action → Text)
      → ∀(bdg : KeybindingIn action)
      → Keybinding
    =   λ(action : Type)
      → λ(show : action → Text)
      → λ(bdg : KeybindingIn action)
      → merge
          { Action = actionHandler action show
          , Chars = charsHandler
          , Command = commandHandler
          }
          bdg

let showBindings
    :   ∀(action : Type)
      → ∀(show : action → Text)
      → List (KeybindingIn action)
      → List Keybinding
    =   λ(action : Type)
      → λ(show : action → Text)
      → λ(kbds : List (KeybindingIn action))
      → Prelude.List.map
          (KeybindingIn action)
          Keybinding
          (handleBinding action show)
          kbds

let CommonBinding = KeybindingIn Action

let showCommonBindings = showBindings Action showAction

in  { makeMods
    , makeModsOpt
    , Keybinding
    , showBindings
    , showAction
    , KeybindingIn
    , Command
    , Modifier
    , Action
    , Mode
    , showCommonBindings
    , CommonBinding
    }
