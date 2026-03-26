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

    #let map-vars-positions = (
        (r: (2, 3)),             // a1 (нижние 2 строки)
        (r: (1, 2)),             // a2 (средние 2 строки)
        (c: (4, 5, 6, 7)),       // b1 (правая половина)
        (c: (2, 3, 4, 5)),       // b2 (средние 4 столбца)
        (c: (1, 2, 5, 6))        // p  (чередующиеся столбцы)
    )

    // П ==============================
    #let map-p = tt-to-karnaugh(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        5,
        gray-cols: gray-code(3),
        gray-rows: gray-code(2),
        default-val: "Z", // to detect errors
    )

    #align(center)[
        #let groups = (
            (r: 1, c: 0, w: 4, h: 1, pad: 4pt, color: black),
            (r: 1, c: 5, w: 2, h: 1, pad: 4pt, color: black),
            (r: 3, c: 1, w: 2, h: 1, pad: 4pt, color: black),
        )

        #karnaugh-map(
            x-labels: gray-code(3),
            y-labels: gray-code(2),
            hide: "0",
            vars-label: ($a_1 a_2$, $b_1 b_2 p$),
            grid-data: map-p,
            groups: groups
        )

        $ П = #get-mdnf(
            groups,
            map-vars-positions,
            ($a_1$, $a_2$, $b_1$, $b_2$, $p$),
            rows: 4, cols: 8
        ) $
    ]

    // S1 ==============================
    #let map-s1 = tt-to-karnaugh(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        6,
        gray-cols: gray-code(3),
        gray-rows: gray-code(2),
        default-val: "Z", // to detect errors
    )

    #align(center)[
        #let groups = (
            (r: 0, c: 5, w: 2, h: 2, pad: 4pt, color: black),
            (r: 0, c: 7, w: 2, h: 2, pad: 4pt, color: black),
            (r: 2, c: 1, w: 2, h: 2, pad: 4pt, color: black),
            (r: 2, c: 3, w: 2, h: 2, pad: 4pt, color: black),
        )

        #karnaugh-map(
            x-labels: gray-code(3),
            y-labels: gray-code(2),
            hide: "0",
            vars-label: ($a_1 a_2$, $b_1 b_2 p$),

            grid-data: map-s1,

            groups: groups
        )

        $ S_1 = #get-mdnf(
            groups,
            map-vars-positions,
            ($a_1$, $a_2$, $b_1$, $b_2$, $p$),
            rows: 4, cols: 8
        ) $
    ]

    // S2 ==============================
    #let map-s2 = tt-to-karnaugh(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        7,
        gray-cols: gray-code(3),
        gray-rows: gray-code(2),
        default-val: "Z", // to detect errors
    )

    #align(center)[
        #let groups = (
            (r: 3, c: 1, w: 2, h: 2, pad: 4pt, color: black),
            (r: 1, c: 7, w: 2, h: 1, pad: 4pt, color: black),
            (r: 3, c: 0, w: 4, h: 1, pad: 8pt, color: black, dash: "dashed"),
            (r: 1, c: 4, w: 4, h: 1, pad: 8pt, color: black, dash: "dashed"),
            (r: 1, c: 3, w: 2, h: 2, pad: 4pt, color: black),
            (r: 3, c: 5, w: 2, h: 1, pad: 4pt, color: black),
        )

        #karnaugh-map(
            x-labels: gray-code(3),
            y-labels: gray-code(2),
            hide: "0",
            vars-label: ($a_1 a_2$, $b_1 b_2 p$),

            grid-data: map-s2,

            groups: groups
        )

        $ S_2 = #get-mdnf(
            groups,
            map-vars-positions,
            ($a_1$, $a_2$, $b_1$, $b_2$, $p$),
            rows: 4, cols: 8
        ) $
    ]

    #body
]

#show: ochs-table