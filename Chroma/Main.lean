/-
  Chroma - Color Picker Application
  Demo UI for the custom Arbor color picker widget.
-/
import Afferent
import Afferent.FFI
import Afferent.Widget
import Arbor
import Chroma.ColorPicker
import Trellis
import Tincture

open Afferent CanvasM
open Arbor
open Chroma
open Trellis (EdgeInsets)
open Tincture

def main : IO Unit := do
  IO.println "Chroma - Color Picker"

  let screenScale ← Afferent.FFI.getScreenScale
  let baseWidth : Float := 900.0
  let baseHeight : Float := 700.0
  let physWidth := (baseWidth * screenScale).toUInt32
  let physHeight := (baseHeight * screenScale).toUInt32

  let canvas ← Canvas.create physWidth physHeight "Chroma - Color Picker"

  let titleFont ← Font.load "/System/Library/Fonts/Monaco.ttf" (28 * screenScale).toUInt32
  let bodyFont ← Font.load "/System/Library/Fonts/Monaco.ttf" (16 * screenScale).toUInt32
  let (fontReg1, titleId) := FontRegistry.empty.register titleFont "title"
  let (fontReg, bodyId) := fontReg1.register bodyFont "body"

  let bg := Color.fromHex "#1a1a2e" |>.getD (Color.rgb 0.1 0.1 0.18)
  let pickerConfig : ColorPickerConfig := {
    size := 360.0 * screenScale
    ringThickness := 36.0 * screenScale
    segments := 144
    selectedHue := 0.08
    background := some (Color.gray 0.12)
    borderColor := some (Color.gray 0.35)
  }

  let mut c := canvas
  while !(← c.shouldClose) do
    c.pollEvents
    let ok ← c.beginFrame bg
    if ok then
      let widget := Arbor.build do
        column (gap := 24 * screenScale)
          (style := { padding := EdgeInsets.uniform (32 * screenScale) }) #[
            text' "Chroma" titleId Color.white .center,
            colorPicker pickerConfig,
            text' "Hue wheel (static demo)" bodyId (Color.gray 0.7) .center
          ]

      c ← CanvasM.run' c do
        Afferent.Widget.renderArborWidgetCentered fontReg widget
          (baseWidth * screenScale) (baseHeight * screenScale)
      c ← c.endFrame

  IO.println "Done!"
