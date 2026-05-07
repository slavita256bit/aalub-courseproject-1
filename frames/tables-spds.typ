/* 
     .--------------------------.
     | ГОСТ Р 21.1101-2013 СПДС |
     '--------------------------'
*/ 

// Параметры таблиц
#let thick-table-borders = 0.7mm // Толстые линии
#let thin-table-borders = 0.3mm // Тонкие линии
#let table-text-size = 10pt // Размер шрифта в таблицах

// Общие переменные
#let current-page = {context counter(page).final().first()} // Номер текущей страницы
#let total-pages = {context [#counter(page).display()]} // Количество страниц

// Для листов основных комплектов рабочих чертежей, графических документов проектной документации и графических документов по инженерным изысканиям (Форма 3)
#let form3 = {
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы
  
  table( // ИЗМЕНИЛ: Добавил переменную
    columns: (10mm, 10mm, 10mm, 10mm, 15mm, 10mm, 70mm, 15mm, 15mm, 20mm),
    // TODO: Таблица залазит на margin страницы
    
    rows: (5mm,)*12,
    align: center + horizon, // Выравнивание таблицы
    stroke: thick-table-borders, // Толщина границ таблицы

    // Общие поля
    table.cell(x: 6, y: 0, colspan: 4, rowspan: 2)[(1)],
    table.cell(x: 6, y: 2, colspan: 4, rowspan: 3)[(2)],
    table.cell(x: 6, y: 5, colspan: 1, rowspan: 3)[(3)],
    table.cell(x: 6, y: 8, colspan: 1, rowspan: 3)[(4)],
    table.cell(x: 7, y: 8, colspan: 3, rowspan: 3)[(9)],

    table.cell(x: 7, y: 5, colspan: 1, rowspan: 1)[Стадия],
    table.cell(x: 7, y: 6, colspan: 1, rowspan: 2)[(6)],
    table.cell(x: 8, y: 5, colspan: 1, rowspan: 1)[Лист],
    table.cell(x: 8, y: 6, colspan: 1, rowspan: 2)[#current-page],
    table.cell(x: 9, y: 5, colspan: 1, rowspan: 1)[Листов],
    table.cell(x: 9, y: 6, colspan: 1, rowspan: 2)[#total-pages],

    // Дополнительное
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1)[(18)],
    table.cell(x: 5, y: 2, rowspan: 1, colspan: 1)[(19)],
    
    // Должность, ФИО, Подпись, Дата
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 1)[Изм.],
    table.cell(x: 1, y: 4, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[Кол.уч.]],
    table.cell(x: 2, y: 4, rowspan: 1, colspan: 1)[Лист],
    table.cell(x: 3, y: 4, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[№док.]],
    table.cell(x: 4, y: 4, rowspan: 1, colspan: 1)[Подп.],
    table.cell(x: 5, y: 4, rowspan: 1, colspan: 1)[Дата],

    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2)[Разраб.],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2)[],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2)[(10)],
    table.cell(x: 0, y: 8, rowspan: 1, colspan: 2)[],
    table.cell(x: 0, y: 9, rowspan: 1, colspan: 2)[Н.контр.],
    table.cell(x: 0, y: 10, rowspan: 1, colspan: 2)[],

    table.cell(x: 2, y: 5, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 6, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 7, rowspan: 1, colspan: 2)[(11)],
    table.cell(x: 2, y: 8, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 9, rowspan: 1, colspan: 2)[], 
    table.cell(x: 2, y: 10, rowspan: 1, colspan: 2)[],

    table.cell(x: 4, y: 5, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 6, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 7, rowspan: 1, colspan: 1)[(12)],
    table.cell(x: 4, y: 8, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 9, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 10, rowspan: 1, colspan: 1)[],

    table.cell(x: 5, y: 5, rowspan: 1, colspan: 1)[], 
    table.cell(x: 5, y: 6, rowspan: 1, colspan: 1)[], 
    table.cell(x: 5, y: 7, rowspan: 1, colspan: 1)[(13)], 
    table.cell(x: 5, y: 8, rowspan: 1, colspan: 1)[],
    table.cell(x: 5, y: 9, rowspan: 1, colspan: 1)[],
    table.cell(x: 5, y: 10, rowspan: 1, colspan: 1)[],

    // Границы
    ..range(1, 4).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)), // Фамилии
    ..range(6, 11).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)), // Фамилии

    // Формат листа
    table.hline(y: 12, stroke: 0pt), // Нижняя линия
    ..range(0, 11).map(n => table.vline(start: 11, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 7, y: 11, rowspan: 1, colspan: 3, align: left + horizon)[Формат (26)]
  )
}


