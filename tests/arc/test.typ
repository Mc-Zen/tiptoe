#import "/src/tiptoe.typ" as tiptoe: *
#set page(width: auto, height: auto, margin: 10pt)


#set std.curve(stroke: black)

#box(height: 1.55cm, width: 1.1cm, 
  arc(origin: (0pt, 30pt), angle: -90deg, arc: 120deg, fill: red)
)

#pagebreak()

#box(height: 1.55cm, width: 1.7cm, 
  arc(origin: (15pt, 30pt), angle: -110deg, arc: 120deg, closed: "sector", fill: purple)
)

#pagebreak()

#box(height: 1.55cm, width: 2cm, 
  arc(origin: (35pt, 10pt), angle: 60deg, arc: 130deg, closed: "segment", fill: green)
)

#pagebreak()

#box(height: 1.55cm, width: 2.6cm, 
  arc(origin: (1.3cm, 20pt), angle: 60deg, arc: 300deg, width: 2cm, height: 1cm)
)

#pagebreak()

#box(height: 1.55cm, width: 2.6cm, 
  arc(origin: (1.3cm, 20pt), angle: 60deg, arc: 300deg, width: 2cm, height: 1cm, fill: yellow, closed: "sector")
)

#pagebreak()

#box(height: 1.55cm, width: 2.6cm, 
  arc(origin: (1.3cm, 20pt), angle: 60deg, arc: 300deg, width: 2cm, height: 1cm, fill: maroon, closed: "segment")
)