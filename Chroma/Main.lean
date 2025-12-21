/-
  Chroma - Color Picker Application
  Initial hello world window to verify Afferent integration.
-/
import Afferent.FFI
import Tincture

open Afferent.FFI
open Tincture

def main : IO Unit := do
  IO.println "Chroma - Color Picker"
  IO.println "Initializing..."

  -- Initialize Afferent
  init

  -- Create window
  let window ← Window.create 1024 768 "Chroma - Color Picker"
  let renderer ← Renderer.create window

  IO.println "Window created. Close window to exit."

  -- Main render loop
  while !(← window.shouldClose) do
    window.pollEvents

    -- Use Tincture color for background (deep purple)
    let bg := Color.fromHex "#1a1a2e" |>.getD (Color.rgb 0.1 0.1 0.18)
    let frameOk ← renderer.beginFrame bg.r bg.g bg.b 1.0

    if frameOk then
      -- TODO: Render color picker UI
      renderer.endFrame

  -- Cleanup
  Renderer.destroy renderer
  Window.destroy window

  IO.println "Done!"
