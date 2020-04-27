# dhall-alacritty

## Quickstart

Create an alacritty.dhall file...

```dhall
let Alacritty = https://raw.githubusercontent.com/cideM/dhall-alacritty/master/linux.dhall

in  Alacritty.Config::{
    , window = Alacritty.Window.Schema::{
      , decorations = Alacritty.Window.Decoration.full
      , startup_mode = Alacritty.Window.Startup.Fullscreen
      , dynamic_padding = True
      }
    , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
    }
```

... and run `dhall-to-yaml --file alacritty.dhall --output alacritty.yml`

This will create the alacritty.yml configuration file with the defaults for linux. For windows or macos, just use a different `.dhall` file in the import.

## Why

I started this as a way of learning Dhall but then it escalated a bit and I ended up adding types for the entire alacritty config, including types and defaults for all platforms. The major goal here was learning about the language and implementing a maximum of type safety, not ergonomics. It should cover the entire configuration but if something is missing (be it a type or a constructor) or if I misinterpreted the comments in https://github.com/alacritty/alacritty/blob/master/alacritty.yml please let me know by creating an issue here in the repository!

I'm using this in my own [dotfiles](https://github.com/cideM/dotfiles) to generate my [alacritty config](https://github.com/cideM/dotfiles/blob/master/alacritty/.config/alacritty/linux.dhall)

## Overriding Defaults

### Basics

You can already see an example of how to override defaults above. The record you import from the GitHub URL has keys for each configuration segment and under those keys you can find both the schema and also all constructors you might need. Keep in mind that overriding the defauls of a schema (that's what `XXX::{ foo = "bar" }` does) is a shallow operation. Meaning...

```dhall
Foo::{ bar = { a = 1 } }
```

... will replace the record at `bar` with a new record. If `bar`s type is `bar : { a : Natural, b : Natural }` then you'll get a type error since you didn't specificy `b`. On the upside, you won't silently delete things due to the compiler safety.

### Keybindings

For keybindings there are some more steps. There are common keybindings (valid on all platforms) and keybindings specific to each platform.

```dhall
let Alacritty =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/linux.dhall

let keys =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/keys/common.dhall

let keysLinux =
      https://raw.githubusercontent.com/cideM/dhall-alacritty/master/keys/linux.dhall

let common =
      keys.showCommonBindings
        [ keys.CommonBinding.Action
            { key = "A"
            , mods = None (List keys.Modifier)
            , mode = None keys.Mode
            , action = keys.Action.SpawnNewInstance
            }
        ]

let linuxBindings =
      keysLinux.showBindings
        [ keysLinux.KbdIn.Action
            { key = "B"
            , mods = None (List keysLinux.Modifier)
            , mode = None keysLinux.Mode
            , action = keysLinux.Action.CopySelection
            }
        ]

in  Alacritty.Config::{
    , window = Alacritty.Window.Schema::{
      , decorations = Alacritty.Window.Decoration.full
      , startup_mode = Alacritty.Window.Startup.Fullscreen
      , dynamic_padding = True
      }
    , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
    , key_bindings = common # linuxBindings
    }
```

You create a set of common bindings and a set of platform bindings, then **you render both of them before joining them**. The reason for this is a bit more complicated and not really relevant. Basically rendering the keybinding records (with `showBindings`) converts them into a platform which is valid regardless of platform.

### Mousebindings

The same concept as for keybindings applies. There's a set of common bindings and platform specific bindings. Render them before joining the lists.

