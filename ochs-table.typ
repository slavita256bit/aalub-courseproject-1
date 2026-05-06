#import "dependencies.typ": *
#import "efficiency.typ": calc-eff

#let draw-map-and-expr(var-name, grid-data, groups, map-vars, tt-data, out-col, V, is-veitch: false, veitch-vars: none, is-dnf: true) = {
    let map = figure(
        kind: image,
        caption: [Карта #if is-veitch {"Вейче"} else {"Карно"} для функции #var-name],
        align(center)[
            #if is-veitch [
                #veitch-map(
                    cell-size: 2.2em,
                    hide: "0",
                    grid-data: grid-data,
                    vars: veitch-vars,
                    groups: groups
                )
                #v(2em)
            ] else [
                #v(1em)
                #karnaugh-map(
                    x-labels: gray-code(3),
                    y-labels: gray-code(2),
                    hide: "0",
                    vars-label: ($a_1 a_2$, $b_1 b_2 p$),
                    grid-data: grid-data,
                    groups: groups
                )
                #v(0.5em)
            ]
        ]
    )

    let fun = unbreakable[
        #v(0.5em)
        Минимизировав функцию, получим:
        $ #var-name = #get-mdnf(
            groups,
            map-vars,
            ($a_1$, $a_2$, $b_1$, $b_2$, $p$),
            rows: 4, cols: 8
        ) $
    ]

    let basis = unbreakable[
        Запишем в базисе И-НЕ:
        $ #var-name = #generate-or-not-expression(
            groups,
            map-vars,
            ($a_1$, $a_2$, $b_1$, $b_2$, $p$),
            rows: 4, cols: 8,
            is-dnf: true
        ) $
    ]

    let eff = calc-eff(groups, tt-data, out-col, V, is-dnf: is-dnf)

    return (map: map, fun: fun, basis: basis, eff: eff)
}

#let build-ochs() = {
    let raw-ochs = generate-base-ochs(mask-fn: (a, b, p) => (b == 2 or b == 3))
    let schema-ochs = (code-custom, code-custom, none, none, code-custom, none)
    let encoded-ochs = encode-tt(raw-ochs, schema-ochs)
    let encoded-ochs = sort-tt(encoded-ochs, sort-cols: (0, 1, 2, 3, 4))

    let result-table = align(center)[
        #h(1em)
        #draw-truth-table(
            repeat-header: true,
            caption: [Таблица истинности ОЧС],
            lbl: <tbl-ochs>,
            column-widths: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, auto),
            bold-vlines: (0, 2, 4, 5, 8, -1),
            bold-hlines: (0, 1, -1),
            headers: (
                strong($a_1$), strong($a_2$),
                strong($b_1$), strong($b_2$),
                strong($p$),
                strong($Pi$),
                strong($S_1$), strong($S_2$),
                [Пример операции \ в четверичной с/с],
            ),
            rows: encoded-ochs
        )
    ]

    let map-vars-positions = (
        (r: (2, 3)),             // a1
        (r: (1, 2)),             // a2
        (c: (4, 5, 6, 7)),       // b1
        (c: (2, 3, 4, 5)),       // b2
        (c: (1, 2, 5, 6))        // p
    )

    let ochs-vars-lines = (
        (side: "left",   start: 2, span: 2, label: $a_1$),
        (side: "right",  start: 1, span: 2, label: $a_2$),
        (side: "top",    start: 4, span: 4, label: $b_1$),
        (side: "bottom", start: 2, span: 4, label: $b_2$),
        (side: "bottom", start: 1, span: 2, label: $p$, offset: 2.8em),
        (side: "bottom", start: 5, span: 2, label: $p$, offset: 2.8em),
    )

    let map-p = tt-to-karnaugh(encoded-ochs, (0, 1, 2, 3, 4), 5, gray-cols: gray-code(3), gray-rows: gray-code(2), default-val: "Z")
    let groups-p = (
        (r: 1, c: 0, w: 4, h: 1, pad: 4pt, color: black),
        (r: 1, c: 5, w: 2, h: 1, pad: 8pt, color: black, id: 1),
        (r: 3, c: 1, w: 2, h: 1, pad: 4pt, color: black),
        (r: 1, c: 1, w: 2, h: 1, pad: 8pt, color: black, id: 1),
    )
    let content-p = draw-map-and-expr($П$, map-p, groups-p, map-vars-positions, encoded-ochs, 5, 5)

    let map-s1 = tt-to-karnaugh(encoded-ochs, (0, 1, 2, 3, 4), 6, gray-cols: gray-code(3), gray-rows: gray-code(2), default-val: "Z")
    let groups-s1 = (
        (r: 0, c: 5, w: 2, h: 2, pad: 4pt, color: black),
        (r: 0, c: 7, w: 2, h: 2, pad: 4pt, color: black),
        (r: 2, c: 1, w: 2, h: 2, pad: 4pt, color: black),
        (r: 2, c: 3, w: 2, h: 2, pad: 4pt, color: black),
    )
    let content-s1 = draw-map-and-expr($S_1$, map-s1, groups-s1, map-vars-positions, encoded-ochs, 6, 5)

    let map-s2 = tt-to-veitch(encoded-ochs, (0, 1, 2, 3, 4), 7, rows: 4, cols: 8, vars-map: map-vars-positions, default-val: "Z")
    let groups-s2 = (
        (r: 3, c: 1, w: 2, h: 2, pad: 4pt, color: black),
        (r: 1, c: 7, w: 2, h: 1, pad: 4pt, color: black, id: 2, dash: "dotted"),
        (r: 1, c: 3, w: 2, h: 1, pad: 6pt, color: black, id: 2, dash: "dotted"),
        (r: 3, c: 0, w: 4, h: 1, pad: 2pt, color: black, dash: "dashed"),
        (r: 1, c: 4, w: 4, h: 1, pad: 2pt, color: black),
        (r: 1, c: 3, w: 2, h: 2, pad: 4pt, color: black),
        (r: 3, c: 5, w: 2, h: 1, pad: 6pt, color: black, id: 1, dash: "dotted"),
        (r: 3, c: 1, w: 2, h: 1, pad: 6pt, color: black, id: 1, dash: "dotted"),
    )
    let content-s2 = draw-map-and-expr($S_2$, map-s2, groups-s2, map-vars-positions, encoded-ochs, 7, 5, is-veitch: true, veitch-vars: ochs-vars-lines)

    return (
        data: encoded-ochs,
        table: result-table,
        p-map: content-p,
        s1-map: content-s1,
        s2-map: content-s2,
    )
}