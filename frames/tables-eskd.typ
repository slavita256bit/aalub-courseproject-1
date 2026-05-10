/* 
    .--------------------------------------.
    | ГОСТ 2.104-2006 / ГОСТ 2.104-68 ЕСКД |
    '--------------------------------------'
*/ 

// Параметры таблиц
#let thick-table-borders = 0.5mm // Толстые линии
#let thin-table-borders = 0.3mm // Тонкие линии
#let table-text-size = 10pt // Размер шрифта в таблицах

// Общие переменные
#let current-page = {context counter(page).final().first()} // Номер текущей страницы
#let total-pages = {context [#counter(page).display()]} // Количество страниц

// Основная надпись и дополнительные графы для чертежей и схем (Форма 1)
#let table-dd = { // Drawings and Diagrams > dd
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы
  
  table( // ИЗМЕНИЛ: Добавил переменную
    columns: (7mm, 10mm, 23mm, 15mm, 10mm, 70mm, 5mm, 5mm, 5mm, 5mm, 12mm, 18mm),
    // TODO: Таблица залазит на margin страницы
    
    rows: (5mm,)*12,
    align: center + horizon, // Выравнивание таблицы
    stroke: thick-table-borders, // Толщина границ таблицы
    
    // Общие поля
    table.cell(x: 5, y: 3, colspan: 1, rowspan: 5)[(1)],
    table.cell(x: 5, y: 0, colspan: 7, rowspan: 3)[(2)],
    table.cell(x: 5, y: 8, colspan: 1, rowspan: 3)[(3)],
    table.cell(x: 6, y: 3, colspan: 3, rowspan: 1)[Лит.],
    table.cell(x: 6, y: 4, colspan: 1, rowspan: 3)[], // Литеры
    table.cell(x: 7, y: 4, colspan: 1, rowspan: 3)[(4)], // Литеры
    table.cell(x: 8, y: 4, colspan: 1, rowspan: 3)[], // Литеры
    table.cell(x: 9, y: 3, colspan: 2, rowspan: 1)[Масса],
    table.cell(x: 9, y: 4, colspan: 2, rowspan: 3)[(5)],
    table.cell(x: 11, y: 3, colspan: 1, rowspan: 1)[Масштаб],
    table.cell(x: 11, y: 4, colspan: 1, rowspan: 3)[(6)],
    table.cell(x: 6, y: 7, colspan: 4, rowspan: 1)[Лист #current-page],
    table.cell(x: 10, y: 7, colspan: 2, rowspan: 1)[Листов #total-pages],
    table.cell(x: 6, y: 8, colspan: 6, rowspan: 3)[(9)],

    // Секция (33)
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1)[(18)],
    
    // Должность, ФИО, подпись, дата
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 1, align: left + horizon, inset: 0.1mm)[#scale(x: 80%)[Изм.]],
    table.cell(x: 1, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[Лист],
    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2, align: left + horizon)[Разраб.],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2, align: left + horizon)[Пров.],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2, align: left + horizon)[Т. конт],
    table.cell(x: 0, y: 8, rowspan: 1, colspan: 2, align: left + horizon)[(10)],
    table.cell(x: 0, y: 9, rowspan: 1, colspan: 2, align: left + horizon)[Н. конт],
    table.cell(x: 0, y: 10, rowspan: 1, colspan: 2, align: left + horizon)[Утв],
  
    table.cell(x: 2, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[№ докум.],  
    table.cell(x: 2, y: 5, rowspan: 1, colspan: 1, align: left + horizon)[ФИО1],
    table.cell(x: 2, y: 6, rowspan: 1, colspan: 1, align: left + horizon)[ФИО2],
    table.cell(x: 2, y: 7, rowspan: 1, colspan: 1, align: left + horizon)[ФИО3],
    table.cell(x: 2, y: 8, rowspan: 1, colspan: 1, align: left + horizon)[(11)],
    table.cell(x: 2, y: 9, rowspan: 1, colspan: 1, align: left + horizon)[ФИО5],
    table.cell(x: 2, y: 10, rowspan: 1, colspan: 1, align: left + horizon)[ФИО6],
  
    table.cell(x: 3, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[Подп.],  
    table.cell(x: 3, y: 5, rowspan: 1, colspan: 1)[Подп1],
    table.cell(x: 3, y: 6, rowspan: 1, colspan: 1)[Подп2],
    table.cell(x: 3, y: 7, rowspan: 1, colspan: 1)[Подп3],
    table.cell(x: 3, y: 8, rowspan: 1, colspan: 1)[(12)],
    table.cell(x: 3, y: 9, rowspan: 1, colspan: 1)[Подп5],
    table.cell(x: 3, y: 10, rowspan: 1, colspan: 1)[Подп6],
  
    table.cell(x: 4, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[Дата], 
    table.cell(x: 4, y: 5, rowspan: 1, colspan: 1)[Дaт1],
    table.cell(x: 4, y: 6, rowspan: 1, colspan: 1)[Дaт2],
    table.cell(x: 4, y: 7, rowspan: 1, colspan: 1)[Дaт3],
    table.cell(x: 4, y: 8, rowspan: 1, colspan: 1)[(13)],
    table.cell(x: 4, y: 9, rowspan: 1, colspan: 1)[Дaт5],
    table.cell(x: 4, y: 10, rowspan: 1, colspan: 1)[Дaт6],
    

    // Толщина линий
    ..range(1, 1+3).map(n => table.hline(y: n, end: 5, stroke: thin-table-borders)), // Зона (33)
    ..range(6, 6+5).map(n => table.hline(y: n, end: 5, stroke: thin-table-borders)), // Фамилии
      
  
    // Копировал (31) и Формат (32)
    table.cell(x: 5, y: 11, colspan: 1, rowspan: 1, align: center + horizon)[#text(size: 10pt)[Копировал (31)]],
    table.cell(x: 6, y: 11, colspan: 6, rowspan: 1, align: right + horizon)[Формат (32)],
    
    // Скрытие границ нижнего ряда
    table.hline(y: 12, stroke: 0pt), // Нижняя линяя 
    ..range(0, 13).map(n => table.vline(start: 11, x: n,  stroke: 0pt)), // Вертикальные линии
  
    )
}


// Основная надпись и дополнительные графы для текстовых конструкторских документов (первый или заглавный лист) (Форма 2)
#let table-tdd-f = { // text design documents - first > tdd-f
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы

  table(
    columns: (7mm, 10mm, 23mm, 15mm, 10mm, 70mm, 15mm, 15mm, 20mm),
    rows: (5mm,) * 9,
    align: center + horizon,
    stroke: thick-table-borders,
    
    // Общие поля
    table.cell(x: 6, y: 5, rowspan: 3, colspan: 3)[(9)],
    table.cell(x: 5, y: 0, rowspan: 3, colspan: 4)[(2)],
    table.cell(x: 5, y: 3, rowspan: 5, colspan: 1)[(1)],

    // Дополнительные поля
    table.cell(x: 0, y: 1, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 1, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 1, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 1, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 1, rowspan: 1, colspan: 1)[(18)],
    
    // Должность, ФИО, подпись, дата
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1, align: left + horizon, inset: 0.1mm)[#scale(x: 80%)[Изм.]],
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Лист],
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[№ докум.],
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Подп.],
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Дата],

    table.cell(x: 0, y: 3, rowspan: 1, colspan: 2, align: left + horizon)[Разраб.],
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 2, align: left + horizon)[Пров.],
    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2, align: left + horizon)[(10)],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2, align: left + horizon)[Н.контр.],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2, align: left + horizon)[Утв.],

    table.cell(x: 2, y: 3, rowspan: 1, colspan: 1, align: left + horizon)[ФИО1],
    table.cell(x: 2, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[ФИО2],
    table.cell(x: 2, y: 5, rowspan: 1, colspan: 1, align: left + horizon)[(11)],
    table.cell(x: 2, y: 6, rowspan: 1, colspan: 1, align: left + horizon)[ФИО4],
    table.cell(x: 2, y: 7, rowspan: 1, colspan: 1, align: left + horizon)[ФИО5], 

    table.cell(x: 3, y: 3, rowspan: 1, colspan: 1)[Подп1],
    table.cell(x: 3, y: 4, rowspan: 1, colspan: 1)[Подп2],
    table.cell(x: 3, y: 5, rowspan: 1, colspan: 1)[(12)],
    table.cell(x: 3, y: 6, rowspan: 1, colspan: 1)[Подп4],
    table.cell(x: 3, y: 7, rowspan: 1, colspan: 1)[Подп5],

    table.cell(x: 4, y: 3, rowspan: 1, colspan: 1)[Дат1], 
    table.cell(x: 4, y: 4, rowspan: 1, colspan: 1)[Дат2], 
    table.cell(x: 4, y: 5, rowspan: 1, colspan: 1)[(13)],
    table.cell(x: 4, y: 6, rowspan: 1, colspan: 1)[Дат4],
    table.cell(x: 4, y: 7, rowspan: 1, colspan: 1)[Дат5],

    // Стадия, лист, листов
    table.cell(x: 6, y: 3, rowspan: 1, colspan: 1, align: center + horizon)[Лит.],
    table.cell(x: 6, y: 4, rowspan: 1, colspan: 1, align: center + horizon)[(6)],
    table.cell(x: 7, y: 3, rowspan: 1, colspan: 1, align: center + horizon)[Лист],
    table.cell(x: 7, y: 4, rowspan: 1, colspan: 1, align: center + horizon)[#current-page],
    table.cell(x: 8, y: 3, rowspan: 1, colspan: 1, align: center + horizon)[Листов],
    table.cell(x: 8, y: 4, rowspan: 1, colspan: 1, align: center + horizon)[#total-pages],

    // Границы таблицы
    table.hline(y: 1, end: 5, stroke: thin-table-borders), // Вторая линия 
    ..range(4, 8).map(n => table.hline(y: n, end: 5, stroke: thin-table-borders)), // Фамилии

    // Копировал и формат листа
    table.hline(y: 9, stroke: 0pt), // Нижняя линия
    ..range(0, 10).map(n => table.vline(start: 8, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 5, y: 8)[Копировал (31)],
    table.cell(x: 6, y: 8, rowspan: 1, colspan: 3, align: right + horizon)[Формат (32)]
  )
}

// Основная надпись и дополнительные графы для чертежей (схем) и текстовых конструкторских документов (последующие листы) (Форма 2а)
#let table-tdd-s = { // text design documents - subsequent > tdd-s
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы

  table(
    columns: (7mm, 10mm, 23mm, 15mm, 10mm, 110mm, 10mm),
    rows: (5mm, ) * 4,
    align: center + horizon,
    stroke: thick-table-borders,

    // Общие поля
    table.cell(x: 5, y: 0, rowspan: 3, colspan: 1)[(2)], // Обозначение документа
   
    // Изм., Лист, №Документа, Подп., Дата
    table.cell(x: 0, y: 1, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 1, y: 1, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 2, y: 1, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 3, y: 1, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 4, y: 1, rowspan: 1, colspan: 1)[(18)],
    
    table.cell(x: 0, y: 2, rowspan: 1, colspan: 1, align: left + horizon, inset: 0.1mm)[#scale(x: 80%)[Изм.]], 
    table.cell(x: 1, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Лист], 
    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[№ докум.], 
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Подп.], 
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Дата],

    // Лист
    table.cell(x: 6, y: 0, rowspan: 3, colspan: 1, inset: 0mm)[
      #table(
        columns: (10mm),
        rows: (7mm, 8mm),

        // Лист
        [Лист],
        [#total-pages]
      )
    ],

    // Границы таблицы 
    table.hline(y: 1, end: 5, stroke: thin-table-borders), // Вторая линия

    // Копировал (31) и Формат (32)
    table.hline(y: 4, stroke: 0pt), // Нижняя линия
    ..range(0, 8).map(n => table.vline(start: 3, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 5, y: 3)[
      #place(
        left + horizon, 
        dx: 5mm, 
        "Копировал (31)"
      ) 
      #place(
        right + horizon, 
        dx: 0mm, 
        "Формат (32)"
      )
    ],
  )
}

