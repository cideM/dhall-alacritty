let Animation =
      < Ease
      | EaseOut
      | EaseOutSine
      | EaseOutQuad
      | EaseOutCubic
      | EaseOutQuart
      | EaseOutQuint
      | EaseOutExpo
      | EaseOutCirc
      | Linear
      >

let Schema =
      { Type = { animation : Animation, duration : Natural, color : Text }
      , default =
        { animation = Animation.EaseOutExpo, duration = 0, color = "#ffffff" }
      }

in  { Animation, Schema }
