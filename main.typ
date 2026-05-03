#import "dependencies.typ": *

// Настройки шрифтов и формул
#set text(font: "Times New Roman", size: 14pt, lang: "ru")
#show math.equation: set text(font: "STIX Two Math", size: 14pt)

// Настройка ГОСТ-шаблона из вашей библиотеки
#show: gost.with(
  title-template: custom-title-template.from-module(aalub-course-project-title),
  approver: (name: "В. С. Ермаков"),
  work: (
    topic: "Проектирование и логический синтез\nсумматора-умножителя двоично-четверичных чисел",
    code: "БГУИР КР 6-05-0611-05 558 ПЗ"
  ),
  student: (name: "В. С. Ермаков", group: "558301"),
  manager: (name: "Ю. А. Луцик"),
  city: "",
  year: "",
  title-city: "МИНСК",
  title-year: "2026",
)

#show figure.where(kind: image): set figure(
  numbering: n => {
    let section = counter(heading).get().first()
    numbering("1.1", section, n)
  }
)
#show heading.where(level: 1): it => {
  counter(figure.where(kind: image)).update(0)
  it
}

#show figure.where(kind: table): set figure(
  numbering: n => {
    let section = counter(heading).get().first()
    numbering("1.1", section, n)
  }
)

#show heading.where(level: 1): it => {
  counter(figure.where(kind: table)).update(0)
  it
}

#show math.equation: it => {
  show ".": ","

  if it.block {
    pad(y: 0.5em, it)
  } else {
    it
  }
}

#set math.equation(numbering: none)
#set par(spacing: 0.8em)

#outline(
  title: [СОДЕРЖАНИЕ],
  indent: auto,
  depth: 3
)
#pagebreak()

#include "00-intro.typ"
#include "01-algorithm.typ"
#include "02-developing-sm.typ"
#include "03-functional.typ"
// #include "04-multiplexers.typ"
// #include "05-evaluation.typ"
// #include "06-conclusion.typ"