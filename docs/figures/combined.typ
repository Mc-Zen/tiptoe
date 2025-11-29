#import "template.typ": *
#show: template


#let content = figure({
  set text(.7em)
  grid(
    columns: (auto,) * 12, align: left + horizon,
    row-gutter: .8em, column-gutter: (10pt, 5pt, 5pt) * 4,
    ..range(3).map(i => grid.vline(x: 3 * i + 2, stroke: .4pt)),
    ..code-and-tip("combine(\n  bar,\n  stealth\n)"),
    ..code-and-tip(
      "combine(\n  straight, 200%,\n  straight, 200%,\n  straight\n)",
    ),
    ..code-and-tip(
      "combine(\n  square.with(fill: blue),\n  circle.with(fill: red,
    align: end)\n)",
    ),
    ..code-and-tip("combine(\n  bar, 200%, \n  bar, 200%, \n  bar\n)"),
    ..code-and-tip("combine(\n  stealth,\n  bar\n)"),
    ..code-and-tip(
      "combine(\n  straight,\n  end, 200%,\n  straight, 200%,\n  straight\n)",
    ),
    ..code-and-tip(
      "combine(\n  bar.with(stroke: blue),\n  200%, bar, \n  200%, bar\n)",
    ),
    ..code-and-tip("combine(\n  bar,\n  end, 200%, \n  bar, 200%,\n  bar\n)"),
    ..code-and-tip("combine(\n  stealth,\n  stealth\n)"),
  )
})

#content
