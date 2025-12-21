# Chroma Roadmap

A sophisticated color picker for artists and web developers.

## Phase 1: Core Color Picker

### Color Wheel
- [ ] HSL/HSV color wheel with draggable hue ring
- [ ] Saturation/lightness triangle or square picker
- [ ] Real-time color preview as you drag
- [ ] Numeric input fields for precise values

### Color Sliders
- [ ] RGB sliders (0-255)
- [ ] HSL sliders (H: 0-360°, S/L: 0-100%)
- [ ] HSV sliders
- [ ] Alpha/opacity slider
- [ ] Visual gradient backgrounds on each slider

### Input Methods
- [ ] Hex input field (#RRGGBB, #RGB, with/without alpha)
- [ ] CSS color name autocomplete (140+ named colors from Tincture)
- [ ] Eyedropper tool (sample from screen)
- [ ] Paste color from clipboard (auto-detect format)

### Color Preview
- [ ] Large swatch showing current color
- [ ] Checkerboard background for transparency visualization
- [ ] Before/after comparison (original vs modified)
- [ ] Text preview (dark/light text on color background)

---

## Phase 2: Color Harmony

### Harmony Generators
- [ ] Complementary (180° opposite)
- [ ] Analogous (adjacent hues)
- [ ] Triadic (120° apart)
- [ ] Split-complementary
- [ ] Tetradic/square (90° apart)
- [ ] Custom angle offset

### Harmony Visualization
- [ ] Color wheel overlay showing harmony points
- [ ] Linked swatches that update together
- [ ] Lock individual colors while adjusting others
- [ ] Drag harmony points on wheel to fine-tune

### Harmony Palettes
- [ ] Generate 3-7 color palettes from base color
- [ ] Monochromatic variations (tints, shades, tones)
- [ ] Warm/cool variations
- [ ] One-click palette randomization

---

## Phase 3: Color Spaces

### Space Visualization
- [ ] Toggle between color space views:
  - sRGB cube
  - HSL cylinder
  - OkLab perceptual space
  - CIELAB
- [ ] 3D interactive color space explorer
- [ ] Gamut boundary visualization

### Space Conversion
- [ ] Live conversion display (all spaces simultaneously)
- [ ] Copy values in any format:
  - Hex: `#ff6b35`
  - RGB: `rgb(255, 107, 53)`
  - HSL: `hsl(16, 100%, 60%)`
  - OkLab: `oklab(0.7 0.12 0.08)`
  - CMYK for print
- [ ] CSS modern syntax: `rgb(255 107 53 / 80%)`

### Perceptual Tools
- [ ] OkLab-based lightness adjustment (perceptually uniform)
- [ ] Chroma (saturation) adjustment in OkLCH
- [ ] Hue rotation in perceptual space

---

## Phase 4: Accessibility

### Contrast Checking
- [ ] WCAG 2.1 contrast ratio calculator
- [ ] AA/AAA pass/fail indicators for:
  - Normal text (4.5:1 / 7:1)
  - Large text (3:1 / 4.5:1)
  - UI components (3:1)
- [ ] APCA (Accessible Perceptual Contrast Algorithm) support
- [ ] Suggested adjustments to meet contrast requirements

### Color Blindness Simulation
- [ ] Protanopia (red-blind)
- [ ] Deuteranopia (green-blind)
- [ ] Tritanopia (blue-blind)
- [ ] Achromatopsia (total color blindness)
- [ ] Side-by-side normal vs simulated view
- [ ] Palette-wide simulation

### Accessibility Palette Tools
- [ ] "Safe palette" generator (distinguishable for all viewers)
- [ ] Contrast matrix for multi-color palettes
- [ ] Warning indicators for problematic color combinations

---

## Phase 5: Palette Management

### Palette Creation
- [ ] Create named palettes
- [ ] Add/remove/reorder colors
- [ ] Duplicate and modify palettes
- [ ] Generate palette from image (color extraction)
- [ ] AI-suggested palettes based on mood/theme

### Palette Organization
- [ ] Folders/categories for palettes
- [ ] Tags and search
- [ ] Favorite/star palettes
- [ ] Recent colors history
- [ ] Sort by hue, lightness, creation date

### Palette Analysis
- [ ] Palette harmony score
- [ ] Color distribution visualization
- [ ] Gap detection (missing hue ranges)
- [ ] Duplicate/similar color detection

---

## Phase 6: Gradients

### Gradient Builder
- [ ] Linear gradients with angle control
- [ ] Radial gradients with focal point
- [ ] Conic/sweep gradients
- [ ] Multi-stop gradients (unlimited stops)
- [ ] Drag stops to reposition

### Gradient Interpolation
- [ ] Choose interpolation color space:
  - sRGB (default, can have muddy midpoints)
  - OkLab (perceptually smooth)
  - HSL shorter/longer hue path
- [ ] Easing functions between stops
- [ ] Preview interpolation differences

### Gradient Export
- [ ] CSS gradient syntax
- [ ] SVG gradient
- [ ] PNG/image export at custom resolution
- [ ] Gradient presets library

---

## Phase 7: Export & Integration

### Export Formats
- [ ] Copy single color in any format
- [ ] Export palette as:
  - CSS custom properties (`:root { --primary: #fff; }`)
  - SCSS/Sass variables
  - Tailwind config
  - Swift/SwiftUI colors
  - JSON
  - ASE (Adobe Swatch Exchange)
  - GPL (GIMP Palette)
  - Procreate swatches

### Code Generation
- [ ] Generate color utility functions
- [ ] Theme object with semantic names
- [ ] Dark/light theme pair generation

### Sharing
- [ ] Shareable URL with encoded palette
- [ ] Export as image (palette card)
- [ ] QR code for mobile transfer

---

## Phase 8: Advanced Features

### Color Mixing
- [ ] Blend two colors with adjustable ratio
- [ ] Multiple blend modes (multiply, screen, overlay, etc.)
- [ ] Mix multiple colors (like paint mixing)
- [ ] Subtractive vs additive mixing toggle

### Color Adjustment
- [ ] Lighten/darken by percentage
- [ ] Saturate/desaturate
- [ ] Hue shift
- [ ] Temperature adjustment (warm/cool)
- [ ] Invert color
- [ ] Grayscale conversion

### Delta E Distance
- [ ] Measure perceptual distance between colors
- [ ] Find nearest named color
- [ ] Find nearest palette color
- [ ] Cluster similar colors

---

## Phase 9: UI/UX Polish

### Themes
- [ ] Dark mode (default)
- [ ] Light mode
- [ ] High contrast mode
- [ ] Custom accent color

### Keyboard Navigation
- [ ] Full keyboard control
- [ ] Vim-style navigation option
- [ ] Customizable shortcuts
- [ ] Quick command palette (Cmd+K style)

### Layout
- [ ] Resizable panels
- [ ] Collapsible sections
- [ ] Compact/expanded modes
- [ ] Multi-window support

### Performance
- [ ] 60fps color wheel interaction
- [ ] Instant color updates
- [ ] Efficient palette rendering (1000+ colors)

---

## Dependencies on Afferent

Features requiring Afferent development:

| Chroma Feature | Afferent Requirement |
|----------------|---------------------|
| Color wheel | Arc/circle rendering, drag interaction |
| Sliders | Gradient-filled rectangles, drag handles |
| Text input | Text rendering, cursor, selection |
| 3D color space | 3D mesh rendering (exists), camera controls |
| Eyedropper | Screen capture API |
| Image import | Image loading, pixel access |

---

## Tincture Features Already Available

Chroma can leverage these Tincture capabilities immediately:

- ✅ 10 color spaces (HSL, HSV, HWB, OkLab, OkLCH, Lab, LCH, XYZ, CMYK, Linear RGB)
- ✅ Color harmony generation (complementary, triadic, analogous, etc.)
- ✅ WCAG contrast ratio calculation
- ✅ APCA contrast calculation
- ✅ Color blindness simulation (all types)
- ✅ Delta E color distance
- ✅ 140+ named CSS colors
- ✅ Blend modes (multiply, screen, overlay, etc.)
- ✅ Gradient interpolation
- ✅ Hex/RGB/HSL parsing and formatting
- ✅ Color adjustment (lighten, darken, saturate, etc.)

---

## Milestones

### v0.1 - Foundation
- Basic color wheel
- RGB/HSL sliders
- Hex input
- Single color output

### v0.2 - Harmony
- Harmony generators
- 5-color palette view
- Basic contrast checker

### v0.3 - Professional
- Full accessibility suite
- Palette management
- Multiple export formats

### v0.4 - Complete
- Gradients
- 3D color space explorer
- Image color extraction

### v1.0 - Release
- Polished UI
- Full keyboard support
- Comprehensive documentation
