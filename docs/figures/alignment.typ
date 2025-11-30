#import "template.typ": *
#show: template

#let content = figure(box(height: 7.3cm, width: 9.2cm, stroke: none, {
  set std.line(stroke: foreground)
  // set text(.8em)
  // show box: set align(center)
  // set box(stroke: red)
  show text: set align(center)

  let da = 85pt
  let dy = 17pt
  let y0 = 5em
  let len = 60pt
  let line = line.with(length: len, stroke: 1.4pt + foreground)

  place(dx: 0pt, dy: 4pt, box(width: da)[Always end-aligned tips])
  place(dx: da, dy: 4pt, box(width: 2 * da)[Tips with configurable alignment ])
  place(dy: 2.13em, dx: da, box(
    width: da,
  )[`align: center` #text(.8em)[(default)]])
  place(dy: 2.13em, dx: 2 * da, box(width: da)[`align: end`])

  let tips = (
    stealth,
    round,
    straight,
    stealth.with(rev: true),
    round.with(rev: true),
    straight.with(rev: true),
    tikz,
    barb,
    hooks,
  )
  place(dx: da, std.line(
    angle: 90deg,
    stroke: .3pt,
    length: y0 + dy * tips.len(),
  ))
  for (i, tip) in tips.enumerate() {
    place(dx: da - len, dy: y0 + i * dy, line(tip: tip))
  }

  let tips = (
    square,
    circle,
    diamond,
    bar,
    rays,
  )
  place(dy: 2em, dx: 2 * da, std.line(
    angle: 90deg,
    stroke: .3pt,
    length: y0 + dy * tips.len() - 2em,
  ))
  for (i, tip) in tips.enumerate() {
    place(dx: 2 * da - len, dy: y0 + i * dy, line(tip: tip))
  }

  let tips = (
    square.with(align: end),
    circle.with(align: end),
    diamond.with(align: end),
    bar.with(align: end),
    rays.with(align: end),
  )
  place(dy: 0pt, dx: 3 * da, std.line(
    angle: 90deg,
    stroke: .3pt,
    length: y0 + dy * tips.len(),
  ))
  for (i, tip) in tips.enumerate() {
    place(dx: 3 * da - len, dy: y0 + i * dy, line(tip: tip))
  }
}))

#content
