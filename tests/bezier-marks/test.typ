#import "/src/tiptoe.typ" as tiptoe: *
#import "/src/path-to-curve.typ": path-to-curve
#set page(width: auto, height: auto, margin: 10pt)


#let line = tiptoe.line.with(tip: tiptoe.stealth)
#let path = tiptoe.path.with(tip: tiptoe.stealth)

#line(stroke: yellow, tip: straight.with(stroke: orange))
#pagebreak()


#line(stroke: 10pt + yellow, length: 4cm, tip: straight.with(stroke: 3pt))
#pagebreak()


#set page(width: 3cm, height: 3cm)

#arc(
  origin: (1cm, 1cm),
  angle: 0deg,
  arc: -360deg,
  stroke: red + 1mm, radius: 1.2cm, 
  shorten: (start: 100%, end: 50%),
  tip: stealth,
  toe: bar.with(stroke: black),
)
#pagebreak()



#path(
  tip: stealth, toe: stealth,
  ((0pt, 0pt)),
  ((50pt, 50pt), (-20pt, 0pt), (0pt, 0pt)),
)
#pagebreak()
#path(
  tip: stealth, toe: stealth,
  ((0pt, 0pt), (20pt, -350pt), (0pt, 50pt)),
  ((50pt, 50pt), (-10pt, 0pt), (110pt, 110pt)),
)
#pagebreak()
#path(
  tip: stealth, toe: stealth,
  ((0pt, 0pt), (20pt, -350pt), (0pt, 0pt)),
  ((25pt, 25pt), (0pt, -20pt), (20pt, 0pt)),
  ((50pt, 50pt), (0pt, 0pt), (110pt, 110pt)),
)
#pagebreak()
#path(
  tip: stealth, toe: stealth,
  ((0pt, 0pt), (-20pt, 0pt)),
  ((25pt, 25pt), (0pt, 0pt), (0pt, 0pt)),
  ((50pt, 50pt),  (-20pt, 0pt)),
)

#pagebreak()

#set page(width: auto, height: auto)

#let compare(..coords) = {
  place(path(..coords))
  path-to-curve(..coords, stroke: red)
}

#compare(
  (0pt, 0pt),
  (10pt, 0pt),
  (20pt, 20pt)
)

#pagebreak()

#compare(
  // toe: none,
  // tip: none,
  ((0pt, 0pt), (-5pt, -5pt)),
  ((10pt, 0pt), (-10pt, 0pt)),
  ((20pt, 20pt), (5pt, -5pt)),
)
#pagebreak()

#compare(
  ((0pt, 0pt)),
  ((10pt, 0pt), (-10pt, 0pt)),
  ((20pt, 20pt)),
)
#pagebreak()

#compare(
  ((0pt, 0pt), (-5pt, -5pt)),
  ((10pt, 0pt),),
  ((20pt, 20pt), (5pt, -5pt)),
)
#pagebreak()

#compare(
  ((0pt, 0pt), (-5pt, -5pt)),
  ((10pt, 0pt), (0pt, 5pt), (0pt, -15pt)),
  ((20pt, 20pt), (5pt, -5pt)),
)
#pagebreak()

#compare(
  ((0pt, 0pt), (-20pt, 0pt)),
  ((50pt, 10pt), (-20pt, 0pt))
)
#pagebreak()

#compare(
  ((0pt, 0pt), (-20pt, 0pt), (20pt, 0pt)),
  ((50pt, 10pt), (-20pt, 0pt), (20pt, 0pt))
)

