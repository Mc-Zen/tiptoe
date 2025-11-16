#import "template.typ": *
#show: template

#let content = figure(box(width: 8cm, height: 2.6cm, stroke: none, {
  let coords = (((0pt, 0pt), (-20pt, 0pt)), ((50pt, 20pt), (-20pt, 0pt)))
  let stroke = 2.4pt + foreground
  let red-stroke = 2.4pt + red.lighten(if dark {10%} else {50%})
  place([`shorten: 0%`])
  place(dx: 80pt, [`shorten: 100%`])
  place(dx: 160pt, [`shorten: 70%`])
  place(dx: 10pt, dy: 20pt, {

    place(path(
      ..coords,
      stroke: red-stroke
    ))
    place(dy: 30pt, path(
      ..coords,
      stroke: stroke,
      tip: stealth, shorten: 0%
    ))
    place(line(start: (25pt, 15pt), length: 20pt, angle: 90deg, tip: stealth, stroke: .5pt + foreground))
    place(line(start: (80pt + 25pt, 15pt), length: 20pt, angle: 90deg, tip: stealth, stroke: .5pt + foreground))
    place(line(start: (160pt + 25pt, 15pt), length: 20pt, angle: 90deg, tip: stealth, stroke: .5pt + foreground))

    place(dx: 80pt, path(
      ..coords,
      stroke: red-stroke
    ))
    place(dx: 80pt, dy: 30pt, path(
      ..coords,
      stroke: red-stroke
    ))
    place(dx: 80pt, dy: 30pt, path(
      ..coords,
      stroke: stroke,
      tip: stealth,
    ))

    place(dx: 160pt, path(
      ..coords,
      stroke: red-stroke
    ))
    place(dx: 160pt, dy: 30pt, path(
      ..coords,
      stroke: red-stroke
    ))
    place(dx: 160pt, dy: 30pt, path(
      ..coords,
      stroke: stroke,
      tip: stealth, shorten: 70%
    ))
  })
}))

#content