// Для чертежей строительных изделий (первый лист) (Форма 4)
#let form4 = {
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы
  
  table( // ИЗМЕНИЛ: Добавил переменную
    columns: (10mm, 10mm, 10mm, 10mm, 15mm, 10mm, 70mm, 15mm, 15mm, 20mm),
    // TODO: Таблица залазит на margin страницы
    
    rows: (5mm,)*12,
    align: center + horizon, // Выравнивание таблицы
    stroke: thick-table-borders, // Толщина границ таблицы

    // Общие поля
    table.cell(x: 6, y: 0, rowspan: 3, colspan: 4)[(1)],
    table.cell(x: 6, y: 3, rowspan: 5, colspan: 1)[(5)],
    table.cell(x: 6, y: 8, rowspan: 3, colspan: 1)[(23)],
    table.cell(x: 7, y: 8, rowspan: 3, colspan: 3)[(9)],
    table.cell(x: 7, y: 7, rowspan: 1, colspan: 3, inset: 0mm)[
      #table(
        columns: (20mm, 30mm),
        rows: (5mm),
        stroke: thick-table-borders, // Толщина границ таблицы
        
        [Лист #current-page], [Листов #total-pages]
      )
    ],

    table.cell(x: 7, y: 3, rowspan: 1, colspan: 1)[Стадия],
    table.cell(x: 7, y: 4, rowspan: 3, colspan: 1)[(6)],
    table.cell(x: 8, y: 3, rowspan: 1, colspan: 1)[Масса],
    table.cell(x: 8, y: 4, rowspan: 3, colspan: 1)[(24)],
    table.cell(x: 9, y: 3, rowspan: 1, colspan: 1)[Масштаб],
    table.cell(x: 9, y: 4, rowspan: 3, colspan: 1)[(25)],

    // Дополнительное
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1)[(18)],
    table.cell(x: 5, y: 2, rowspan: 1, colspan: 1)[(19)],
    
    // Должность, ФИО, Подпись, Дата
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 1)[Изм.],
    table.cell(x: 1, y: 4, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[Кол.уч.]],
    table.cell(x: 2, y: 4, rowspan: 1, colspan: 1)[Лист],
    table.cell(x: 3, y: 4, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[№док.]],
    table.cell(x: 4, y: 4, rowspan: 1, colspan: 1)[Подп.],
    table.cell(x: 5, y: 4, rowspan: 1, colspan: 1)[Дата],

    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2)[Разраб.],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2)[],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2)[(10)],
    table.cell(x: 0, y: 8, rowspan: 1, colspan: 2)[],
    table.cell(x: 0, y: 9, rowspan: 1, colspan: 2)[Н.контр.],
    table.cell(x: 0, y: 10, rowspan: 1, colspan: 2)[],

    table.cell(x: 2, y: 5, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 6, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 7, rowspan: 1, colspan: 2)[(11)],
    table.cell(x: 2, y: 8, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 9, rowspan: 1, colspan: 2)[], 
    table.cell(x: 2, y: 10, rowspan: 1, colspan: 2)[],

    table.cell(x: 4, y: 5, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 6, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 7, rowspan: 1, colspan: 1)[(12)],
    table.cell(x: 4, y: 8, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 9, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 10, rowspan: 1, colspan: 1)[],

    table.cell(x: 5, y: 5, rowspan: 1, colspan: 1)[], 
    table.cell(x: 5, y: 6, rowspan: 1, colspan: 1)[], 
    table.cell(x: 5, y: 7, rowspan: 1, colspan: 1)[(13)], 
    table.cell(x: 5, y: 8, rowspan: 1, colspan: 1)[],
    table.cell(x: 5, y: 9, rowspan: 1, colspan: 1)[],
    table.cell(x: 5, y: 10, rowspan: 1, colspan: 1)[],

    // Границы
    ..range(1, 4).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)),
    ..range(6, 11).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)), // Фамилии

    // Формат листа
    table.hline(y: 12, stroke: 0pt), // Нижняя линия
    ..range(0, 11).map(n => table.vline(start: 11, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 7, y: 11, rowspan: 1, colspan: 3, align: left + horizon)[Формат (26)]
    
  )
}

