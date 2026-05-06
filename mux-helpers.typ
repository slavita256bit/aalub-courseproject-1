#import "dependencies.typ": *
#import "ochs-table.typ": *

// 1. Вспомогательная мини-функция для вычисления D_i в зависимости от p
#let deduce-mux-func(vals) = {
  // vals - массив из 4 значений [val_{b2=0, p=0}, val_{b2=0, p=1}, val_{b2=1, p=0}, val_{b2=1, p=1}]
  // Отфильтровываем безразличные состояния ("x" или кириллическая "х")
  let valid-vals = vals.filter(v => v != "x" and v != "х")

  if valid-vals.len() == 0 { return $0$ } // Если все "х", пусть будет 0
  if valid-vals.len() == 2 {
    let (v0, v1) = valid-vals
    if v0 == "0" and v1 == "0" { return $0$ }
    if v0 == "1" and v1 == "1" { return $1$ }
    if v0 == "0" and v1 == "1" { return $p$ }
    if v0 == "1" and v1 == "0" { return $overline(p)$ }
  }
  return $?$ // На случай непредвиденных данных (чтобы сразу заметить ошибку)
}

// 2. Основной обработчик: фильтрует ОЧС и собирает таблицу MUX
#let generate-mux-data(tt-data) = {
  let rows = ()
  let funcs-p = ()
  let funcs-s1 = ()
  let funcs-s2 = ()

  // Перебираем 8 адресных комбинаций (a1, a2, b1)
  let addr-groups = (
    ("0","0","0"), ("0","0","1"), ("0","1","0"), ("0","1","1"),
    ("1","0","0"), ("1","0","1"), ("1","1","0"), ("1","1","1")
  )

  for addr in addr-groups {
    let (a1, a2, b1) = addr
    let sub-rows = ()

    // Для каждого адреса перебираем оставшиеся b2 и p
    for b2 in ("0", "1") {
      for p in ("0", "1") {
        let match = tt-data.find(r => r.at(0) == a1 and r.at(1) == a2 and r.at(2) == b1 and r.at(3) == b2 and r.at(4) == p)
        if match != none {
          sub-rows.push(match)
        } else {
          sub-rows.push((a1, a2, b1, b2, p, "x", "x", "x"))
        }
      }
    }

    // Авто-определение функций
    let fp = deduce-mux-func(sub-rows.map(r => r.at(5)))
    let fs1 = deduce-mux-func(sub-rows.map(r => r.at(6)))
    let fs2 = deduce-mux-func(sub-rows.map(r => r.at(7)))

    funcs-p.push(fp)
    funcs-s1.push(fs1)
    funcs-s2.push(fs2)

    // Форматирование 4-х строк для отрисовки (используем rowspan для красоты)
    for (i, sr) in sub-rows.enumerate() {
      let r = ()
      if i == 0 {
        r.push(table.cell(rowspan: 4)[#a1])
        r.push(table.cell(rowspan: 4)[#a2])
        r.push(table.cell(rowspan: 4)[#b1])
      }
      r.push(sr.at(3)) // b2
      r.push(sr.at(4)) // p

      // П
      r.push(if sr.at(5) == "х" {"x"} else {sr.at(5)})
      if i == 0 { r.push(table.cell(rowspan: 4)[#fp]) }
      // S1
      r.push(if sr.at(6) == "х" {"x"} else {sr.at(6)})
      if i == 0 { r.push(table.cell(rowspan: 4)[#fs1]) }
      // S2
      r.push(if sr.at(7) == "х" {"x"} else {sr.at(7)})
      if i == 0 { r.push(table.cell(rowspan: 4)[#fs2]) }

      rows.push(r)
    }
  }
  return (rows: rows, p: funcs-p, s1: funcs-s1, s2: funcs-s2)
}

// 3. Форматирование списка сигналов D0...D7
#let format-mux-eqs(funcs) = {
  let parts = ()
  for (i, f) in funcs.enumerate() {
    parts.push($D_#i = #f$)
  }
  return parts.join($quad$)
}

// Извлекаем актуальные данные из твоей базы
#let ochs-actual-data = build-ochs().data
#let mux-data = generate-mux-data(ochs-actual-data)