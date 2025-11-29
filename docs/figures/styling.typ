#import "template.typ": *
#show: template

#let content = figure({
  set text(.7em)
  grid(
    columns: (auto,)*12, align: left + horizon,
    row-gutter: .8em, column-gutter: (10pt, 5pt, 5pt)*4,
    ..range(3).map(i => grid.vline(x: 3*i+2, stroke: .4pt)),
    ..code-and-tip("square.with(\n  fill: blue, \n  width: 600%\n)"),
    ..code-and-tip("stealth.with(\n  inset: 5%\n)"),
    ..code-and-tip("straight.with(\n  stroke: 2pt + red\n)"),
    ..code-and-tip("triangle.with(\n  fill: green,\n  length: 1200%,\n  width: 500%\n)"),
    ..code-and-tip("diamond.with(\n  fill: yellow,\n  length: 1000%, \n  width: 500%\n)"),
    ..code-and-tip("stealth.with(\n  inset: 60%\n)"),
    ..code-and-tip("stealth.with(\n  fill: none,\n  stroke: .8pt+blue\n)"),
    ..code-and-tip("rays.with(\n  stroke: .7pt + red\n)"),
    ..code-and-tip("circle.with(\n  fill: red\n)"),
    ..code-and-tip("stealth.with(\n  stroke: 1pt+blue,\n  fill: none\n)"),
    ..code-and-tip("stealth.with(\n  stroke: (dash: \"dashed\", \n    paint: red, \n    thickness: .3pt), \n  fill: none,\n  width: 1000%\n)"),
    ..code-and-tip("bar.with(\n  stroke: 5pt+yellow,\n  width: 700%\n)"),
    ..code-and-tip("tikz.with(\n  stroke: blue,\n  width: 1000%\n)"),
  )
})

#content
