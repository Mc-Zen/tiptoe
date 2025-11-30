#import "/src/tiptoe.typ": *
#set page(width: 2cm, height: 1cm, margin: 2pt)


#let test-curve = arc.with(
  tip: stealth,
)

#test-curve()

#pagebreak()

// Setting parameters on std.curve
#{
  set std.curve(stroke: red, fill: gray)
  test-curve()
}

#pagebreak()

// Overriding and folding (!) parameters
#{
  set std.curve(stroke: green, fill: blue)
  test-curve(fill: gray, stroke: .5pt)
}


