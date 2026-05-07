#import "dependencies.typ": *
#import "efficiency.typ": calc-eff

#let draw-map-and-expr(var-name, grid-data, groups, map-vars, tt-data, out-col, V, is-veitch: false, veitch-vars: none, is-dnf: true) = {
    let hide-val = if is-dnf { "0" } else { "1" }

    let map = figure(
        kind: image,
        caption: [Карта #if is-veitch {"Вейче"} else {"Карно"} для функции #var-name],
        align(center)[
        #if is-veitch [
            #veitch-map(
                cell-size: 2.2em,
                hide: hide-val,
                grid-data: grid-data,
                vars: veitch-vars,
                groups: groups
            )
            #v(1em)
        ] else [
            #v(1em)
            #karnaugh-map(
                x-labels: gray-code(3),
                y-labels: gray-code(2),
                hide: hide-val,
                vars-label: ($x_1 x_2$, $y_1 y_2 h$),
                cell-size: 2.2em,
                grid-data: grid-data,
                groups: groups
            )
        ]
        #v(1em)
    ])

    let fun = unbreakable[
        #v(0.5em)
        Минимизировав функцию, получим:
        #if is-dnf [
            $ #var-name = #get-mdnf(groups, map-vars, ($x_1$, $x_2$, $y_1$, $y_2$, $h$), rows: 4, cols: 8) $
        ] else [
            $ #var-name = #get-mcnf(groups, map-vars, ($x_1$, $x_2$, $y_1$, $y_2$, $h$), rows: 4, cols: 8) $
        ]
    ]

    let basis = unbreakable[
    Запишем в базисе И, НЕ:
        $ #var-name = #generate-or-not-expression(
            groups, map-vars, ($x_1$, $x_2$, $y_1$, $y_2$, $h$), rows: 4, cols: 8, is-dnf: is-dnf
        ) $
    ]

    let eff = calc-eff(groups, tt-data, out-col, V, is-dnf: is-dnf)

    return (map: map, fun: fun, basis: basis, eff: eff)
}

