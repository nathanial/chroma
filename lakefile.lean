import Lake
open Lake DSL

package chroma where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

-- Local workspace dependencies
require tincture from ".." / "tincture"
require trellis from ".." / "trellis"
require arbor from ".." / "arbor"
require afferent from ".." / "afferent"

-- Test dependencies
require crucible from ".." / "crucible"

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
