#import "/src/tiptoe.typ": *
#set page(width: 2cm, height: 1.3cm, margin: 2pt)


#let test-curve = line.with(
  tip: stealth,
  start: (0pt, .2cm),
  end: (2cm - 4pt, .2cm)
)

#test-curve()

#pagebreak()

// Setting parameters on std.line
#{
  set std.line(stroke: green)
  test-curve()
  test-curve(stroke: 2pt)
}

#pagebreak()

// Overriding and folding (!) parameters
#{
  set std.line(stroke: 2pt)
  test-curve()
  test-curve(stroke: blue)
  test-curve(stroke: (dash: "dashed", thickness: 1pt))
}
