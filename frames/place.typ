#let place-horizontal(param, body, table-height) = {
  // Указываем поворот страницы
  set page(
    flipped: true,
    footer: place(
        right + bottom,
        dx: 5mm,
        dy: -45mm + table-height / 1.5,
        param
      ),
    footer-descent: 0pt,
  )

  body
}

#let place-vertical(param, body, table-height) = {
  // Указываем поворот страницы
  set page(
    flipped: false,
    footer: [
      #place(
        right + bottom,
        dx: -10mm,
        dy: -45mm + table-height / 1.5,
        param
      )
    ],
    footer-descent: 0pt,
  )
  
  body
}