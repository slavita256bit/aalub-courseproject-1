#import "dependencies.typ": *

#let ochs-table(body) = [

    = Таблица истинности ОЧC

    #encoding-as-text(code-custom)

    // ОПРЕДЕЛЯЕМ ПРАВИЛО МАСКИ
    // Для ОЧС 1-го типа: b не может быть 2 или 3.
    #let ochs-mask = (a, b, p) => (b == 2 or b == 3)
//     #let ochs-mask = (a, b, p) => false // to test

    #let raw-ochs = generate-base-ochs(mask-fn: ochs-mask)

    #let schema-ochs = (code-custom, code-custom, none, none, code-custom, none)
    #let encoded-ochs = encode-tt(raw-ochs, schema-ochs)

    #let encoded-ochs = sort-tt(encoded-ochs, sort-cols: (0, 1, 2, 3, 4))

    #draw-truth-table(
        // Настраиваем жирные линии как на скрине
        bold-vlines: (0, 2, 4, 5, 8, -1),
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

    // П ==============================
    #let kmap-grid-p = tt-to-karnaugh(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        5,
        gray-cols: gray-code(3),
        gray-rows: gray-code(2),
        default-val: "Z", // to detect errors
    )

    #align(center)[
        #karnaugh-map(
            x-labels: gray-code(3),
            y-labels: gray-code(2),
            hide: "0",
            vars-label: ($a_1 a_2$, $b_1 b_2 p$),

            grid-data: kmap-grid-p,

            groups: (
                (r: 1, c: 0, w: 4, h: 1, pad: 4pt, color: black),
                (r: 1, c: 5, w: 2, h: 1, pad: 4pt, color: black),
                (r: 3, c: 1, w: 2, h: 1, pad: 4pt, color: black),
            )
        )
    ]

    // S1 ==============================
    #let kmap-grid-s1 = tt-to-karnaugh(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        6,
        gray-cols: gray-code(3),
        gray-rows: gray-code(2),
        default-val: "Z", // to detect errors
    )

    #align(center)[
        #karnaugh-map(
            x-labels: gray-code(3),
            y-labels: gray-code(2),
            hide: "0",
            vars-label: ($a_1 a_2$, $b_1 b_2 p$),

            grid-data: kmap-grid-s1,

            groups: (
                (r: 0, c: 5, w: 2, h: 2, pad: 4pt, color: black),
                (r: 0, c: 7, w: 2, h: 2, pad: 4pt, color: black),
                (r: 2, c: 1, w: 2, h: 2, pad: 4pt, color: black),
                (r: 2, c: 3, w: 2, h: 2, pad: 4pt, color: black),
            )
        )
    ]

    // S2 ==============================
    #let kmap-grid-s2 = tt-to-karnaugh(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        7,
        gray-cols: gray-code(3),
        gray-rows: gray-code(2),
        default-val: "Z", // to detect errors
    )

    #align(center)[
        #karnaugh-map(
            x-labels: gray-code(3),
            y-labels: gray-code(2),
            hide: "0",
            vars-label: ($a_1 a_2$, $b_1 b_2 p$),

            grid-data: kmap-grid-s2,

            groups: (
            )
        )
    ]
]

#show: ochs-table