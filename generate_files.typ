#import "dependencies.typ": *

#let ochu-mask = (mh, mt, h) => (mt == 3)
#let raw-ochu = generate-base-ochu(mask-fn: ochu-mask)
#let schema-ochu = (code-custom, code-standart, none, code-custom, code-custom, none)
#let encoded-ochu = encode-tt(raw-ochu, schema-ochu)
#let encoded-ochu = sort-tt(encoded-ochu, sort-cols: (0, 1, 2, 3, 4))
#let ochu-file-content = generate-tt-file-content(
  "OCHU",
  encoded-ochu,
  ("x1", "x2", "y1", "y2", "_h"),
  ("P1", "P2", "P3", "P4")
)

#let ochs-mask = (a, b, p) => (b == 2 or b == 3)
#let raw-ochs = generate-base-ochs(mask-fn: ochs-mask)
#let schema-ochs = (code-custom, code-custom, none, none, code-custom, none)
#let encoded-ochs = encode-tt(raw-ochs, schema-ochs)
#let encoded-ochs = sort-tt(encoded-ochs, sort-cols: (0, 1, 2, 3, 4))
#let ochs-file-content = generate-tt-file-content(
  "OCHS",
  encoded-ochs,
  ("a1", "a2", "b1", "b2", "_p"),
  ("P", "S1", "S2")
)

#ochu-file-content <ochu-data>

#ochs-file-content <ochs-data>

#let ochs-rots-content = generate-rots-file-content(
  "OCHU",
  encoded-ochu,
  ("x1", "x2", "y1", "y2", "h"),
  8
)

#ochs-rots-content <rots-data>

/*
typst query generate_files.typ '<ochu-data>' | jq -r '.[0].text' > ./generated_files/OCHU.TXT
typst query generate_files.typ '<ochs-data>' | jq -r '.[0].text' > ./generated_files/OCHS.TXT
typst query generate_files.typ '<rots-data>' | jq -r '.[0].text' > ./generated_files/rots.txt
*/