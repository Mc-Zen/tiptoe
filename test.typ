#import "/src/tiptoe.typ" as tiptoe: *



#let line = tiptoe.line.with(tip: tiptoe.stealth)
#let path = tiptoe.path.with(tip: tiptoe.stealth)

#line(tip: tiptoe.bar.with(stroke: red, width: 500%), stroke: (thickness: 5pt, dash: "dashed"))


// #path(
//   // toe: none,
//   (-10pt, 0pt),
//   ((10pt, 0pt), (-10pt, 0pt), (10pt, 0pt)),
//   ((20pt, 20pt)),
// )



#grid(
  columns:2,
  [
    #v(-1mm)
#line(tip: tiptoe.stealth, stroke: 1pt, length: 1cm) \
#line(tip: tiptoe.stealth, stroke: 2pt, length: 1cm) \
#line(tip: tiptoe.stealth, stroke: 3pt, length: 1cm) \

  ]
)

#let compare(..coords) = {
  place(path(..coords))
  hide(std.path(..coords, stroke: red))
}

#compare(
  (-10pt, 0pt),
  (10pt, 0pt),
  (20pt, 20pt)
)

#compare(
  // toe: none,
  // tip: none,
  ((-10pt, 0pt), (-5pt, -5pt)),
  ((10pt, 0pt), (-10pt, 0pt)),
  ((20pt, 20pt), (5pt, -5pt)),
)

#compare(
  ((-10pt, 0pt)),
  ((10pt, 0pt), (-10pt, 0pt)),
  ((20pt, 20pt)),
)

#compare(
  ((-10pt, 0pt), (-5pt, -5pt)),
  ((10pt, 0pt),),
  ((20pt, 20pt), (5pt, -5pt)),
)

#compare(
  ((-10pt, 0pt), (-5pt, -5pt)),
  ((10pt, 0pt), (0pt, 5pt), (0pt, -15pt)),
  ((20pt, 20pt), (5pt, -5pt)),
)

#compare(
  ((0pt, 0pt), (-20pt, 0pt)),
  ((50pt, 10pt), (-20pt, 0pt))
)
#compare(
  ((0pt, 0pt), (-20pt, 0pt), (20pt, 0pt)),
  ((50pt, 10pt), (-20pt, 0pt), (20pt, 0pt))
)




#line() \
#line(
  tip: tiptoe.combine(
    tiptoe.stealth,
    tiptoe.stealth,
  )
) \
#line(
  tip: tiptoe.combine(
    tiptoe.square.with(fill: blue),
    tiptoe.circle.with(fill: red),
  )
) \
#line(
  tip: tiptoe.combine(
    tiptoe.bar.with(width: 1000%),
    tiptoe.stealth
  ),
  toe: tiptoe.combine(
    tiptoe.bar.with(width: 1000%),
    tiptoe.stealth
  )
) \
#line(
  tip: tiptoe.rays.with(n: 4),
  toe: tiptoe.rays,
) \
