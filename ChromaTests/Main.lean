/-
  Chroma Test Suite
  Main entry point for running all tests.
-/
import Crucible
import Plausible
import Chroma

namespace ChromaTests

open Crucible
open Tincture

testSuite "Chroma Core"

test "Tincture color parsing works" := do
  match Color.fromHex "#ff0000" with
  | some c =>
    c.r ≡ 1.0
    c.g ≡ 0.0
    c.b ≡ 0.0
  | none => ensure false "parsing failed"

test "placeholder" :=
  ensure true "sanity check"

#generate_tests

end ChromaTests

def main : IO UInt32 := do
  IO.println "Chroma Tests"
  IO.println "============"
  IO.println ""

  let result ← Crucible.runTests "Chroma Core" ChromaTests.cases

  IO.println ""
  if result == 0 then
    IO.println "All tests passed!"
  else
    IO.println "Some tests failed!"

  return result
