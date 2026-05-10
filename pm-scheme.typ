#import "dependencies.typ": *
#import "@preview/cetz:0.5.0"

// Описываем шину входов ПМ
#let pm-bus = (
  (id: "v1", label: $v_1$),
  (id: "v2", label: $v_2$),
  (id: "p",  label: [#move(dx: -0.3em, $p$)])
)

// Функция Знака (S)
#let func-S = (
  name: "S",
  label: $S$,
  terms: (
    ("!v1", "p"),
    ("!v2", "p")
  ),
  z-fracts: (50%, 50%), // Точки излома линий для красоты
)

// Функция P1
#let func-P1 = (
  name: "P1",
  label: $P_1$,
  terms: (
    ("v1", "!v2", "!p"),
    ("!v1", "v2", "p")
  ),
  z-fracts: (50%, 50%),
)

// Функция P2
#let func-P2 = (
  name: "P2",
  label: $P_2$,
  terms: (
    ("v2", "!p"),
    ("!v2", "p")
  ),
  z-fracts: (50%, 50%),
)

// Отрисовка схемы
#align(center)[
  #cetz.canvas(length: 1cm, {
    draw-combinational-circuits(
      pm-bus,
      (func-S, func-P1, func-P2),
      logic-basis: "A1", // Базис И-ИЛИ-НЕ
      bus-basis: "A1",
      bus-end-y-override: -18,
      layout: (
        LAYER_2_X: 5.0,      // Чуть отодвинем второй слой вправо
        LAYER_OUT_X: 6,    // Сдвинем надписи выходов еще правее
      )
    )
  })
]