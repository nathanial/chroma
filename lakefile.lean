import Lake
open Lake DSL

package chroma where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require tincture from git "https://github.com/nathanial/tincture" @ "v0.0.1"
require trellis from git "https://github.com/nathanial/trellis" @ "v0.0.1"
require arbor from git "https://github.com/nathanial/arbor" @ "v0.0.1"
require afferent from git "https://github.com/nathanial/afferent" @ "v0.0.1"

-- Test dependencies
require crucible from git "https://github.com/nathanial/crucible" @ "v0.0.1"

require plausible from git
  "https://github.com/leanprover-community/plausible.git" @ "v4.26.0"

@[default_target]
lean_lib Chroma where
  roots := #[`Chroma]

lean_lib ChromaTests where
  roots := #[`ChromaTests]
  globs := #[.submodules `ChromaTests]

-- Link arguments for Metal/macOS (inherited pattern from afferent)
def commonLinkArgs : Array String := #[
  "-framework", "Metal",
  "-framework", "Cocoa",
  "-framework", "QuartzCore",
  "-framework", "Foundation",
  "-lobjc",
  "-L/opt/homebrew/lib",
  "-L/usr/local/lib",
  "-lfreetype",
  "-lassimp",
  "-lc++"
]

lean_exe chroma where
  root := `Chroma.Main
  moreLinkArgs := commonLinkArgs

lean_exe chroma_tests where
  root := `ChromaTests.Main
  moreLinkArgs := commonLinkArgs
