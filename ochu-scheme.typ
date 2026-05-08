#import "dependencies.typ": *
#import "@preview/cetz:0.5.0"

#let ochu-bus = (
  (id: "x1", label: $x_1$), (id: "x2", label: $x_2$),
  (id: "y1", label: $y_1$), (id: "y2", label: $y_2$),
  (id: "h",  label: $h$)
)

#let func-P1 = (name: "P1", label: $P_1=P_2$, terms: (("x1", "!x2", "!y1", "h"), ("!x1", "x2", "!y1", "h")), inv-out: true, z-fracts: (50%, 50%))
#let func-P3 = (name: "P3", label: $P_3$, terms: (("y2", "h"), ("x1",)), inv-out: false, z-fracts: (60%, 0%))

// Внесены изменения в 3-й терм для 100% совпадения с Quartus (inst14: !y1, y2, h)
#let func-P4 = (
  name: "P4",
  label: $P_4$,
  terms: (
    ("!x1", "y2", "h"),
    ("!x2", "y1"),
    ("y1", "y2", "h"), // <-- Изменено здесь
    ("!x2", "!h")
  ),
  inv-out: false,
  z-fracts: (50%, 30%, 30%, 50%)
)

#let my-layout = (
  LAYER_1_X: 2.0, LAYER_MID_X: 5, LAYER_2_X: 9.0, LAYER_OUT_X: 13,
  FUNC_Y_SPACING: 0
)

// ==========================================
// ОСНОВНАЯ ОТРИСОВКА С УЛУЧШЕНИЯМИ
// ==========================================
#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- ЛЕВАЯ КОЛОНКА (Входы и P1/P3) ---
    group(name: "col-left", {
      draw-combinational-circuits(ochu-bus, (func-P1, func-P3, func-P4,),
        logic-basis: "A5", bus-basis: "A1", layout: my-layout, draw-inputs: true,
        bus-end-y-override: -19,
      )
    })
  })
]out