// Основная надпись и дополнительные графы для текстовых конструкторских документов при двустороннем светокопировании (последующие листы) (Форма 2б)
#let table-tdd-s-d = { // text design documents - subsequent - dual > tdd-s-d
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы

  table(
    columns: (10mm, 110mm, 7mm, 10mm, 23mm, 15mm, 10mm),
    rows: (5mm, ) * 4,
    align: center + horizon,
    stroke: thick-table-borders,


    // Лист
    table.cell(x: 0, y: 0, rowspan: 3, colspan: 1, inset: 0mm)[
      #table(
        columns: (10mm),
        rows: (7mm, 8mm),

        // Лист
        [Лист],
        [#total-pages]
      )
    ],

    // Общие поля
    table.cell(x: 1, y: 0, rowspan: 3, colspan: 1)[(2)], // Обозначение документа

    // Изм., Лист, №Документа, Подп., Дата
    table.cell(x: 2, y: 1, rowspan: 1, colspan: 1)[(14)],
    table.cell(x: 3, y: 1, rowspan: 1, colspan: 1)[(15)],
    table.cell(x: 4, y: 1, rowspan: 1, colspan: 1)[(16)],
    table.cell(x: 5, y: 1, rowspan: 1, colspan: 1)[(17)],
    table.cell(x: 6, y: 1, rowspan: 1, colspan: 1)[(18)],

    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1, align: left + horizon, inset: 0.1mm)[#scale(x: 80%)[Изм.]], 
    table.cell(x: 3, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Лист], 
    table.cell(x: 4, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[№ докум.], 
    table.cell(x: 5, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Подп.], 
    table.cell(x: 6, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[Дата],

    // Границы таблицы 
    table.hline(y: 1, end: 7, stroke: thin-table-borders), // Вторая линия

    // Копировал (31) и Формат (32)
    table.hline(y: 4, stroke: 0pt), // Нижняя линия
    ..range(0, 8).map(n => table.vline(start: 3, x: n,  stroke: 0pt)), // Вертикальные линии
    table.cell(x: 1, y: 3, rowspan: 1, colspan: 6)[
      #place(
        center + horizon, 
        dx: 5mm, 
        "Копировал (31)"
      ) 
      #place(
        right + horizon, 
        dx: 0mm, 
        "Формат (32)"
      )
    ],
  )
}

