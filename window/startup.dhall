let OS = ../os.dhall

let MacOS = < Windowed | Maximized | Fullscreen | SimpleFullscreen >

let Linux = < Windowed | Maximized | Fullscreen >

in  λ(os : OS) → merge { MacOS, Linux } os