#let build-ochu() = {
    let ochu-mask = (mh, mt, h) => (mt == 3)
    let raw-ochu = generate-base-ochu(mask-fn: ochu-mask)

    let schema-ochu = (code-custom, code-standart, none, code-custom, code-custom, none)
    let encoded-ochu = encode-tt(raw-ochu, schema-ochu)
    let encoded-ochu = sort-tt(encoded-ochu, sort-cols: (0, 1, 2, 3, 4))

    let result-table = align(center)[
        #h(1em)
        #draw-truth-table(
            repeat-header: true,
            caption: [Таблица истинности ОЧУ],
            lbl: <tbl-ochu>,
            bold-vlines: (0, 2, 4, 5, 7, 9, -1),
            bold-hlines: (0, 2, -1),
            column-widths: (1.5em, 1.5em, 1.5em, 1.5em, 2.5em, 3em, 3em, 3em, 3em, 1fr),
            header_rows: 2,
            headers: (
                table.cell(colspan: 2)[*Мн*],
                table.cell(colspan: 2)[*Мт*],
                table.cell[*Упр.*],
                table.cell(colspan: 2)[*Старшие\ разряды*],
                table.cell(colspan: 2)[*Младшие\ разряды*],
                table.cell(rowspan: 2)[*Пример операции в\ четверичной с/с*],
                strong($x_1$), strong($x_2$),
                strong($y_1$), strong($y_2$),
                strong($h$),
                strong($P_1$), strong($P_2$),
                strong($P_3$), strong($P_4$),
            ),
            rows: encoded-ochu
        )
    ]

    let ochu-vars-map = (
        (r: (2, 3)), (r: (1, 2)), (c: (4, 5, 6, 7)), (c: (2, 3, 4, 5)), (c: (1, 2, 5, 6))
    )

    let ochu-vars-lines = (
        (side: "left", start: 2, span: 2, label: $x_1$),
        (side: "right", start: 1, span: 2, label: $x_2$),
        (side: "top", start: 4, span: 4, label: $y_1$),
        (side: "bottom", start: 2, span: 4, label: $y_2$),
        (side: "bottom", start: 1, span: 2, label: $h$, offset: 2.8em),
        (side: "bottom", start: 5, span: 2, label: $h$, offset: 2.8em),
    )

    let map-p1-data = tt-to-karnaugh(encoded-ochu, (0, 1, 2, 3, 4), 5, gray-cols: gray-code(3), gray-rows: gray-code(2), default-val: "Z")
    let groups-p1 = (
        (r: 1, c: 7, w: 1, h: 1, pad: 2pt, color: black, dash: "dashed", id: 1),
        (r: 1, c: 4, w: 1, h: 1, pad: 2pt, color: black, dash: "dashed", id: 1),
        (r: 3, c: 7, w: 1, h: 1, pad: 2pt, color: black, id: 2),
        (r: 3, c: 4, w: 1, h: 1, pad: 2pt, color: black, id: 2),
    )
    let content-p1 = draw-map-and-expr($P_1$, map-p1-data, groups-p1, ochu-vars-map, encoded-ochu, 5, 5, is-dnf: false)

    let map-p2-data = tt-to-veitch(encoded-ochu, (0, 1, 2, 3, 4), 6, rows: 4, cols: 8, vars-map: ochu-vars-map, default-val: "Z")
    let groups-p2 = (
        (r: 1, c: 7, w: 1, h: 1, pad: 2pt, color: black, dash: "dashed", id: 1),
        (r: 1, c: 4, w: 1, h: 1, pad: 2pt, color: black, dash: "dashed", id: 1),
        (r: 3, c: 7, w: 1, h: 1, pad: 2pt, color: black, id: 2),
        (r: 3, c: 4, w: 1, h: 1, pad: 2pt, color: black, id: 2),
    )
    let content-p2 = draw-map-and-expr($P_2$, map-p2-data, groups-p2, ochu-vars-map, encoded-ochu, 6, 5, is-veitch: true, veitch-vars: ochu-vars-lines, is-dnf: false)

    let map-p3-data = tt-to-veitch(encoded-ochu, (0, 1, 2, 3, 4), 7, rows: 4, cols: 8, vars-map: ochu-vars-map, default-val: "Z")
    let groups-p3 = (
        (r: 0, c: 7, w: 2, h: 4, pad: 6pt, color: black),
        (r: 2, c: 0, w: 8, h: 2, pad: 3pt, color: black),
    )
    let content-p3 = draw-map-and-expr($P_3$, map-p3-data, groups-p3, ochu-vars-map, encoded-ochu, 7, 5, is-veitch: true, veitch-vars: ochu-vars-lines, is-dnf: true)

    let map-p4-data = tt-to-veitch(encoded-ochu, (0, 1, 2, 3, 4), 8, rows: 4, cols: 8, vars-map: ochu-vars-map, default-val: "Z")
    let groups-p4 = (
        (r: 2, c: 7, w: 2, h: 2, pad: 4pt, color: black),
        (r: 1, c: 0, w: 4, h: 2, pad: 4pt, color: black),
        (r: 0, c: 0, w: 1, h: 4, pad: 8pt, color: black, dash: "dashed"),
        (r: 1, c: 1, w: 2, h: 2, pad: 6pt, color: black, id: 1),
        (r: 1, c: 5, w: 2, h: 2, pad: 6pt, color: black, id: 1),
    )
    let content-p4 = draw-map-and-expr($P_4$, map-p4-data, groups-p4, ochu-vars-map, encoded-ochu, 8, 5, is-veitch: true, veitch-vars: ochu-vars-lines, is-dnf: true)

    return (
        data: encoded-ochu, table: result-table,
        p1-map: content-p1, p2-map: content-p2, p3-map: content-p3, p4-map: content-p4,
    )
}