#import "template.typ": *
#show: template

#let annotate-h(length, content, dx: 0pt, dy: 0pt) = {
  let mark = combine(bar, stealth)
  place(
    dx: dx,
    dy: dy,
    tiptoe.line(length: length, tip: mark, toe: mark, stroke: .4pt),
  )
  place(dx: length / 2 + dx, dy: dy - .1em, place(center + bottom, content))
}

#let describe-mark(
  mark,
  name: "",
  len: auto,
  wid: 1cm,
  width: auto,
  length: auto,
  ..annotations,
) = {
  let stroke = blue.lighten(60%) + 7pt
  let fill = none


  let args = (:)
  if width != auto {
    args.width = width
    wid = width
  }
  if length != auto {
    args.length = length
    if len == auto { len = length }
  } else {
    // length = 4cm
  }

  if type(mark) != array { mark = (mark,) }

  box(inset: (x: 1em, y: .5em, bottom: 1em), box(
    width: len,
    height: wid,
    stroke: .1pt + luma(if dark { 60% } else { 0% }),
    {
      set text(.8em)
      mark
        .map(mark => {
          mark = mark(line: stroke, ..args)
          set std.line(stroke: stroke)
          set std.line(stroke: luma(if dark { 30% } else { 90% }))
          place(dy: 50%, std.line(length: len - mark.end))
          place(
            dx: len,
            dy: wid / 2,
            mark.mark,
          )
          place(dy: 50%, dx: len - mark.end, place(horizon, line(
            angle: 90deg,
            stroke: .4pt + red,
          )))
        })
        .join()
      annotations.pos().join()
      if length != auto {
        place(dy: -.1em, dx: len / 2, place(center + bottom)[`length`])
      }
      place(dy: wid / 2, dx: len + .1em, place(horizon + left, rotate(
        90deg,
        reflow: true,
        origin: left,
      )[`width`]))

      set text(gray, 1.2em)
      place(
        bottom + center,
        dy: 2pt,
        place(top + center, raw(name)),
      )
    },
  ))
}

#describe-mark(
  length: 3cm,
  width: 3cm,
  stealth.with(fill: none),
  annotate-h(40% * 4cm, dy: 50%)[`inset`],
  place(dx: 60%, dy: 17%, {
    place[`fill`]
    line(start: (1em, 1em), angle: 120deg, stroke: .5pt, length: 20pt)
  }),
  name: "stealth",
)
#describe-mark(
  length: 3cm,
  width: 3cm,
  round.with(fill: none),
  // annotate-h(40%*4cm, dy: 50%)[`inset`],
  place(dx: 60%, dy: 17%, {
    place[`fill`]
    line(start: (1em, 1em), angle: 120deg, stroke: .5pt, length: 20pt)
  }),
  name: "round",
)
#describe-mark(
  length: 3cm,
  width: 3cm,
  straight.with(rev: false),
  name: "straight",
)

#describe-mark(
  width: 3cm,
  len: 1.5cm,
  (barb.with(stroke: luma(85%)), barb.with(arc: 140deg)),
  place({
    set std.line(stroke: .5pt)
    place(std.line(start: (0pt, 50%), length: 1.4cm))
    place(std.line(start: (0pt, 50%), angle: -70deg, length: 1.4cm))
    place(arc(origin: (0pt, 50%), arc: -70deg, radius: 20pt, stroke: .5pt))
    place(dx: 3pt, dy: 1.15cm)[`arc`]
  }),
  name: "barb",
)
#describe-mark(
  width: 3cm,
  len: .8cm,
  (hooks.with(stroke: luma(85%)), hooks.with(arc: 140deg)),
  place({
    let y = 25% + 7pt / 4
    set std.line(stroke: .5pt)
    place(std.line(start: (0pt, y), angle: -50deg, length: .8cm))
    place(std.line(start: (0pt, y), angle: 90deg, length: .8cm))
    place(arc(
      origin: (0pt, y),
      angle: 90deg,
      arc: -140deg,
      radius: 20pt,
      stroke: .5pt,
    ))
    place(dx: 2pt, dy: .76cm)[`arc`]
  }),
  name: "hooks",
)
#describe-mark(
  width: 3cm,
  length: 1cm,
  bracket,
  name: "bracket",
)
#describe-mark(
  width: 3cm,
  len: .8cm,
  bar.with(align: end),
  name: "bar",
)
#describe-mark(
  wid: 3cm,
  length: 1.5cm,
  len: 3cm,
  rays.with(n: 6, align: end),
  name: "rays",
)

#describe-mark(
  width: 3cm,
  length: 2cm,
  square.with(fill: none, align: end),
  place(dx: 50%, dy: 50%, place(center + horizon)[`fill`]),
  name: "square",
)
#describe-mark(
  width: 3cm,
  length: 2cm,
  circle.with(fill: none, align: end),
  place(dx: 50%, dy: 50%, place(center + horizon)[`fill`]),
  name: "circle",
)
#describe-mark(
  width: 3cm,
  length: 2cm,
  diamond.with(fill: none, align: end),
  place(dx: 50%, dy: 50%, place(center + horizon)[`fill`]),
  name: "diamond",
)
#describe-mark(
  width: 3cm,
  len: 1.4cm,
  tikz,
  name: "tikz",
)
