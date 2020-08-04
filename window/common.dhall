{ Type =
    { dimensions : { columns : Natural, lines : Natural }
    , padding : { x : Natural, y : Natural }
    , position : Optional { x : Natural, y : Natural }
    , dynamic_padding : Bool
    , title : Text
    , dynamic_title : Bool
    }
, default =
  { dimensions = { columns = 80, lines = 24 }
  , padding = { x = 0, y = 0 }
  , position = Some { x = 0, y = 0 }
  , dynamic_padding = False
  , dynamic_title = True
  , title = "Alacritty"
  }
}
