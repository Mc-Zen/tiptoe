#import "template.typ": *
#show: template



#let content = figure(grid(
  columns: (auto, auto ,)*2, align: horizon + right,
  row-gutter: 3pt,
  column-gutter: (1em, 3em, 1em),
  [`stealth`], tline(tip: stealth),
  [`stealth``.with(rev: true)`], tline(tip: stealth.with(rev: true)),
  [`triangle`], tline(tip: triangle),
  [`triangle``.with(rev: true)`], tline(tip: triangle.with(rev: true)),
  [`straight`], tline(tip: straight),
  [`straight``.with(rev: true)`], tline(tip: straight.with(rev: true)),
  [`round`], tline(tip: round),
  [`round``.with(rev: true)`], tline(tip: round.with(rev: true)),
  [`barb`], tline(tip: barb),
  [`barb.with(rev: true)`], tline(tip: barb.with(rev: true)),
  [`hooks`], tline(tip: hooks),
  [`hooks.with(rev: true)`], tline(tip: hooks.with(rev: true)),
  [`square`], tline(tip: square),
  [`diamond`], tline(tip: diamond),
  [`circle`], tline(tip: circle),
  [`bar`], tline(tip: bar),
  [`rays.with(n: 3)`], tline(tip: rays.with(n: 3)),
  [`rays`], tline(tip: rays),
  [`rays.with(n: 5)`], tline(tip: rays.with(n: 5)),
  [`rays.with(n: 6)`], tline(tip: rays.with(n: 6)),
  [`bracket`], tline(tip: bracket),
  [`bracket.with(rev: true)`], tline(tip: bracket.with(rev: true)),
  [`tikz`], tline(tip: tikz),
))

#content
