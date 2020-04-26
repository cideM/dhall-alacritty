# dhall-alacritty

## Quickstart

Create an alacritty.dhall file...

```dhall
let Alacritty = https://github.com/cideM/dhall-alacritty

in  Alacritty.Config::{
    , window = Alacritty.Window.Schema::{
      , decorations = Alacritty.Window.Decoration.full
      , startup_mode = Alacritty.Window.Startup.Fullscreen
      , dynamic_padding = True
      }
    , shell = Some { program = "/usr/bin/fish", args = [ "-l" ] }
    }

```

* TODO: Write Readme
* TODO: Add some README.md files to complicated parts of the codebase
* TODO: Add some helpful inline docs
* TODO: Create repo
* TODO: Write blog post
* TODO: publish first on dhall lang
