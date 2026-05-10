#import "dependencies.typ": *
#import "@preview/cetz:0.5.0"
#import "ochs-table.typ": build-ochs

#[
#import complex-schemes: *

// Загружаем сгенерированные данные ОЧС напрямую
#let tt-data = build-ochs().data

#let addr-groups = (
  ("0","0","0"), ("0","0","1"), ("0","1","0"), ("0","1","1"),
  ("1","0","0"), ("1","0","1"), ("1","1","0"), ("1","1","1")
)

// Функция, которая вычисляет сигнал на информационном входе D
#let get-sig(a1, a2, b1, col) = {
  let sub-rows = ()
  for b2 in ("0", "1") {
    for p in ("0", "1") {
      let match = tt-data.find(r => r.at(0) == a1 and r.at(1) == a2 and r.at(2) == b1 and r.at(3) == b2 and r.at(4) == p)
      if match != none { sub-rows.push(match) }
      else { sub-rows.push((a1, a2, b1, b2, p, "x", "x", "x")) }
    }
  }

  let valid = sub-rows.map(r => r.at(col)).filter(v => v != "x" and v != "х")

  if valid.len() == 0 { return "0" }
  if valid.len() == 2 {
    let (v0, v1) = valid
    if v0 == "0" and v1 == "0" { return "0" }
    if v0 == "1" and v1 == "1" { return "1" }
    if v0 == "0" and v1 == "1" { return "p" }
    if v0 == "1" and v1 == "0" { return "!p" }
  }
  return "?"
}

// Карта соответствия сигналов пинам на нашей единой шине
#let sig-map = (
  "0": 1, "1": 2, "p": 3, "!p": 4, "a1": 5, "a2": 6, "b1": 7
)

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // Рисуем магистраль (шину) - передаем координаты в скобках!
    draw-bus((0, 1.0), (0, -20.0))

    // Вводим сигналы в шину сверху вниз
    bus-in(0, -0.5, $0$, 1)
    bus-in(0, -1.5, $1$, 2)
    bus-in-inv(0, -2.5, move(dx: -0.4em, $p$), 3, 4, basis: "NOT")
    bus-in(0, -5.5, move(dx: 0.4em, $a_1$), 5)
    bus-in(0, -6.5, move(dx: 0.4em, $a_2$), 6)
    bus-in(0, -7.5, move(dx: 0.4em, $b_1$), 7)

    let MUX_X = 2.0
    // Y-координаты для трех мультиплексоров
    let mux-y = (0.5, -6.5, -13.5)
    let labels = ($П$, $S_1$, $S_2$)
    // Индексы колонок в таблице истинности (П=5, S1=6, S2=7)
    let cols = (5, 6, 7)

    for m-idx in range(3) {
      let y-pos = mux-y.at(m-idx)
      let name = "mux" + str(m-idx)

      // Отрисовываем сам блок мультиплексора (уменьшили пин-степ для компактности)
      mux(name, (MUX_X, y-pos), data-inputs: 8, addr-inputs: 3, data-label: "D", addr-label: "A")

      // Подключаем информационные входы D0..D7
      for (i, addr) in addr-groups.enumerate() {
        let sig = get-sig(addr.at(0), addr.at(1), addr.at(2), cols.at(m-idx))
        let pin-num = sig-map.at(sig)
        // Каскадно увеличиваем точку излома, чтобы провода не пересекались
        bus-tap(0, name + ".in-d" + str(i), pin-num, z-fract: 20% + i * 7%)
      }

      // Подключаем адресные входы: A2=a1(MSB), A1=a2, A0=b1(LSB)
      // В Typst/Cetz пины рисуются сверху вниз: A0 - верхний, A2 - нижний
      bus-tap(0, name + ".in-a0", 7, z-fract: 80%) // b1
      bus-tap(0, name + ".in-a1", 6, z-fract: 85%) // a2
      bus-tap(0, name + ".in-a2", 5, z-fract: 90%) // a1

      // Рисуем выход
      wire(name + ".out", (MUX_X + 4.0, y-pos - 3.25), routing: "direct")
      content((MUX_X + 3.6, y-pos - 2.95), labels.at(m-idx), anchor: "west")
    }
  })
]
]