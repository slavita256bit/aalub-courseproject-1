#import "dependencies.typ": *

#let calc-eff(groups, tt-data, out-col, V, is-dnf: true, inv: auto) = {
    // 1. Считаем ДО минимизации (N_до)
    let R = 0
    let target = if is-dnf { "1" } else { "0" }
    for row in tt-data {
        if str(row.at(out-col)) == target { R += 1 }
    }

    let before-val = R * V + R + V
    let before-str = str(R) + "*" + str(V) + " + " + str(R) + " + " + str(V)

    // 2. Считаем ПОСЛЕ минимизации (N_после)
    // Группируем склеенные через края ячейки по их id
    let logical-groups = (:)
    for (i, g) in groups.enumerate() {
        let key = str(g.at("id", default: -i))
        if key not in logical-groups { logical-groups.insert(key, 0) }
        logical-groups.insert(key, logical-groups.at(key) + g.w * g.h)
    }

    // Вычисляем длину каждого терма (V - log2(площадь группы))
    let term-lengths = ()
    for (_, area) in logical-groups {
        let log2-area = 0
        let temp = area
        while temp > 1 { temp = calc.quo(temp, 2); log2-area += 1 }
        let L = V - log2-area
        if L > 0 { term-lengths.push(L) }
    }

    // Подсчитываем входы для вентилей термов
    let terms-inputs-str = ()
    let terms-inputs-val = 0
    let length-counts = (:)

    for l in term-lengths {
        if l > 1 {
           let key = str(l)
           length-counts.insert(key, length-counts.at(key, default: 0) + 1)
           terms-inputs-val += l
        }
    }

    for k in length-counts.keys().sorted().rev() {
         terms-inputs-str.push(str(length-counts.at(k)) + "*" + k)
    }

    let outer-gate-val = if term-lengths.len() > 1 { term-lengths.len() } else { 0 }
    let inverters-val = if inv == auto { V } else { inv }

    let after-val = terms-inputs-val + outer-gate-val + inverters-val

    let after-parts = ()
    if terms-inputs-str.len() > 0 { after-parts.push(terms-inputs-str.join(" + ")) }
    if outer-gate-val > 0 { after-parts.push(str(outer-gate-val)) }
    if inverters-val > 0 { after-parts.push(str(inverters-val)) }

    let after-str = after-parts.join(" + ")
    if after-str == "" { after-str = "0" }

    let k-val = calc.round(before-val / calc.max(1, after-val), digits: 2)

    return unbreakable[
        #show "*": $dot$
        Эффективность минимизации:
        $ K = (#before-str) / (#after-str) = #before-val / #after-val = #k-val $
    ]
}