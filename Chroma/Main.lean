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

structure PickerState where
  hue : Float := 0.08
  dragging : Bool := false
deriving Repr

def buildChromaUI (titleId bodyId : FontId) (config : ColorPickerConfig) (screenScale : Float) : Widget × WidgetId :=
  -- Widget IDs (build order):
  -- 0: column root
  -- 1: title text
  -- 2: color picker
  -- 3: subtitle text
  let widget := Arbor.buildFrom 0 do
    column (gap := 24 * screenScale)
      (style := { padding := EdgeInsets.uniform (32 * screenScale) }) #[
        text' "Chroma" titleId Color.white .center,
        colorPicker config,
        text' "Drag on the ring to set hue" bodyId (Color.gray 0.7) .center
      ]
  (widget, 2)

def prepareLayout (reg : FontRegistry) (widget : Widget)
    (screenW screenH : Float) : IO (Widget × Trellis.LayoutResult × Float × Float) := do
  let (intrinsicW, intrinsicH) ← Afferent.runWithFonts reg (Arbor.intrinsicSize widget)
  let measureResult ← Afferent.runWithFonts reg (Arbor.measureWidget widget intrinsicW intrinsicH)
  let layouts := Trellis.layout measureResult.node intrinsicW intrinsicH
  let offsetX := (screenW - intrinsicW) / 2
  let offsetY := (screenH - intrinsicH) / 2
  pure (measureResult.widget, layouts, offsetX, offsetY)

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
  let mut pickerState : PickerState := {}

  let mut c := canvas
  while !(← c.shouldClose) do
    c.pollEvents
    let ok ← c.beginFrame bg
    if ok then
      let pickerConfig : ColorPickerConfig := {
        size := 360.0 * screenScale
        ringThickness := 36.0 * screenScale
        segments := 144
        selectedHue := pickerState.hue
        knobWidth := 22.0 * screenScale
        knobHeight := 10.0 * screenScale
        background := some (Color.gray 0.12)
        borderColor := some (Color.gray 0.35)
      }
      let (widget, pickerId) := buildChromaUI titleId bodyId pickerConfig screenScale

      -- Pointer-driven hue selection
      let (mx, my) ← Afferent.FFI.Window.getMousePos c.ctx.window
      let buttons ← Afferent.FFI.Window.getMouseButtons c.ctx.window
      let leftDown := (buttons &&& (1 : UInt8)) != (0 : UInt8)
      let (_measured, layouts, offsetX, offsetY) ← prepareLayout fontReg widget
        (baseWidth * screenScale) (baseHeight * screenScale)
      match layouts.get pickerId with
      | some pickerLayout =>
        let localX := mx - offsetX
        let localY := my - offsetY
        if leftDown then
          if pickerState.dragging then
            let hue := hueFromPosition pickerLayout.contentRect localX localY
            pickerState := { pickerState with hue, dragging := true }
          else
            match hueFromPoint pickerLayout.contentRect pickerConfig localX localY with
            | some hue =>
              pickerState := { pickerState with hue, dragging := true }
            | none => pure ()
        else
          pickerState := { pickerState with dragging := false }
      | none =>
        if !leftDown then
          pickerState := { pickerState with dragging := false }

      c ← CanvasM.run' c do
        Afferent.Widget.renderArborWidgetCentered fontReg widget
          (baseWidth * screenScale) (baseHeight * screenScale)
      c ← c.endFrame

  IO.println "Done!"
