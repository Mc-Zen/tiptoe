#import "/src/tiptoe.typ": *
#set page(width: 2cm, height: 2cm, margin: 6pt)

#line(length: 100%, angle: 90deg, tip: stealth, toe: stealth)

#pagebreak()

#line(length: 100%, tip: stealth, toe: stealth)


#pagebreak()

// Full ratio
#line(
  start: (50%, 0%),
  end: (100%, 100% - 1em),
  length: 2cm,
  angle: 20deg,
  toe: stealth,
  tip: bar,
)

#pagebreak()

// Mixed coordinates
#line(
  start: (1cm, 0%),
  end: (100%, 100% - 10pt),
  length: 2cm,
  angle: 20deg,
  toe: stealth,
  tip: bar,
)
