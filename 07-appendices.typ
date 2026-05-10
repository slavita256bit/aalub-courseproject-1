#import "dependencies.typ": *
#import "frames/template.typ": *

#let appendix-heading(status, level: 1, body) = {
  heading(level: level)[(#status)\ #v(1em) #body]
}

#let get-numbering-alphabet(number) = {
  // excluded "З"
  let alphabet = ("а", "б", "в", "г", "д", "е", "ж", "и", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "э", "ю", "я",)
  let result = ""

  while number > 0 {
    result = alphabet.at(calc.rem(number - 1, 28)) + result
    number = calc.floor(number / 28)
  }

  return result
}

#let heading-numbering(..nums) = {
  nums = nums.pos()
  let letter = upper(get-numbering-alphabet(nums.first()))
  let rest = nums.slice(1).map(elem => str(elem))
  if rest != none {
    return (letter, rest).flatten().join(".")
  }
  return letter
}

#set heading(numbering: heading-numbering, hanging-indent: 0pt)

#appendix-heading("Обязательное")[Схема электрическая структурная] <structure-scheme>

#[
    #show: eskd-scheme.with(
      title: "Сумматор-умножитель\nпервого типа алгоритма <<В>>. Схема\nэлектрическая\nструктурная",
      doc-code: "ГУИР.6-05-0611-05.114 Э1",
      dev-name: "Ермаков",
      prov-name: "Луцик",
      group-name: "ЭВМ, гр. 558301",
      paper-format: "a3",
      vertical: false
    )

    #align(center + horizon)[
      #include "structure-scheme.typ"
    ]
]

#appendix-heading("Обязательное")[Функциональная схема ОЧС] <app-ochs-scheme>

#[
    #show: eskd-scheme.with(
      title: "Одноразрядный четверичный сумматор в базисе НЕ-ИЛИ.\nСхема электрическая\nфункциональная",
      doc-code: "ГУИР.6-05-0611-05.114 Э2.1",
      dev-name: "Ермаков",
      prov-name: "Луцик",
      group-name: "ЭВМ, гр. 558301",
      paper-format: "a3",
      vertical: false
    )

    #align(center + horizon)[
        #move(dy: 1cm, dx: 1cm, [#include "ochs-scheme.typ"])
    ]
]

#appendix-heading("Обязательное")[Функциональная схема ОЧУ] <app-ochu-scheme>

#[
    #show: eskd-scheme.with(
      title: "Одноразрядный четверичный умножитель в базисе ИЛИ, НЕ.\nСхема электрическая\nфункциональная",
      doc-code: "ГУИР.6-05-0611-05.114 Э2.2",
      dev-name: "Ермаков",
      prov-name: "Луцик",
      group-name: "ЭВМ, гр. 558301",
      paper-format: "a3",
      vertical: false
    )

    #align(center + horizon)[
        #move(dy: 1em, [#include "ochu-scheme.typ"])
    ]
]


#appendix-heading("Справочное")[Поиск простых импликант $C_0 * C_0$] <app-roth-c0>

#let csv-c0 = csv("generated_files/rots/_ci*ci_00__2026_05_04__09_48_46.csv")
#render-split-roth-table(csv-c0, [Результат операции $C_0 * C_0$], <tbl-app-c0>, chunks: 2, cell-padding: 0.3em, overlap-cols: 0)

#appendix-heading("Справочное")[Поиск простых импликант $C_1 * C_1$] <app-roth-c1>

#let csv-c1 = csv("generated_files/rots/_ci*ci_01__2026_05_04__09_48_46.csv")
#render-split-roth-table(csv-c1, [Результат операции $C_1 * C_1$], <tbl-app-c1>, chunks: 3, overlap-cols: 0, cell-padding: 0.25em)

#appendix-heading("Справочное")[Поиск простых импликант $C_2 * C_2$] <app-roth-c2>

#let csv-c2 = csv("generated_files/rots/_ci*ci_02__2026_05_04__09_48_46.csv")
#render-split-roth-table(csv-c2, [Результат операции $C_2 * C_2$], <tbl-app-c2>, chunks: 2, cell-padding: 0.3em, overlap-cols: 0)

#appendix-heading("Обязательное")[Функциональная схема ПМ] <app-pm-scheme>

#[
    #show: eskd-scheme.with(
      title: "Преобразователь множителя.\nСхема электрическая\nфункциональная",
      doc-code: "ГУИР.6-05-0611-05.114 Э2.3",
      dev-name: "Ермаков",
      prov-name: "Луцик",
      group-name: "ЭВМ, гр. 558301",
      paper-format: "a4",
      vertical: true
    )

    #align(center + horizon)[
      #move(dy: -1em, [#include "pm-scheme.typ"])
    ]
]

#appendix-heading("Обязательное")[Функциональная схема ОЧС на мультиплексорах] <app-ochs-mux>

#[
    #show: eskd-scheme.with(
      title: "Одноразрядный четверичный сумматор на мультиплексорах.\nСхема электрическая функциональная",
      doc-code: "ГУИР.6-05-0611-05.114 Э2.4",
      dev-name: "Ермаков",
      prov-name: "Луцик",
      group-name: "ЭВМ, гр. 558301",
      paper-format: "a4",
      vertical: true
    )

    #align(center + horizon)[
       #move(dy: -2em, [#include "ochs-mux-scheme.typ"])
    ]
]

#appendix-heading("Обязательное")[Ведомость документов] <app-vedomost>

