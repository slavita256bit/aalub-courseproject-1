#import "dependencies.typ": *

= Операция $C_0 * C_0$ <app-roth-c0>

В данном приложении представлена таблица поиска простых импликант первого этапа алгоритма Рота.

#page(width: auto, height: auto, margin: 1cm)[
#let csv-c0 = csv("generated_files/rots/_ci*ci_00__2026_05_04__09_48_46.csv")
#render-roth-table(csv-c0, [Результат операции $C_0 * C_0$], <tbl-app-c0>)
]

#pagebreak()

= Операция $C_1 * C_1$ <app-roth-c1>

В данном приложении представлена матрица второй итерации умножения кубов по алгоритму Рота.

#page(width: auto, height: auto, margin: 1cm)[
#let csv-c1 = csv("generated_files/rots/_ci*ci_01__2026_05_04__09_48_46.csv")
#render-roth-table(csv-c1, [Результат операции $C_1 * C_1$], <tbl-app-c1>)
]

#pagebreak()

= Операция $C_2 * C_2$ <app-roth-c2>

В данном приложении представлена матрица третьей итерации умножения кубов по алгоритму Рота.

#page(width: auto, height: auto, margin: 1cm)[
#let csv-c2 = csv("generated_files/rots/_ci*ci_02__2026_05_04__09_48_46.csv")
#render-roth-table(csv-c2, [Результат операции $C_2 * C_2$], <tbl-app-c2>)
]