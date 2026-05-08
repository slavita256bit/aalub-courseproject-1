#import "dependencies.typ": *
#import "frames/template.typ": *

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
        #move(dy: 2cm, [#include "ochs-scheme.typ"])
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
      paper-format: "a4",
      vertical: true
    )

    #align(center + horizon)[
        #move(dy: -1em, [#include "ochu-scheme.typ"])
    ]
]


#appendix-heading("Необязательное")[Операция $C_0 * C_0$] <app-roth-c0>

Таблица поиска простых импликант $C_0 * C_0$.

#let csv-c0 = csv("generated_files/rots/_ci*ci_00__2026_05_04__09_48_46.csv")
#render-split-roth-table(csv-c0, [Результат операции $C_0 * C_0$], <tbl-app-c0>, chunks: 2, cell-padding: 0.3em, overlap-cols: 0)

#appendix-heading("Необязательное")[Операция $C_1 * C_1$] <app-roth-c1>

Таблица поиска простых импликант $C_1 * C_1$.

#let csv-c1 = csv("generated_files/rots/_ci*ci_01__2026_05_04__09_48_46.csv")
#render-split-roth-table(csv-c1, [Результат операции $C_1 * C_1$], <tbl-app-c1>, chunks: 3, overlap-cols: 0, cell-padding: 0.25em)

#appendix-heading("Необязательное")[Операция $C_2 * C_2$] <app-roth-c2>

Таблица поиска простых импликант $C_2 * C_2$.

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
      #include "pm-scheme.typ"
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
      #include "ochs-mux-scheme.typ"
    ]
]

#appendix-heading("Обязательное")[Ведомость документов] <app-vedomost>

