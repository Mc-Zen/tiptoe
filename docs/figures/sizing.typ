#import "template.typ": *
#show: template

#let content = figure(box(fill: none, width: 5cm, height: 3cm, {
  let (length, width) = (2cm, 1.5cm)
  
  place(horizon, 
    line(tip: stealth.with(length: length, width: width, stroke: foreground, fill: none), stroke: 6pt + gray, length: 3cm))
    // line(tip: straight.with(length: length, width: width, stroke: black), stroke: 6pt + gray, length: 3cm))
  let m = (
    stroke: .3pt + foreground, 
    tip: combine(bar, stealth),
    toe: combine(bar, stealth),
  )
  place(horizon, line(..m, start: (3.4cm, 0pt), angle: 90deg, length: width))
  place(horizon, dx: 3.6cm)[`width`]
  place(top, line(..m, start: (3cm-length, .6cm), length: length))
  place(dx: 1.5cm, dy: 0.1cm)[`length`]
  place(bottom, line(..m, start: (3cm-length, -.6cm), length: length*40%))
  place(bottom, dx: .97cm, dy: -0.1cm)[`inset`]
}))

#content