#import "/src/tiptoe.typ" as tiptoe: *

#let dark = "dark" in sys.inputs
#let foreground = if dark { white } else { black }
#let background = if dark { black } else { white }

#let line = line.with(stroke: foreground)
#let path = path.with(stroke: foreground)
#let arc = arc.with(stroke: foreground)


#let template(
  body
) = {

  let stroke-color = gray
  if dark {
    stroke-color = gray.darken(30%)
  }

  set page(width: auto, height: auto, margin: 2pt, fill: none)
  set grid.vline(stroke: stroke-color)


  show figure: box.with(stroke: .5pt + stroke-color, radius: .5em, inset: 1em)

  set text(foreground, font: "Calibri", weight: 400)


  body
}

#let tline(..args) = box(
  height: 1cm, line(length: 1.3cm, stroke: 1.5pt +  foreground, ..args)
)

#let code-and-tip(code) = {
  let j = eval(code, scope: dictionary(tiptoe))
  (
    tline(tip: j, length: 1cm),
    raw(code, lang: "typc"),
    []
  )
}
