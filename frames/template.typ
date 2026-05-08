#import "place.typ": place-horizontal, place-vertical
#import "tables-eskd.typ" as eskd-tables
#import "frame.typ": document-frame

#let frame(body) = {
  set page(
    margin: (
      left: 30mm,
      right: 10mm,
      top : 20mm,
      bottom: 20mm,
    ),
    background: document-frame
  )

  body
}

#let eskd-frame(table-type: eskd-tables.table-dd, vertical: true, show-frame: true, body) = context {
  let table-height = measure(table-type).height
  set page(
      margin: (
        left: 30mm,
        right: 10mm,
        top : 20mm,
        bottom: 20mm + table-height,
      ),
      background: if show-frame {document-frame}
    )
  if vertical {
    place-vertical(table-type, body, table-height)
  } else {
    place-horizontal(table-type, body, table-height)
  }
}

// ==========================================
// ОБОЛОЧКА ДЛЯ ВСТАВКИ ЧЕРТЕЖА СО ШТАМПАМИ
// ==========================================
#let eskd-scheme(
  title: "",
  doc-code: "",
  dev-name: "",
  prov-name: "",
  group-name: "",
  paper-format: "a3",
  vertical: false,
  body
) = context {
  // Определяем базовые размеры листа
  let pw = if paper-format == "a3" { 297mm } else { 210mm }
  let ph = if paper-format == "a3" { 420mm } else { 297mm }

  // Учитываем ориентацию (альбомная/книжная)
  if not vertical {
    let temp = pw
    pw = ph
    ph = temp
  }

  // Генерируем элементы рамки
  let main-table = eskd-tables.table-schema-form1(
    title: title, doc-code: doc-code,
    dev-name: dev-name, prov-name: prov-name, group-name: group-name
  )
  let top-left = eskd-tables.table-schema-top-left(doc-code: doc-code)

  // Переопределяем параметры страницы для чертежа
  set page(
    width: pw,
    height: ph,
    // Внутренние отступы для контента (чтобы схема не налезала на рамку и штамп)
    margin: (left: 25mm, right: 10mm, top: 25mm, bottom: 65mm),
    header: none,
    footer: none,
    background: [
      #document-frame
      // Левый верхний инвентарный блок (отступы рамки ГОСТ: слева 20, сверху 5)
      #place(top + left, dx: 20mm, dy: 5mm, top-left)
      // Основной штамп (отступы рамки ГОСТ: справа 5, снизу 10 по твоему border-params)
      #place(bottom + right, dx: -5mm, dy: -10mm, main-table)
    ]
  )

  // Выводим сам контент схемы (шрифт по умолчанию делаем GOST)
  set text(font: "GOST Type A", size: 12pt)
  body
}

// ==========================================
// ОБОЛОЧКА ДЛЯ ВЕДОМОСТИ ДОКУМЕНТОВ
// ==========================================
#let eskd-vedomost(
  title: "",
  doc-code: "",
  dev-name: "",
  prov-name: "",
  group-name: "",
  body
) = context {
  let main-table = eskd-tables.table-vedomost-stamp(
    title: title, doc-code: doc-code,
    dev-name: dev-name, prov-name: prov-name, group-name: group-name
  )

  set page(
    width: 210mm,
    height: 297mm,
    margin: (left: 25mm, right: 10mm, top: 25mm, bottom: 55mm), // Отступ под штамп
    header: none,
    footer: none,
    background: [
      #document-frame
      #place(bottom + right, dx: -5mm, dy: -10mm, main-table)
    ]
  )

  set text(font: "Arial", size: 12pt, style: "italic") // Как на картинке
  body
}