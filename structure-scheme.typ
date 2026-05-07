#import "@preview/cetz:0.5.0"

// #set page(width: auto, height: auto, margin: 1cm)

// Вспомогательная функция для вывода вертикального текста
#let vert-text(str) = {
  align(center, par(leading: 0.25em)[#str.clusters().join("\n")])
}

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // --- НАСТРОЙКИ СТИЛЕЙ ЛИНИЙ ---
    // Толстая линия для многоразрядных шин
    let bus(..args) = line(..args, stroke: 2pt, mark: (end: "stealth", fill: black))
    let bus_stealth(..args) = line(..args, stroke: 2pt)
    // Тонкая линия для одноразрядных управляющих сигналов
    let wire(..args) = line(..args, stroke: 1pt, mark: (end: "stealth", fill: black))
    let wire_stealth(..args) = line(..args, stroke: 1pt)
    // Точка соединения проводов
    let dot(pos) = circle(pos, radius: 0.06, fill: black, stroke: none)
    let dotbig(pos) = circle(pos, radius: 0.08, fill: black, stroke: none)

    // --- ГЛОБАЛЬНЫЕ КООРДИНАТЫ (Y-уровни блоков) ---
    let y_rmg_b = 0.0;  let y_rmg_t = 1.5
    let y_fdk_b = 2.5;  let y_fdk_t = 4.0
    let y_ocu_b = 5.5;  let y_ocu_t = 6.9
    let y_ocs_b = 8.5;  let y_ocs_t = 9.9
    let y_acc_b = 11.0; let y_acc_t = 12.5

    // Уровни горизонтальных шин управления
    let y_ctrl = 4.8 // Шина управления (от выхода 2 ПМ к ОЧУ)
    let y_h    = 4.4 // Шина сигнала Mul/Sum (h)

    // ========================================================================
    // 1. ОТРИСОВКА БОЛЬШИХ БЛОКОВ
    // ========================================================================
    rect((-6.0, y_acc_b), (17.0, y_acc_t), name: "acc", stroke: 1pt, fill: white)
    line((-4.5, y_acc_b), (-4.5, y_acc_t), stroke: 1pt) // Отделение знакового разряда
    content((-5.25, (y_acc_b + y_acc_t)/2), [ЗН])
    content((5.5, (y_acc_b + y_acc_t)/2), [*АККУМУЛЯТОР*])

    // Стрелка общего сдвига аккумулятора (Алгоритм В - сдвиг влево)
    wire((14, y_acc_t + 0.5), (2, y_acc_t + 0.5))

    // ФДК
    rect((-3.0, y_fdk_b), (17.0, y_fdk_t), name: "fdk", stroke: 1pt, fill: white)
    line((-1.5, y_fdk_b), (-1.5, y_fdk_t), stroke: 1pt)
    content((-2.25, (y_fdk_b + y_fdk_t)/2), [ЗН])
    content((7.5, (y_fdk_b + y_fdk_t)/2), [*ФДК*])

    // Регистр множимого
    rect((-3.0, y_rmg_b), (17.0, y_rmg_t), name: "rmg", stroke: 1pt, fill: white)
    line((-1.5, y_rmg_b), (-1.5, y_rmg_t), stroke: 1pt)
    content((-2.25, (y_rmg_b + y_rmg_t)/2), [ЗН])
    content((7.5, (y_rmg_b + y_rmg_t)/2), [*РЕГИСТР МНОЖИМОГО*])

    // Регистр множителя (Сдвинут вправо, чтобы провода не пересекались)
    rect((21, y_fdk_b + 3), (22.5, y_acc_t), stroke: 1pt, fill: white)
    content((21.75, 7.5), vert-text("МНОЖИТЕЛЯ"))
    content((21.75, 11), vert-text("РЕГИСТР"))
    // Стрелка сдвига регистра множителя (Вверх, т.к. анализируем старшие биты)
    wire((23.0, y_fdk_b + 4.5), (23.0, y_acc_t - 3))

    // Преобразователь множителя (Сужен, выходы смотрят вправо)
    rect((24.5, y_ocs_b), (27.5, y_acc_t), stroke: 1pt, fill: white)
    content((26.0, (y_ocs_b + y_acc_t)/2), align(center)[Преобра-\ зователь\ множителя])


    // ========================================================================
    // 2. СВЯЗИ И СИГНАЛЫ ПРЕОБРАЗОВАТЕЛЯ МНОЖИТЕЛЯ
    // ========================================================================
    // Входы от Регистра Множителя к ПМ (Слева направо)
    let y_q1 = y_acc_t - 0.6; let y_q2 = y_q1 - 0.8; let y_q3 = y_q2 - 0.8
    wire((22.5, y_q1), (24.5, y_q1)); content((23, y_q1 + 0.3), [$Q_n$])
    wire((22.5, y_q2), (24.5, y_q2)); content((23.2, y_q2 + 0.3), [$Q_(n-1)$])
    wire((22.5, y_q3), (24.5, y_q3)); content((23.2, y_q3 + 0.3), [$Q_(n-2)$])

    content((17.5, 3.5), [$F_1$])

    wire((27.5, y_q2), (28.75, y_q2), (28.75, 3.25), (17.0, 3.25))
    content((27.8, y_q2 + 0.3), [1])

    wire_stealth((27.5, y_q3), (28.3, y_q3)); content((27.8, y_q3 + 0.3), [2])
    let y_q4 = y_q3 - 0.8
    wire_stealth((27.5, y_q4), (28.3, y_q4)); content((27.8, y_q4 + 0.3), [3])
    dotbig((28.3, y_q4))
    bus_stealth((28.3, y_q3), (28.3, y_q3), (28.3, y_ctrl), (0.5, y_ctrl))

    // Сигнал Mul/Sum (h) извне справа
    wire_stealth((30.5, y_h), (0.0, y_h)) // Линия заканчивается на X=0.0 (последний ОЧУ)
    content((30.5, y_h + 0.3), [Mul/Sum])
    content((30.5, y_h - 0.3), [0 / 1])


    // ========================================================================
    // 3. СЕКЦИИ ОЧУ И ОЧС (в цикле)
    // ========================================================================
    let ocu_w = 2.2; let ocs_w = 2.2
    let sp = 3.0 // Шаг между секциями

    for i in range(6) {
      let cx = 15.5 - i * sp // Считаем справа налево от X=15.5 до X=3.5

      // Отрисовка самих квадратиков
      rect((cx - ocu_w/2, y_ocu_b), (cx + ocu_w/2, y_ocu_t), stroke: 1pt, fill: white)
      content((cx, (y_ocu_b + y_ocu_t)/2), [ОЧУ])

      rect((cx - ocs_w/2, y_ocs_b), (cx + ocs_w/2, y_ocs_t), stroke: 1pt, fill: white)
      content((cx, (y_ocs_b + y_ocs_t)/2), [ОЧС])

      // Шины данных (Толстые стрелки вверх)
      bus((cx + 0.5, y_fdk_t), (cx + 0.5, y_ocu_b))
      bus((cx, y_ocu_t), (cx, y_ocs_b))
      bus((cx, y_ocs_t), (cx, y_acc_b))

      // Тонкие провода управления, уходящие наверх в ОЧУ
      bus((cx, y_ctrl), (cx, y_ocu_b))
      wire((cx - 0.5, y_h), (cx - 0.5, y_ocu_b))
      content((cx - 0.8, y_ocu_b - 0.3), [$h$])

      // СТАВИМ ТОЧКИ только если это НЕ последний блок (чтобы не было точки на конце линии)
      if i < 5 {
        dotbig((cx, y_ctrl))
        dot((cx - 0.5, y_h))
      }
    }

    // ========================================================================
    // 4. ПЕРЕНОСЫ И МНОГОТОЧИЯ
    // ========================================================================
    // Цепочка переносов между ОЧС (справа налево)
    for i in range(5) {
      let cx = 15.5 - i * sp
      let nx = 15.5 - (i+1) * sp
      wire((cx - ocs_w/2, (y_ocs_b + y_ocs_t)/2), (nx + ocs_w/2, (y_ocs_b + y_ocs_t)/2))
    }

    // Входной перенос "0" в самый правый ОЧС
    wire((17.5, (y_ocs_b + y_ocs_t)/2), (15.5 + ocs_w/2, (y_ocs_b + y_ocs_t)/2))
    content((17.8, (y_ocs_b + y_ocs_t)/2), [0])

    // ВЫХОДНОЙ ПЕРЕНОС из самого левого ОЧС заводится в аккумулятор
    let left_cx = 15.5 - 5 * sp // = 3.5
    wire((left_cx - ocs_w/2, (y_ocs_b + y_ocs_t)/2), (-1, (y_ocs_b + y_ocs_t)/2), (-1, y_acc_b))

    // ========================================================================
    // 5. ВНЕШНИЕ ВХОДЫ РЕГИСТРОВ И СИГНАЛЫ ЗНАКА
    // ========================================================================
    // Входы в регистр множимого (снизу)
    bus((16.0, y_rmg_b - 0.7), (16.0, y_rmg_b)); content((16.0, y_rmg_b - 1), [$D_1$])
    bus((0, y_rmg_b - 0.7), (0, y_rmg_b));   content((0, y_rmg_b - 1), [$D_(m)$])
    wire((-2.25, y_rmg_b - 0.7), (-2.25, y_rmg_b));   content((-2.25, y_rmg_b - 1), [$D_(m+1)$])

    bus((0, y_rmg_b + 1.5), (0, y_rmg_b + 2.5));
    bus((16.0, y_rmg_b + 1.5), (16.0, y_rmg_b + 2.5));

    // Входы и выходы регистра множителя (Dn, D1 слева, Q1 справа)
    wire((19.5, y_acc_t - 0.5), (21.0, y_acc_t - 0.5))
    content((20.2, y_acc_t - 0.2), [$D_n$])

    content((20.2, y_acc_t - 3.0), vert-text("..."))

    wire((19.5, y_fdk_b + 3.5), (21.0, y_fdk_b + 3.5))
    content((20.2, y_fdk_b + 3.8), [$D_1$])

    wire((22.5, y_fdk_b + 3.5), (24.0, y_fdk_b + 3.5))
    content((23.2, y_fdk_b + 3.8), [$Q_1$])

    // Провода знаковых разрядов (базовые)
    wire((-2.25, y_rmg_t), (-2.25, y_fdk_b))

    // РАЗМНОЖЕНИЕ ЗНАКА (от ФДК в аккумулятор)
    let y_sign_dist = 10.4 // Уровень горизонтальной шины знака
    line((-2.25, y_fdk_t), (-2.25, y_sign_dist))
    line((-2.25, y_sign_dist), (-5.25, y_sign_dist))
    dot((-2.25, y_sign_dist))

    wire((-5.25, y_sign_dist), (-5.25, y_acc_b)) // В дальний ЗН аккумулятора
    wire((-3.75, y_sign_dist), (-3.75, y_acc_b)) // В промежуточный доп. разряд (размноженный знак)
    wire((-2.25, y_sign_dist), (-2.25, y_acc_b))   // Оригинальный вход ЗН

    content((-3, y_acc_b - 0.3), [$. . .$]) // Многоточие для показа размножения
    content((7, y_rmg_b - 0.6), [$. . .$]) // Многоточие для показа размножения
  })
]