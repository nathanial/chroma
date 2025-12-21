/-
  Chroma - Color Picker Application
  Demo UI for the custom Arbor color picker widget.
-/
import Afferent
import Afferent.App.UIRunner
import Afferent.FFI
import Afferent.Widget
import Arbor
import Chroma.ColorPicker
import Trellis
import Tincture

open Afferent
open Chroma
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
  let app : Afferent.App.UIApp PickerModel PickerMsg := {
    view := fun model =>
      let config : ColorPickerConfig := {
        size := 360.0 * screenScale
        ringThickness := 36.0 * screenScale
        segments := 144
        selectedHue := model.hue
        knobWidth := 22.0 * screenScale
        knobHeight := 10.0 * screenScale
        background := some (Color.gray 0.12)
        borderColor := some (Color.gray 0.35)
      }
      pickerUI titleId bodyId config screenScale
    update := updatePicker
    background := bg
    layout := .centeredIntrinsic
    sendHover := true
  }

  Afferent.App.run canvas fontReg {} app

  IO.println "Done!"
