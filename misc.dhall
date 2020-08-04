{ Type =
    { selection : { semantic_escape_chars : Text, save_to_clipboard : Bool }
    , live_config_reload : Bool
    , draw_bold_text_with_bright_colors : Bool
    }
, default =
  { selection =
    { semantic_escape_chars = "',│`|:\"' ()[]{}<>", save_to_clipboard = False }
  , live_config_reload = True
  , draw_bold_text_with_bright_colors = False
  }
}
