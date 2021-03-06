# dhall-alacritty

## Archived

This repository hasn't been updated in a long time and it's guaranteed to no longer represent the actual configuration options of Alacritty. If I ever find the time and motivation to revisit this, here are some TODOs:

- Figure out how to maintain different versions of the configuration in one repository. Meaning one for Alacritty 4.0.0, another for 5.0.0, and so on
- Handle platform differences in a better way. Usually there's a common set of options which is then extended for each platform. The [issue on combinding unions might be relevant](https://github.com/dhall-lang/dhall-lang/issues/175)

## Quickstart

_requires dhall to be installed_

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

This will create the alacritty.yml configuration file with the defaults for linux and some customziations. For windows or macos, just use a different `.dhall` file in the import.

If you only want to override specific keys you can easily do so using `with`:

```dhall
let Alacritty = ~/private/dhall-alacritty/linux.dhall

in  Alacritty.Config::{
    , font = ./mono.dhall
    , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
    , colors = ./papercolor.dhall
    , key_bindings = ./keys_common.dhall
    }
  with window.decorations = Alacritty.Window.Decoration.full
  with window.dynamic_padding = True
```

(Notice that I no longer need to specify the `Alacritty.Window.Schema::{}`)

## Why

I started this as a way of learning Dhall but then it escalated a bit and I ended up adding types for the entire alacritty config, including types and defaults for all platforms. The major goal here was learning about the language and implementing a maximum of type safety, not ergonomics. It should cover the entire configuration but if something is missing (be it a type or a constructor) or if I misinterpreted the comments in https://github.com/alacritty/alacritty/blob/master/alacritty.yml please let me know by creating an issue here in the repository!

## Overriding Defaults

### Basics

You can already see an example of how to override defaults above. The record you import from the GitHub URL has keys for each configuration segment and under those keys you can find both the schema and also all constructors you might need. Keep in mind that overriding the defauls of a schema (that's what `XXX::{ foo = "bar" }` does) is a shallow operation. Meaning...

```dhall
Foo::{ bar = { a = 1 } }
```

... will replace the record at `bar` with a new record. If `bar`s type is `bar : { a : Natural, b : Natural }` then you'll get a type error since you didn't specify `b`. On the upside, you won't silently delete things due to the compiler safety.

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