// Вертикальная таблица (5 колонок)
#let table-left-5r = { // table - left - 5 row
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы

  rotate(-90deg, reflow: true,
    table(
      columns: (25mm, 35mm, 25mm, 25mm, 35mm),
      rows: (5mm, 7mm),
      align: center + horizon,
      stroke: thick-table-borders,

      [Инв. № подп.], [Подп. и дата], [Взам. инв. №], [Инв. № дубл.], [Подп. и дата],
      [(19)], [(20)], [(21)], [(22)], [(23)],

    )
  )
}

// Вертикальная таблица (3 колонки)
#let table-left-3r = { // table - left - 3 row
  show table.cell: set text(size: table-text-size) // Размер шрифта текущей таблицы

  rotate(-90deg, reflow: true,
    table(
      columns: (25mm, 35mm, 25mm),
      rows: (5mm, 7mm),
      align: center + horizon,
      stroke: thick-table-borders,

      [Инв. № подп.], [Подп. и дата], [Взам. инв. №], 
      [(19)], [(20)], [(21)]

    )
  )
}

// ==========================================
// ДОБАВЛЕНО ДЛЯ ЧЕРТЕЖЕЙ СХЕМ (А3/А4)
// ==========================================

// Основная надпись (Штамп Форма 1) с автозаполнением
#let table-schema-form1(title: "", doc-code: "", dev-name: "", prov-name: "", group-name: "") = {
  show table.cell: set text(font: "GOST Type A", size: 11pt)

  table(
    columns: (7mm, 10mm, 23mm, 15mm, 10mm, 70mm, 5mm, 5mm, 5mm, 5mm, 12mm, 18mm),
    rows: (5mm,) * 11, // 11 строк по 5 мм = 55 мм высота штампа
    align: center + horizon,
    stroke: thick-table-borders,

    // Зона наименования и шифра
    table.cell(x: 5, y: 3, colspan: 1, rowspan: 5)[
     #set par(leading: 0.4em, justify: false)
     #text(size: 14pt, title)
    ],
    table.cell(x: 5, y: 0, colspan: 7, rowspan: 3)[#text(size: 20pt, doc-code)],

    // Зона литер, массы, масштаба
    table.cell(x: 6, y: 3, colspan: 3, rowspan: 1)[Лит.],
    table.cell(x: 6, y: 4, colspan: 1, rowspan: 3)[],
    table.cell(x: 7, y: 4, colspan: 1, rowspan: 3)[Т], // Литера из твоего скриншота
    table.cell(x: 8, y: 4, colspan: 1, rowspan: 3)[],
    table.cell(x: 9, y: 3, colspan: 2, rowspan: 1)[Масса],
    table.cell(x: 9, y: 4, colspan: 2, rowspan: 3)[],
    table.cell(x: 11, y: 3, colspan: 1, rowspan: 1)[Масштаб],
    table.cell(x: 11, y: 4, colspan: 1, rowspan: 3)[],

    // Зона листов и группы
    table.cell(x: 5, y: 8, rowspan: 3, colspan: 1)[], // Пустая ячейка, которую объединяем
    table.cell(x: 6, y: 7, colspan: 4, rowspan: 1)[Лист],
    table.cell(x: 10, y: 7, colspan: 2, rowspan: 1)[Листов 1],
    table.cell(x: 6, y: 8, colspan: 6, rowspan: 3)[#text(size: 16pt, group-name)],

    // Левый блок (Разраб, Пров и т.д.)
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 1, align: left + horizon, inset: 0.1mm)[#scale(x: 80%)[Изм.]],
    table.cell(x: 1, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[Лист],
    table.cell(x: 2, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[№ докум.],
    table.cell(x: 3, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[Подпись],
    table.cell(x: 4, y: 4, rowspan: 1, colspan: 1, align: left + horizon)[Дата],

    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2, align: left + horizon)[Разраб.],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2, align: left + horizon)[Пров.],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2, align: left + horizon)[],
    table.cell(x: 0, y: 8, rowspan: 1, colspan: 2, align: left + horizon)[],
    table.cell(x: 0, y: 9, rowspan: 1, colspan: 2, align: left + horizon)[],
    table.cell(x: 0, y: 10, rowspan: 1, colspan: 2, align: left + horizon)[],

    table.cell(x: 2, y: 5, rowspan: 1, colspan: 1, align: left + horizon)[#dev-name],
    table.cell(x: 2, y: 6, rowspan: 1, colspan: 1, align: left + horizon)[#prov-name],

    // Пустые ячейки ФИО
    ..range(7, 11).map(y => table.cell(x: 2, y: y, [])),
    // Пустые подписи
    ..range(5, 11).map(y => table.cell(x: 3, y: y, [])),
    // Пустые даты
    ..range(5, 11).map(y => table.cell(x: 4, y: y, [])),

    // Пустые ячейки служебной зоны (14-18)
    ..range(0, 5).map(x => table.cell(x: x, y: 2, [])),
    ..range(0, 5).map(x => table.cell(x: x, y: 3, [])),

    // Тонкие линии для строк с ФИО
    ..range(1, 4).map(n => table.hline(y: n, end: 5, stroke: thin-table-borders)),
    ..range(6, 11).map(n => table.hline(y: n, end: 5, stroke: thin-table-borders)),
  )
}

// Дублирующий блок в левом верхнем углу (перевернутый)
#let table-schema-top-left(doc-code: "") = {
  rotate(180deg)[
    #table(
      columns: (70mm,),
      rows: (14mm,),
      align: center + horizon,
      stroke: thick-table-borders,
      table.cell(text(font: "GOST Type A", size: 16pt)[#doc-code])
    )
  ]
}

// ==========================================
// ОСНОВНАЯ НАДПИСЬ ДЛЯ ВЕДОМОСТИ
// ==========================================
#let table-vedomost-stamp(title: "", doc-code: "", dev-name: "", prov-name: "", group-name: "") = {
  show table.cell: set text(font: "GOST Type A", size: 11pt, style: "normal")

  table(
    columns: (7mm, 10mm, 23mm, 15mm, 10mm, 70mm, 5mm, 5mm, 5mm, 15mm, 20mm), // Разбили колонку 15мм на 5+5+5
    rows: (5mm,) * 8, // 8 строк по 5 мм = высота штампа 40 мм
    align: center + horizon,
    stroke: thick-table-borders,

    // Зона наименования и шифра
    table.cell(x: 5, y: 3, colspan: 1, rowspan: 5)[
     #set par(leading: 0.4em, justify: false)
     #text(size: 5mm, title)
    ],
    table.cell(x: 5, y: 0, colspan: 6, rowspan: 3)[#text(size: 7mm, doc-code)],

    // Зона литер, листов
    table.cell(x: 6, y: 3, colspan: 3, rowspan: 1)[Лит.],
    table.cell(x: 6, y: 4, colspan: 1, rowspan: 1)[],
    table.cell(x: 7, y: 4, colspan: 1, rowspan: 1, stroke: (left: thin-table-borders, right: thin-table-borders, top: thick-table-borders, bottom: thick-table-borders))[Т],
    table.cell(x: 8, y: 4, colspan: 1, rowspan: 1)[],
    table.cell(x: 9, y: 3, colspan: 1, rowspan: 1)[Лист],
    table.cell(x: 9, y: 4, colspan: 1, rowspan: 1)[],
    table.cell(x: 10, y: 3, colspan: 1, rowspan: 1)[Листов],
    table.cell(x: 10, y: 4, colspan: 1, rowspan: 1)[1],
    table.cell(x: 6, y: 5, colspan: 5, rowspan: 3)[#text(size: 16pt, group-name)],

    // Левый блок (Разраб, Пров и т.д.)
    table.cell(x: 0, y: 1, rowspan: 1, colspan: 1, align: left + horizon, inset: 0.1mm)[#scale(x: 80%)[Изм.]],
    table.cell(x: 1, y: 1, rowspan: 1, colspan: 1, align: left + horizon)[Лист],
    table.cell(x: 2, y: 1, rowspan: 1, colspan: 1, align: left + horizon)[№ докум.],
    table.cell(x: 3, y: 1, rowspan: 1, colspan: 1, align: left + horizon)[Подпись],
    table.cell(x: 4, y: 1, rowspan: 1, colspan: 1, align: left + horizon)[Дата],

    table.cell(x: 0, y: 2, rowspan: 1, colspan: 2, align: left + horizon)[Разраб.],
    table.cell(x: 0, y: 3, rowspan: 1, colspan: 2, align: left + horizon)[Пров.],
    table.cell(x: 0, y: 4, rowspan: 1, colspan: 2, align: left + horizon)[],
    table.cell(x: 0, y: 5, rowspan: 1, colspan: 2, align: left + horizon)[],
    table.cell(x: 0, y: 6, rowspan: 1, colspan: 2, align: left + horizon)[],
    table.cell(x: 0, y: 7, rowspan: 1, colspan: 2, align: left + horizon)[],

    table.cell(x: 2, y: 2, rowspan: 1, colspan: 1, align: left + horizon)[#dev-name],
    table.cell(x: 2, y: 3, rowspan: 1, colspan: 1, align: left + horizon)[#prov-name],

    // Пустые ячейки ФИО
    ..range(4, 8).map(y => table.cell(x: 2, y: y, [])),
    // Пустые подписи
    ..range(2, 8).map(y => table.cell(x: 3, y: y, [])),
    // Пустые даты
    ..range(2, 8).map(y => table.cell(x: 4, y: y, [])),

    // Пустая ячейка служебной зоны (верхняя строка)
    ..range(0, 5).map(x => table.cell(x: x, y: 0, [])),

    // Тонкие линии для строк
    table.hline(y: 1, end: 5, stroke: thin-table-borders),
    ..range(3, 8).map(n => table.hline(y: n, end: 5, stroke: thin-table-borders)),
  )
}