#import "dependencies.typ": *

#let pm-table(body) = [
    = Таблица истинности ПМ

    // Генератор сырых данных для ПМ
    #let raw-pm = {
        let res = ()
        for input in (0, 1, 2, 3) {
            for p_in in (0, 1) {
                let transformed = if input >= 2 { input - 4 } else { input }
                let p_out = if input >= 2 { 1 } else { 0 }

                let out = transformed + p_in
                let sign = if out < 0 { 1 } else { 0 }
                let out = calc.abs(out)

                res.push((
                    str(input), str(p_in), str(p_out), str(sign), str(out),
                    str(input) + " + " + str(p_out)
                        + " -> " + if sign == 1 {"-"} else {""} + str(out) + " | " + str(p_out)
                ))
            }
        }
        res
    }

    #let schema-pm = (code-standart, none, none, none, code-standart, none)
    #let encoded-pm = encode-tt(raw-pm, schema-pm)

    #draw-truth-table(
        bold-vlines: (0, 3, 7, -1),
        bold-hlines: (0, 2, -1),
        header_rows: 2,
        headers: (
            table.cell(colspan: 2)[*Мт*],
            table.cell[*Перенос\ пред.*],
            table.cell[*Перенос\ след.*],
            table.cell[*Знак*],
            table.cell(colspan: 2)[*$"[Мт]"_п$*],
            table.cell(rowspan: 2)[*Комментарий*],
            strong($v_1$), strong($v_2$),
            table.cell[*$П_(i-1)$*],
            table.cell[*$П_i$*],
            table.cell[*$S$*],
            strong($P_1$), strong($P_2$),
        ),
        rows: encoded-pm
    )

    // ОПРЕДЕЛЯЕМ ПРАВИЛА (для конвертера mdnf/mcnf)
    // Карта 2x4. Переменные: v1 v2 (cols), c_in (rows)
    #let pm-vars-map = (
        (c: (2, 3)),       // v1 (колонки 11 и 10)
        (c: (1, 2)),       // v2 (колонки 01 и 11)
        (r: (1,)),         // c_in (нижняя строка)
    )

    #let vars-labels = ($v_1$, $v_2 П_(i-1)$)
    #let vars-list = ($v_1$, $v_2$, $П_(i-1)$)

    // C_out ==========================================
    #draw-map-block(
        encoded-pm, (0, 1, 2), 3,
        gray-code(2), gray-code(1), vars-labels,
        pm-vars-map, vars-list,
        (
            (r: 1, c: 0, w: 4, h: 1, pad: 4pt, color: black),
        ),
        $П_i$
    )

    // Знак ==================================
    #draw-map-block(
        encoded-pm, (0, 1, 2), 4,
        gray-code(2), gray-code(1), vars-labels,
        pm-vars-map, vars-list,
        (
            (r: 1, c: 3, w: 2, h: 1, pad: 6pt, color: black, dash: "dashed"),
            (r: 1, c: 0, w: 2, h: 1, pad: 4pt, color: black),
        ),
        $S$
    )

    // Где переменные равны 1 (для генератора формул)
    #let pm-veitch-vars-map = (
        (c: (2, 3)),       // v1 (правая половина)
        (c: (1, 2)),       // v2 (центральная половина)
        (r: (1,)),         // П_{i-1} (нижняя строка)
    )

    // Как рисовать линии (для самой карты)
    #let pm-veitch-vars-lines = (
        (side: "top",    start: 2, span: 2, label: $v_1$),
        (side: "bottom", start: 1, span: 2, label: $v_2$),
        (side: "right",  start: 1, span: 1, label: $П_(i-1)$),
    )

    // P1 =============================================
    #let map-p1 = tt-to-veitch(
        encoded-pm, (0, 1, 2), 5,
        rows: 2, cols: 4,
        vars-map: pm-veitch-vars-map,
        default-val: "Z",
    )

    #align(center)[
        #let groups = (
            (r: 1, c: 1, w: 1, h: 1, pad: 4pt, color: black),
            (r: 0, c: 3, w: 1, h: 1, pad: 4pt, color: black),
        )

        #veitch-map(
            cell-size: 2.2em,
            hide: "0",
            grid-data: map-p1,
            vars: pm-veitch-vars-lines,
            groups: groups
        )

        $ P_1 = #get-mdnf(
            groups,
            pm-veitch-vars-map,
            ($v_1$, $v_2$, $П_(i-1)$),
            rows: 2, cols: 4
        ) $
    ]

    // P2 =============================================
    #let map-p2 = tt-to-veitch(
        encoded-pm, (0, 1, 2), 6,
        rows: 2, cols: 4,
        vars-map: pm-veitch-vars-map,
        default-val: "Z",
    )

    #align(center)[
        #let groups = (
            (r: 0, c: 1, w: 2, h: 1, pad: 4pt, color: black),
            (r: 1, c: 3, w: 2, h: 1, pad: 4pt, color: black),
        )

        #veitch-map(
            cell-size: 2.2em,
            hide: "0",
            grid-data: map-p2,
            vars: pm-veitch-vars-lines,
            groups: groups
        )

        $ P_2 = #get-mdnf(
            groups,
            pm-veitch-vars-map,
            ($v_1$, $v_2$, $П_(i-1)$),
            rows: 2, cols: 4
        ) $
    ]

    #body
]

#show: pm-table