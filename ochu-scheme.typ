#import "dependencies.typ": *
#import "@preview/cetz:0.5.0"

// --- Все определения функций оставляем как есть, для анализа шины ---
#let ochu-bus = (
  (id: "x1", label: $x_1$), (id: "x2", label: $x_2$),
  (id: "y1", label: $y_1$), (id: "y2", label: $y_2$),
  (id: "h",  label: $h$)
)
#let func-P1 = (name: "P1", label: $P_1=P_2$, terms: (("x1", "!x2", "!y1", "h"), ("!x1", "x2", "!y1", "h")), inv-out: true, z-fracts: (50%, 50%))
// #let func-P2 = (name: "P2", label: $P_2$, terms: (("x1", "!x2", "!y1", "h"), ("!x1", "x2", "!y1", "h")), inv-out: true)
#let func-P3 = (name: "P3", label: $P_3$, terms: (("y2", "h"), ("x1",)), inv-out: false, z-fracts: (50%, 50%))
#let func-P4 = (name: "P4", label: $P_4$, terms: (("x1", "!y2", "!h"), ("x2", "!y1"), ("!y1", "!y2", "!h"), ("x2", "h")), inv-out: false, z-fracts: (50%, 30%, 30%, 50%))

#let my-layout = (
  LAYER_1_X: 2.0, LAYER_MID_X: 4.5, LAYER_2_X: 7.0, LAYER_OUT_X: 8.5,
  FUNC_Y_SPACING: 0.8
)

// ==========================================
// ОСНОВНАЯ ОТРИСОВКА С УЛУЧШЕНИЯМИ
// ==========================================
#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- ЛЕВАЯ КОЛОНКА (Входы и P1/P2) ---
    group(name: "col-left", {
      // Рисуем только P1, но передаем все остальные для анализа шины
      draw-combinational-circuits(ochu-bus, (func-P1,),
        logic-basis: "A5", bus-basis: "A1", layout: my-layout, draw-inputs: true,
        extra_funcs: (func-P3, func-P4) // <-- ПЕРЕДАЕМ СКРЫТЫЕ ФУНКЦИИ
      )

      // Магия: находим выход P1 и делаем разветвление для P2
//       let p1-out-y = query(selector("f0_out_inv.out")).first().y
//       let p2-label-x = my-layout.LAYER_OUT_X + 1.5
//       wire((p1-out-y, "f0_out_inv.out"), (p2-label-x, p1-out-y - 2.0), routing: "|-", z-fract: 50%)
//       content((p2-label-x + 0.2, p1-out-y - 2.0), $P_2$, anchor: "west")
//       dot((p1-out-y, "f0_out_inv.out"))
    })

    // --- ПРАВАЯ КОЛОНКА (P3 и P4) ---
    group(name: "col-right", {
      translate(x: 13)
      draw-combinational-circuits(ochu-bus, (func-P3, func-P4),
        logic-basis: "A5", bus-basis: "A1", layout: my-layout, draw-inputs: false)
    })

    // Соединяем шины сверху
    line((0, 1.0), (13, 1.0), stroke: 2pt)
  })
]