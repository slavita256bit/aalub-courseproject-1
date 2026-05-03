#import "dependencies.typ": *

// Универсальный отрисовщик карт и выражений
#let draw-map-and-expr(
    var-name,
    grid-data,
    groups,
    map-vars,
    all-vars, // Список всех переменных для формул
    is-veitch: false,
    veitch-vars: none,
    is-dnf: true,
    rows: 4,
    cols: 8
) = {
    let hide-val = if is-dnf { "0" } else { "1" }

    let map = align(center)[
        #if is-veitch [
            #veitch-map(
                cell-size: 2.2em,
                hide: hide-val,
                grid-data: grid-data,
                vars: veitch-vars,
                groups: groups
            )
        ] else [
            #karnaugh-map(
                x-labels: gray-code(calc.log(cols, base: 2)),
                y-labels: gray-code(calc.log(rows, base: 2)),
                hide: hide-val,
                vars-label: ($v_1$, $v_2 p$), // Для ПМ можно кастомизировать или передавать
                cell-size: 2.2em,
                grid-data: grid-data,
                groups: groups
            )
        ]
        #v(1em)
    ]

    let fun = align(center)[
        #if is-dnf [
            $ #var-name = #get-mdnf(groups, map-vars, all-vars, rows: rows, cols: cols) $
        ] else [
            $ #var-name = #get-mcnf(groups, map-vars, all-vars, rows: rows, cols: cols) $
        ]
    ]

    let basis = align(center)[
        $ #var-name = #generate-or-not-expression(
            groups, map-vars, all-vars,
            rows: rows, cols: cols, is-dnf: is-dnf
        ) $
    ]

    return (map: map, fun: fun, basis: basis)
}

#let build-pm() = {
    // --- ГЕНЕРАЦИЯ ДАННЫХ ---
    let raw-pm = {
        let res = ()
        for input in (0, 1, 2, 3) {
            for p_in in (0, 1) {
                let transformed = if input >= 2 { input - 4 } else { input }
                let p_out = if input >= 2 { 1 } else { 0 }

                let out = transformed + p_in
                let sign = if out < 0 { 1 } else { 0 }
                let out = calc.abs(out)

                res.push((
                    str(input), str(p_in), str(sign), str(out),
                    str(input) + " + " + str(p_out)
                        + " -> " + if sign == 1 {"-"} else {""} + str(out)
                ))
            }
        }
        res
    }

    let schema-pm = (code-standart, none, none, code-standart, none)
    let encoded-pm = encode-tt(raw-pm, schema-pm)

    // --- ТАБЛИЦА ---
    let result-table = align(center)[
        #draw-truth-table(
            bold-vlines: (0, 3, 6, -1),
            bold-hlines: (0, 2, -1),
            header_rows: 2,
            headers: (
                table.cell(colspan: 2)[*Мт*], table.cell[*Перенос*],
                table.cell[*Знак*], table.cell(colspan: 2)[*$"[Мт]"_п$*],
                table.cell(rowspan: 2)[*Коммент.*],
                strong($v_1$), strong($v_2$), table.cell[*$p$*],
                table.cell[*$S$*], strong($P_1$), strong($P_2$),
            ),
            rows: encoded-pm
        )
    ]

    // --- НАСТРОЙКИ КАРТ (2x4) ---
    let pm-vars-list = ($v_1$, $v_2$, $p$)
    let pm-vars-map = (
        (c: (2, 3)), // v1
        (c: (1, 2)), // v2
        (r: (1,)),    // p
    )
    let pm-veitch-lines = (
        (side: "top",    start: 2, span: 2, label: $v_1$),
        (side: "bottom", start: 1, span: 2, label: $v_2$),
        (side: "right",  start: 1, span: 1, label: $p$),
    )

    // --- S MAP (Знак) ---
    let map-s-data = tt-to-karnaugh(encoded-pm, (0, 1, 2), 3, gray-cols: gray-code(2), gray-rows: gray-code(1))
    let content-s = draw-map-and-expr(
        $S$, map-s-data,
        ((r: 1, c: 0, w: 2, h: 1, pad: 2pt, color: black), (r: 1, c: 3, w: 2, h: 1, pad: 5pt, color: black)),
        pm-vars-map, pm-vars-list, rows: 2, cols: 4
    )

    // --- P1 MAP ---
    let map-p1-data = tt-to-veitch(encoded-pm, (0, 1, 2), 4, rows: 2, cols: 4, vars-map: pm-vars-map)
    let content-p1 = draw-map-and-expr(
        $P_1$, map-p1-data,
        ((r: 0, c: 3, w: 1, h: 1, color: black), (r: 1, c: 1, w: 1, h: 1, color: black)),
        pm-vars-map, pm-vars-list, is-veitch: true, veitch-vars: pm-veitch-lines, rows: 2, cols: 4
    )

    // --- P2 MAP ---
    let map-p2-data = tt-to-veitch(encoded-pm, (0, 1, 2), 5, rows: 2, cols: 4, vars-map: pm-vars-map)
    let content-p2 = draw-map-and-expr(
        $P_2$, map-p2-data,
        ((r: 0, c: 1, w: 2, h: 1, color: black), (r: 1, c: 3, w: 2, h: 1, color: black)),
        pm-vars-map, pm-vars-list, is-veitch: true, veitch-vars: pm-veitch-lines, rows: 2, cols: 4
    )

    return (
        table: result-table,
        s-map: content-s,
        p1-map: content-p1,
        p2-map: content-p2,
    )
}

#let pm = build-pm()

== Преобразователь множителя
Ниже представлена таблица истинности для ПМ:

#pm.table

=== Минимизация функций ПМ
Для реализации знакового разряда $S$ используем карту Карно:
#pm.s-map.map
#pm.s-map.fun

Для разрядов $P_1$ и $P_2$ воспользуемся картами Вейча:
#grid(
    columns: (1fr, 1fr),
    [ #pm.p1-map.map #pm.p1-map.fun ],
    [ #pm.p2-map.map #pm.p2-map.fun ]
)

=== Базис И-НЕ
#pm.p1-map.basis
#pm.p2-map.basis