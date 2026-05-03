#import "dependencies.typ": *
#import "ochs-table.typ": *
#import "ochu-table.typ": *
#import "pm-table.typ": *

#set text(font: "Times New Roman", size: 14pt)
#show math.equation: set text(font: "STIX Two Math", size: 14pt)

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

// #set math.equation(numbering: none)
//
// #let ochs = build-ochs()
// #block[#show: ochs.table]
// #let ochu = build-ochu()
// #block[#show: ochu.table]
