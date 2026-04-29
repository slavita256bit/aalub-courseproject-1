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

    #let ochs-vars-lines = (
        (side: "left",   start: 2, span: 2, label: $a_1$),
        (side: "right",  start: 1, span: 2, label: $a_2$),
        (side: "top",    start: 4, span: 4, label: $b_1$),
        (side: "bottom", start: 2, span: 4, label: $b_2$),
        // p разорван на 2 части:
        (side: "bottom", start: 1, span: 2, label: $p$, offset: 2.8em),
        (side: "bottom", start: 5, span: 2, label: $p$, offset: 2.8em),
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
            (r: 1, c: 5, w: 2, h: 1, pad: 8pt, color: black, id: 1),
            (r: 3, c: 1, w: 2, h: 1, pad: 4pt, color: black),
            (r: 1, c: 1, w: 2, h: 1, pad: 8pt, color: black, id: 1),
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
    // Используем tt-to-veitch вместо tt-to-karnaugh!
    #let map-s2 = tt-to-veitch(
        encoded-ochs,
        (0, 1, 2, 3, 4),
        7,
        rows: 4, cols: 8,
        vars-map: map-vars-positions,
        default-val: "Z",
    )

    #align(center)[
        #let groups = (
            // ⚠️ ВНИМАНИЕ: Координаты (r, c) я оставил старыми.
            // Тебе 100% придется их поменять, так как на карте Вейча
            // единицы будут стоять в других ячейках, нежели на Карно!
            (r: 3, c: 1, w: 2, h: 2, pad: 4pt, color: black),
            (r: 1, c: 7, w: 2, h: 1, pad: 4pt, color: black, id: 2, dash: "dotted"),
            (r: 1, c: 3, w: 2, h: 1, pad: 6pt, color: black, id: 2, dash: "dotted"),
            (r: 3, c: 0, w: 4, h: 1, pad: 2pt, color: black, dash: "dashed"),
            (r: 1, c: 4, w: 4, h: 1, pad: 2pt, color: black),
            (r: 1, c: 3, w: 2, h: 2, pad: 4pt, color: black),
            (r: 3, c: 5, w: 2, h: 1, pad: 6pt, color: black, id: 1, dash: "dotted"),
            (r: 3, c: 1, w: 2, h: 1, pad: 6pt, color: black, id: 1, dash: "dotted"),
        )

        // Отрисовка Вейча
        #veitch-map(
            cell-size: 2.2em,
            hide: "0",
            grid-data: map-s2,
            vars: ochs-vars-lines,
            groups: groups
        )

        #v(2em)

        // Математика остается прежней, она универсальна!
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