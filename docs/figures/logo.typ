#import "template.typ": *
#show: template


#let figure1 = {
  place(path(tip: round, toe: square.with(length: 700%, fill: none),
    (20pt, 0pt),
    (10pt, 30pt),
    (12pt, 45pt),
    (5pt, 60pt)
  ))
  place(path(tip: round, 
    (10pt, 30pt),
    (30pt, 40pt),
    (35pt, 55pt)
  ))
  place(path(
    (14pt, 18pt),
    (25pt, 25pt),
    (26pt, 18pt),
  ))
}

#let figure2 = {
  place(path(tip: stealth, toe: circle.with(length: 700%, fill: none),
    (25pt, 0pt),
    (10pt, 30pt),
    ((15pt, 45pt), (0pt, -8pt)),
    (12pt, 60pt)
  ))
  place(path(tip: stealth, 
    (10pt, 30pt),
    ((30pt, 40pt), (-4pt, -7pt)),
    (35pt, 55pt)
  ))
  place(dx: 2pt, path(
    (14pt, 18pt),
    (20pt, 24pt),
    (25pt, 15pt),
  ))
}

#let figure3 = {
  place(path(tip: square, toe: straight,
    ((22pt, 0pt), (1pt, -9pt)),
    ((17pt, 15pt), (1pt, -1pt)),
    ((10pt, 25pt), (1pt, -4pt)),
    (14pt, 45pt),
    (8pt, 57pt)
  ))
  place(path(tip: square, 
    (10pt, 25pt),
    // ((25pt, 38pt), (-4pt, -7pt)),
    ((25pt, 52pt), (2pt, -16pt))
  ))
  place(dx: 0pt, path(
    (14pt, 18pt),
    (20pt, 24pt),
    (25pt, 15pt),
  ))
}


#let figure4 = {
  place(path(tip: circle, toe: triangle.with(fill: none),
    (26pt, 0pt),
    ((17pt, 15pt), (1pt, -1pt)),
    ((10pt, 27pt), (1pt, -4pt)),
    (12pt, 45pt),
    (5pt, 60pt)
  ))
  place(path(tip: circle, 
    (10pt, 27pt),
    (26pt, 40pt),
    (25pt, 55pt)
  ))
  place(dx: 1pt, path(
    (14pt, 18pt),
    (23pt, 24pt),
    (25pt, 15pt),
  ))
}


#let logo = box(width: 260pt, height: 69pt, inset: 6pt, {
  set text(font: "Libertinus Serif")
  place(figure1)
  place(dx: 40pt, figure2)
  place(dx: 80pt, figure3)
  place(dx: 135pt, dy: 20pt, text(1.8em, weight: "black", style: "italic")[tiptoe])
  place(dx: 139pt, dy: 15pt, text(.4em)[_made with_])
  place(dx: 210pt, figure4) 
})

#logo