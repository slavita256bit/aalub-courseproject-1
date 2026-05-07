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
    code: "БГУИР КР 6-05-0611-05 114 ПЗ"
  ),
  student: (name: "В. С. Ермаков", group: "558301"),
  manager: (name: "Ю. А. Луцик"),
  city: "",
  year: "",
  title-city: "МИНСК",
  title-year: "2026",
  pagination-align: right
)

#show "<<": "«"
#show ">>": "»"

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

#show figure.where(kind: table): set figure(gap: 0.3em)

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

#show outline.entry: it => {
  show linebreak: []
  let clean_body = {
    show "(Обязательное) ": ""
    show "(Необязательное) ": ""
    it.body()
  }

  set block(spacing: 0.65em)

  if state("appendixes", false).at(it.element.location()) {
    link(it.element.location(), it.indented(
      none,
      [ПРИЛОЖЕНИЕ #it.prefix() #clean_body]
        + sym.space
        + box(width: 1fr, it.fill)
        + sym.space
        + sym.wj
        + it.page()
    ))
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
#include "04-multiplexers.typ"
#include "05-evaluation.typ"
#include "06-conclusion.typ"
#include "references.typ"
#show: appendixes
#include "07-appendices.typ"

// todo проставить структурные упоминания в плоложениях