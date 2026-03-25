#import "@local/typst-bsuir-core:0.9.17": *
#import "codes.typ": *

#let ochs-table(body) = [

  = Таблица истинности ОЧC

  #let raw-ochs = generate-base-ochs(mask-b-vals: (2, 3))

  #let schema-ochs = (code-custom, code-custom, none, none, code-custom, none)

  #let encoded-ochs = encode-tt(raw-ochs, schema-ochs)

  #draw-truth-table(
    // Настраиваем жирные линии как на скрине
    bold-vlines: (0, 2, 4, 5, 8, - 1),
    bold-hlines: (0, 1, -1),

    headers: (
      // Первая строка шапки (буквы)
      strong($a_1$), strong($a_2$),
      strong($b_1$), strong($b_2$),
      strong($p$),
      strong($Pi$),
      strong($S_1$), strong($S_2$),
      strong[Пример операции \ в четверичной с/с],
    ),
    rows: encoded-ochs
  )

  // #let kmap-grid-p3 = tt-to-map-grid(
  //     gray-cols: gray-code(3),
  //     gray-rows: gray-code(2),
  //     encoded-rows: encoded-ochs,
  //     in-cols: (0, 1, 2, 3, 4),
  //     out-col: 5,
  // )

//   #text(repr(encoded-ochs))
]

#show: ochs-table