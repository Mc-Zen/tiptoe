#import "/src/tiptoe.typ": *
#set page(width: auto, height: auto, margin: 10pt)

#set table(
  stroke: none,
  columns: (auto, 2cm),
  rows: 20pt,
)

#set align(right)


== Move

#table(
  [Normal],
  curve(
    std.curve.move((20pt, 20pt)),
    tip: stealth,
  ),
)

#pagebreak()


== Line

#table(
  [Normal],
  curve(
    std.curve.line((20pt, 10pt)),
    tip: stealth,
  ),
  [Move + line],
  curve(
    std.curve.move((40pt, 0pt)),
    std.curve.line((20pt, 10pt)),
    tip: stealth,
  ),
  [Line + Line],
  curve(
    std.curve.line((20pt, 0pt)),
    std.curve.line((20pt, 10pt)),
    tip: stealth,
  ),
  [Quad + Line],
  curve(
    std.curve.quad((0pt, 10pt), (20pt, 0pt)),
    std.curve.line((20pt, 10pt)),
    tip: stealth,
  ),
)

#pagebreak()


== Quad

#table(
  [Normal],
  curve(
    std.curve.quad((10pt, 0pt), (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: none`],
  curve(
    std.curve.quad(none, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: none` and `curve.move` before],
  curve(
    std.curve.move((10pt, 0pt)),
    std.curve.quad(none, (30pt, 10pt)),
    tip: stealth,
  ),
  [With `control: none` and `curve.close` before],
  curve(
    std.curve.close(),
    std.curve.quad(none, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: none` and `curve.line` before],
  curve(
    std.curve.line((10pt, 0pt)),
    std.curve.quad(none, (30pt, 10pt)),
    tip: stealth,
  ),
  [With `control: none` and `curve.quad` before],
  curve(
    std.curve.quad(none, (10pt, 0pt)),
    std.curve.quad(none, (30pt, 10pt)),
    tip: stealth,
  ),
  [With `control: auto` and nothing before],
  curve(
    std.curve.quad(auto, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: auto` and `curve.line` before],
  curve(
    std.curve.line((10pt, 0pt)),
    std.curve.quad(auto, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: auto` and `curve.quad` before],
  curve(
    std.curve.quad((10pt, 0pt), (20pt, 0pt)),
    std.curve.quad(auto, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: auto` and `curve.quad` before but with `control: none`],
  curve(
    std.curve.quad(none, (20pt, 0pt)),
    std.curve.quad(auto, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: auto` and `curve.cubic` before],
  curve(
    std.curve.cubic(none, (10pt, 0pt), (20pt, 0pt)),
    std.curve.quad(auto, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control: auto` and `curve.cubic` before but with `control: none`],
  curve(
    std.curve.cubic(none, none, (20pt, 0pt)),
    std.curve.quad(auto, (20pt, 10pt)),
    tip: stealth,
  ),
)


#pagebreak()


== Cubic

#table(
  [Normal],
  curve(
    std.curve.cubic(none, (10pt, 0pt), (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control-end: none`],
  curve(
    std.curve.cubic((10pt, 0pt), none, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control-start: none` and `control-end: none`],
  curve(
    std.curve.cubic(none, none, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control-start: none` and `control-end: none` and `curve.move` before],
  curve(
    std.curve.move((40pt, 0pt)),
    std.curve.cubic(none, none, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control-start: none` and `control-end: none` and `curve.line` before],
  curve(
    std.curve.line((40pt, 0pt)),
    std.curve.cubic(none, none, (20pt, 10pt)),
    tip: stealth,
  ),
  [With `control-start: auto` and `control-end: none` and `curve.line` before],
  curve(
    tip: triangle,
    std.curve.cubic(none, (0pt, 10pt), (20pt, 0pt)),
    std.curve.cubic(auto, none, (20pt, 10pt)),
  ),
)


// = Relative
// not quite done yet
// == line
// // #set std.curve.line(relative: true)
// #curve(
//   std.curve.move((20pt, 0pt)),
//   std.curve.line((10pt, 10pt), relative: true),
//   std.curve.line((20pt, 20pt), relative: true),
//   tip: stealth
// ),
// #curve(
//   std.curve.move((20pt, 0pt)),
//   std.curve.line((10pt, 10pt)),
//   std.curve.line((20pt, 20pt), relative: true),
//   tip: stealth
// ),
// #curve(
//   std.curve.move((40pt, 0pt)),
//   std.curve.line((20pt, 20pt), relative: true),
//   tip: stealth
// ),


// #curve(
//   std.curve.quad((0pt, 10pt), (20pt, 0pt)),
//   std.curve.line((10pt, 20pt), relative: true),
//   tip: stealth
// ),

// #curve(
//   std.curve.quad((0pt, 10pt), (40pt, 0pt)),
//   // std.curve.quad(auto, (10pt, 20pt), relative: true),
//   tip: stealth
// ),







