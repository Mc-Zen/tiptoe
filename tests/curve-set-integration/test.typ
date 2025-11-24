#import "/src/tiptoe.typ": *
#set page(width: 2cm, height: 1cm, margin: 2pt)


#let test-curve = curve.with(
  tip: stealth, 
  std.curve.line((2cm - 4pt, 6pt)),
  std.curve.line((0pt, 1cm - 4pt)),
  std.curve.line((1cm - 2pt, 0pt)),
  std.curve.line((2cm - 4pt, 1cm - 4pt)),
)

#test-curve()

#pagebreak()

// Setting parameters on std.curve
#{
  set std.curve(stroke: red, fill: gray, fill-rule: "even-odd")
  test-curve()
}

#pagebreak()

// Overriding and folding (!) parameters
#{
  set std.curve(stroke: green, fill: blue, fill-rule: "even-odd")
  test-curve(fill: gray, stroke: 2pt, fill-rule: "non-zero")
}


