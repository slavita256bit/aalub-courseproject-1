#import "dependencies.typ": *
#import "@preview/cetz:0.5.0"

// 1. Описываем шину входов ОЧС
#let ochs-bus = (
  (id: "a1", label: $a_1$),
  (id: "a2", label: $a_2$),
  (id: "b1", label: $b_1$),
  (id: "b2", label: $b_2$),
  (id: "p",  label: $p$)
)

#let func-P = (
  name: "P", label: $П$,
  terms: (
    ("a1", "!a2", "b1"),
    ("a1", "!a2", "!p"),
    ("!a1", "a2", "b1", "!p")
  ),
  inv-out: true,
  z-fracts: (60%, 75%, 60%)
)

#let func-S1 = (
  name: "S1", label: $S_1$,
  terms: (
    ("a1", "!b1", "!p"),
    ("a1", "b2", "p"),
    ("!a1", "b1", "!p"),
    ("!a1", "!b2", "p")
  ),
  inv-out: true,
  z-fracts: (75%, 60%, 60%, 75%)
)

#let func-S2 = (
  name: "S2", label: $S_2$,
  terms: (
    ("a2", "b1", "!p"),
    ("a1", "!a2", "p"),
    ("!a1", "a2", "b1"),
    ("a1", "!a2", "!b1"),
    ("!a2", "!b2", "p"),
    ("!a1", "a2", "!p")
  ),
  inv-out: true,
  z-fracts: (75%, 60%, 40%, 40%, 40%, 60%)
)

// Единый layout для обеих колонок
#let my-layout = (
  LAYER_1_X: 2.0,
  LAYER_2_X: 6.5,
  LAYER_OUT_X: 9,
  FUNC_Y_SPACING: 1.2
)

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // ==========================================
    // ЛЕВАЯ КОЛОНКА (Входы, П и S1)
    // ==========================================
    group(name: "col-left", {
      draw-combinational-circuits(
        ochs-bus,
        (func-P, func-S1),
        logic-basis: "A7", bus-basis: "A7", layout: my-layout,
        draw-inputs: true,
        bus-end-y-override: -20
      )
    })

    // ==========================================
    // ПРАВАЯ КОЛОНКА (Только S2)
    // ==========================================
    group(name: "col-right", {
      translate(x: 13) // Сдвигаем на 11 см вправо
      draw-combinational-circuits(
        ochs-bus,
        (func-S2,),
        logic-basis: "A7", bus-basis: "A7", layout: my-layout,
        draw-inputs: false // <-- СКРЫВАЕМ ВХОДЫ
      )
    })

    // ==========================================
    // СОЕДИНЕНИЕ ШИН
    // ==========================================
    // Левая шина на x=0, правая на x=11.
    // Координата начала шины (bus-start-y) по умолчанию равна 1.0
    line((0, 1.0), (13, 1.0), stroke: 2pt)
  })
]