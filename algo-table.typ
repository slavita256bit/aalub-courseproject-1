#import "dependencies.typ": *

// Авто-энкодер строки по словарю
#let encode-b4-lines(s, dict) = {
  let arr = s.clusters().map(c => dict.at(c, default: c))
  if arr.len() > 6 {
    let half = int(calc.round(arr.len() / 2))
    return (arr.slice(0, half).join(" "), arr.slice(half).join(" "))
  } else {
    return (arr.join(" "),)
  }
}

// Главная функция отрисовки таблицы
#let draw-algo-table(rows-data, code-dict: code-custom) = {
  let final-rows = ()

  for r in rows-data {
    let (q-int, q-frac, comment, is-ul) = r

    let b-int = q-int.clusters().map(c => code-dict.at(c, default: c)).join("")
    let b-frac-lines = encode-b4-lines(q-frac, code-dict)
    let binary-content = block(align(right)[#b-frac-lines.join(" ")])

    // ВАЖНО: Добавляем нормальную строку ровно из 5 элементов!
    // Благодаря этому rows.at(0).len() всегда будет равен 5.
    final-rows.push((
      align(right)[#q-int],
      align(left)[#q-frac],
      align(right)[#b-int],
      binary-content,
      align(left)[#comment]
    ))

    // Добавляем линию как отдельный массив (кортеж из 1 элемента).
    // При вызове rows.flatten() внутри draw-truth-table она просто
    // встроится между ячейками и отрисуется там, где нужно.
    if is-ul {
      final-rows.push((table.hline(start: 0, end: 5, stroke: 1.5pt),))
    }
  }

  draw-truth-table(
    repeat-header: false,
    caption: [Перемножение мантисс],
    lbl: <tbl-algo>,
    column-widths: (1.5em, auto, 2em, 15em, 2fr),
    bold-vlines: (0, 2, 4, -1),
    bold-hlines: (0, 1, 2, 16,),
    header_rows: 1,
    headers: (
      table.cell(colspan: 2)[*Четверичная с/с*],
      table.cell(colspan: 2)[*Двоично-четверичная с/с*],
      table.cell[*Комментарии*],
    ),
    rows: final-rows
  )
}