/-
  Chroma Color Picker Widget
  Custom Arbor widget that renders a hue wheel.
-/
import Arbor
import Tincture

open Arbor
open Tincture

namespace Chroma

structure ColorPickerConfig where
  size : Float := 320.0
  ringThickness : Float := 36.0
  segments : Nat := 120
  selectedHue : Float := 0.08
  selectedSaturation : Float := 1.0
  selectedValue : Float := 1.0
  showCenter : Bool := true
  background : Option Color := none
  borderColor : Option Color := some (Color.gray 0.25)
deriving Repr

def circlePoints (center : Point) (radius : Float) (steps : Nat) : Array Point :=
  Id.run do
    let steps := max 3 steps
    let twoPi : Float := 6.283185307179586
    let step := twoPi / steps.toFloat
    let mut pts : Array Point := Array.mkEmpty steps
    for i in [:steps] do
      let angle := step * i.toFloat
      let p := Point.mk'
        (center.x + radius * Float.cos angle)
        (center.y + radius * Float.sin angle)
      pts := pts.push p
    return pts

def ringSegmentPoints (center : Point) (inner outer : Float) (a0 a1 : Float) : Array Point :=
  let cos0 := Float.cos a0
  let sin0 := Float.sin a0
  let cos1 := Float.cos a1
  let sin1 := Float.sin a1
  let outer0 := Point.mk' (center.x + outer * cos0) (center.y + outer * sin0)
  let outer1 := Point.mk' (center.x + outer * cos1) (center.y + outer * sin1)
  let inner1 := Point.mk' (center.x + inner * cos1) (center.y + inner * sin1)
  let inner0 := Point.mk' (center.x + inner * cos0) (center.y + inner * sin0)
  #[outer0, outer1, inner1, inner0]

def colorPickerSpec (config : ColorPickerConfig) : CustomSpec :=
  { measure := fun availWidth availHeight =>
      let size := min config.size (min availWidth availHeight)
      (size, size)
    collect := fun layout =>
      Id.run do
        let content := layout.contentRect
        let center := Point.mk' (content.x + content.width / 2) (content.y + content.height / 2)
        let radius := min content.width content.height / 2
        let innerRadius := max 0 (radius - config.ringThickness)
        let segments := max 1 config.segments
        let twoPi : Float := 6.283185307179586
        let step := twoPi / segments.toFloat
        let mut cmds : Array RenderCommand := #[]

        -- Hue ring
        for i in [:segments] do
          let a0 := step * i.toFloat
          let a1 := step * (i + 1).toFloat
          let hue := (i.toFloat + 0.5) / segments.toFloat
          let color := Color.hsv hue 1.0 1.0
          let points := ringSegmentPoints center innerRadius radius a0 a1
          cmds := cmds.push (.fillPolygon points color)

        -- Center preview
        if config.showCenter && innerRadius > 2 then
          let previewRadius := innerRadius * 0.6
          if previewRadius > 1 then
            let previewColor := Color.hsv config.selectedHue config.selectedSaturation config.selectedValue
            let preview := circlePoints center previewRadius 64
            cmds := cmds.push (.fillPolygon preview previewColor)

        -- Outer border
        if let some border := config.borderColor then
          let outer := circlePoints center radius 96
          cmds := cmds.push (.strokePolygon outer border 1.0)
        return cmds }

def colorPicker (config : ColorPickerConfig) : WidgetBuilder := do
  let style : BoxStyle := {
    backgroundColor := config.background
    borderColor := none
    borderWidth := 0
    minWidth := some config.size
    minHeight := some config.size
  }
  custom (colorPickerSpec config) style

end Chroma
