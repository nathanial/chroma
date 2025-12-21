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

open Afferent CanvasM
open Arbor
open Chroma
open Trellis (EdgeInsets)
open Tincture

structure PickerState where
  hue : Float := 0.08
  dragging : Bool := false
deriving Repr

inductive Msg where
  | SetHue (hue : Float)
  | StartDrag
  | EndDrag
deriving Repr

def update (msg : Msg) (state : PickerState) : PickerState :=
  match msg with
  | .SetHue hue => { state with hue }
  | .StartDrag => { state with dragging := true }
  | .EndDrag => { state with dragging := false }

def pickerHandler (config : ColorPickerConfig) : Handler Msg :=
  fun ctx ev =>
    match ev, ctx.globalPos with
    | .mouseDown _e, some p =>
      match hueFromPoint ctx.layout.contentRect config p.x p.y with
      | some hue =>
        { msgs := #[.SetHue hue, .StartDrag], capture := some ctx.widgetId }
      | none => {}
    | .mouseMove _e, some p =>
      if ctx.isCaptured then
        let hue := hueFromPosition ctx.layout.contentRect p.x p.y
        { msgs := #[.SetHue hue] }
      else
        {}
    | .mouseUp _e, _ =>
      { msgs := #[.EndDrag], releaseCapture := true }
    | _, _ => {}

def buildChromaUI (titleId bodyId : FontId) (config : ColorPickerConfig) (screenScale : Float) : UI Msg :=
  UIBuilder.buildFrom 0 do
    let widget ← UIBuilder.lift do
      column (gap := 24 * screenScale)
        (style := { padding := EdgeInsets.uniform (32 * screenScale) }) #[
          text' "Chroma" titleId Color.white .center,
          colorPicker config,
          text' "Drag on the ring to set hue" bodyId (Color.gray 0.7) .center
        ]
    -- Widget IDs (build order):
    -- 0: column root
    -- 1: title text
    -- 2: color picker
    -- 3: subtitle text
    UIBuilder.register 2 (pickerHandler config)
    pure widget

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
  let app : Afferent.App.UIApp PickerState Msg := {
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
      buildChromaUI titleId bodyId config screenScale
    update := update
    background := bg
    layout := .centeredIntrinsic
    sendHover := true
  }

  Afferent.App.run canvas fontReg {} app

  IO.println "Done!"
