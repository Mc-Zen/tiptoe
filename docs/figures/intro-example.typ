#import "template.typ": *
#show: template

#let content = figure[
  #line(tip: stealth, toe: stealth.with(rev: true))
  
  #box(width: 20pt, height: 20pt, path(
    tip: triangle, toe: bar,
    ((0pt, 0pt), (-10pt, 0pt)),
    ((20pt, 10pt), (0pt, -10pt)),
    (0pt, 20pt)
  ))
]

#content