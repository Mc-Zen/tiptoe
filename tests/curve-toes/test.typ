#import "/src/tiptoe.typ": *
#set page(width: auto, height: auto, margin: 10pt)

#set table(
  stroke: none, 
  columns: (auto, 2cm), 
  rows: 20pt,
)

#set align(right)


// == Move + move

// #table(
//   [normal],
//   std.curve(
//     std.curve.move((20pt, 0pt)),
//     std.curve.move((30pt, 0pt), relative: true),
//     std.curve.line((30pt, 0pt), relative: true),
//     toe: stealth.with(stroke: red)
//   ),
// )
// #highlight[todo]

// #pagebreak()


== Move + line

#table(
  [normal],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.line((30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [`relative: true`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.line((10pt, 10pt), relative: true),
    toe: stealth.with(stroke: red)
  ),
  [`relative: true` in `set` rule],
  [
    #set std.curve.line(relative: true)
    #curve(
      std.curve.move((20pt, 0pt)),
      std.curve.line((10pt, 10pt)),
      toe: stealth.with(stroke: red)
    )
  ]
)

#pagebreak()


== Move + quad

#table(
  [Normal],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.quad((30pt, 0pt), (30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control: none`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.quad(none, (30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` ],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.quad((10pt, 0pt), (10pt, 10pt), relative: true),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` in `set` rule],
  [
    #set std.curve.line(relative: true)
    #curve(
      std.curve.move((20pt, 0pt)),
      std.curve.line((10pt, 10pt)),
      toe: stealth.with(stroke: red)
    )
  ]
)

#pagebreak()


== Move + cubic
#table(
  [Normal],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic((20pt, 20pt), (30pt, 0pt), (30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control-start: none` ],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic(none, (30pt, 0pt), (30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control-start: auto`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic(auto, (30pt, 0pt), (30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control-start: auto` and `control-end: none`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic(auto, none, (30pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` ],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic((0pt, 20pt), (10pt, 0pt), (10pt, 10pt), relative: true),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` and `control-start: none`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic(none, (10pt, 0pt), (10pt, 10pt), relative: true),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` and `control-start: auto`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic(auto, (10pt, 0pt), (10pt, 10pt), relative: true),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` and `control-start: none` and `control-end: none`],
  curve(
    std.curve.move((20pt, 0pt)),
    std.curve.cubic(none, none, (10pt, 10pt), relative: true),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` in `set` rule],
  [
    #set std.curve.line(relative: true)
    #curve(
      std.curve.move((20pt, 0pt)),
      std.curve.line((10pt, 10pt)),
      toe: stealth.with(stroke: red)
    )
  ]
)

#pagebreak()


== Line 

#table(
  [Normal],
  curve(
    std.curve.line((20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` in `set` rule],
  [
    #set std.curve.line(relative: true)
    #curve(
      std.curve.line((20pt, 10pt)),
      toe: stealth.with(stroke: red)
    )
  ]
)

#pagebreak()


== Quad

#table(
  [Normal],
  curve(
    std.curve.quad((10pt, 0pt), (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control: none`],
  curve(
    std.curve.quad(none, (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control: auto`],
  curve(
    std.curve.quad(auto, (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` in `set` rule],
  [
    #set std.curve.quad(relative: true)
    #curve(
      std.curve.quad((10pt, 0pt), (20pt, 10pt)),
      toe: stealth.with(stroke: red)
    )
  ],
)

#pagebreak()


== Cubic

#table(
  [Normal],
  curve(
    std.curve.cubic((0pt, 20pt), (10pt, 0pt), (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control-start: none`],
  curve(
    std.curve.cubic(none, (0pt, 20pt), (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control-start: auto`],
  curve(
    std.curve.cubic(auto, (0pt, 20pt), (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `control-start: none` and `control-end: none`],
  curve(
    std.curve.cubic(none, none, (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ),
  [With `relative: true` in `set` rule],
  [
    #set std.curve.cubic(relative: true)
    #curve(
      std.curve.cubic((0pt, 20pt), (10pt, 0pt), (20pt, 10pt)),
      toe: stealth.with(stroke: red)
    )
  ]
)