// Для эскизных чертежей общих видов нетиповых изделий, всех видов текстовых документов (первый или заглавный лист) (форма 5)
#let form5 = {
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы
  
  table( // ИЗМЕНИЛ: Добавил переменную
    columns: (10mm, 10mm, 10mm, 10mm, 15mm, 10mm, 70mm, 15mm, 15mm, 20mm),
    // TODO: Таблица залазит на margin страницы
    
    rows: (5mm,)*9,
    align: center + horizon, // Выравнивание таблицы
    stroke: thick-table-borders, // Толщина границ таблицы

    // Общие поля
    table.cell(x: 6, y: 0, rowspan: 3, colspan: 4)[(1)],
    table.cell(x: 6, y: 3, rowspan: 5, colspan: 1)[(5)],
    table.cell(x: 7, y: 5, rowspan: 3, colspan: 3)[(23)],


    table.cell(x: 7, y: 3, rowspan: 1, colspan: 1)[Стадия],
    table.cell(x: 7, y: 4, rowspan: 1, colspan: 1)[(6)],
    table.cell(x: 8, y: 3, rowspan: 1, colspan: 1)[Лист],
    table.cell(x: 8, y: 4, rowspan: 1, colspan: 1)[#current-page],
    table.cell(x: 9, y: 3, rowspan: 1, colspan: 1)[Листов],
    table.cell(x: 9, y: 4, rowspan: 1, colspan: 1)[#total-pages],

    // Дополнительное
    table.cell(x: 0, y: 1, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 1, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 1, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 1, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 1, rowspan: 1, colspan: 1)[(18)],
    table.cell(x: 5, y: 1, rowspan: 1, colspan: 1)[(19)],
    
    // Должность, ФИО, Подпись, Дата
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1)[Изм.],
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[Кол.уч.]],
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1)[Лист],
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[№док.]],
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1)[Подп.],
    table.cell(x: 5, y: 2, rowspan: 1, colspan: 1)[Дата],

    table.cell(x: 0, y: 3, rowspan: 1, colspan: 2)[Разраб.],
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 2)[],
    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2)[(10)],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2)[Н.контр.],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2)[],

    table.cell(x: 2, y: 3, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 4, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 5, rowspan: 1, colspan: 2)[(11)],
    table.cell(x: 2, y: 6, rowspan: 1, colspan: 2)[],
    table.cell(x: 2, y: 7, rowspan: 1, colspan: 2)[], 

    table.cell(x: 4, y: 3, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 4, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 5, rowspan: 1, colspan: 1)[(12)],
    table.cell(x: 4, y: 6, rowspan: 1, colspan: 1)[],
    table.cell(x: 4, y: 7, rowspan: 1, colspan: 1)[],

    table.cell(x: 5, y: 3, rowspan: 1, colspan: 1)[], 
    table.cell(x: 5, y: 4, rowspan: 1, colspan: 1)[], 
    table.cell(x: 5, y: 5, rowspan: 1, colspan: 1)[(13)], 
    table.cell(x: 5, y: 6, rowspan: 1, colspan: 1)[],
    table.cell(x: 5, y: 7, rowspan: 1, colspan: 1)[],

    // Границы
    ..range(1, 2).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)), 
    ..range(4, 8).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)), // Фамилии

    // Формат листа
    table.hline(y: 9, stroke: 0pt), // Нижняя линия
    ..range(0, 11).map(n => table.vline(start: 8, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 7, y: 8, rowspan: 1, colspan: 3, align: left + horizon)[Формат (26)]
  )
}

// Для чертежей строительных изделий, эскизных чертежей общих видов нетиповых изделий и всех видов текстовых документов (последующие листы) (форма 6)
#let form6 = {
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы
  
  table( // ИЗМЕНИЛ: Добавил переменную
    columns: (10mm, 10mm, 10mm, 10mm, 15mm, 10mm, 110mm, 10mm),
    // TODO: Таблица залазит на margin страницы
    
    rows: (5mm,) * 4,
    align: center + horizon, // Выравнивание таблицы
    stroke: thick-table-borders, // Толщина границ таблицы

    // Общие поля
    table.cell(x: 6, y: 0, rowspan: 3, colspan: 1)[(1)],

    // Лист
    table.cell(x: 7, y: 0, rowspan: 3, colspan: 1, inset: 0.1mm)[
      #table(
        columns: 10mm,
        rows: (7mm, 8mm),
        stroke: thick-table-borders, // Толщина границ таблицы

        [Лист], 
        [#current-page]
      )
    ],

    // Дополнительное
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1)[Изм.],
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[Кол.уч.]],
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1)[Лист],
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1, inset: 0.1mm)[#scale(x: 80%)[№док.]],
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1)[Подп.],
    table.cell(x: 5, y: 2, rowspan: 1, colspan: 1)[Дата],

    table.cell(x: 0, y: 1, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 1, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 1, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 1, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 1, rowspan: 1, colspan: 1)[(18)],
    table.cell(x: 5, y: 1, rowspan: 1, colspan: 1)[(19)],
    
    // Границы
    ..range(1, 2).map(n => table.hline(y: n, end: 6, stroke: thin-table-borders)), // Фамилии

    // Формат листа
    table.hline(y: 4, stroke: 0pt), // Нижняя линия
    ..range(0, 9).map(n => table.vline(start: 3, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 6, y: 3, rowspan: 1, colspan: 2)[
      #place(
        right + horizon,
        dx: -29mm,
        "Формат (26)"
      )
    ]
  )
}


#form3

#form4

#form5

#form6