#import "marks.typ": *
#import "assert.typ": assert-mark
#import "path-to-curve.typ": path-to-curve


#let first-not-none-or-auto(..args) = args.pos().find(x => x != none and x != auto)

#let add(p, q) = p.zip(q).map(array.sum)
#let add-if-array(p, q) = if type(p) == array { add(p, q) } else { p }
#let invert(p) = p.map(x => -x)
#let sub(p, q) = p.zip(q).map(((a, b)) => a - b)
#let addorsub(p, q, f) = p.zip(q).map(((a, b)) => a + f*b)

#let mirror(control, origin) = add(origin, sub(origin, control))


#let extract-bezier-polygon(vertex1, vertex2, rev: false) = {
  let polygon = ()
  if type(vertex1.at(0)) == array {
    let v = vertex1.at(0)
    if vertex1.len() == 1 { polygon.push(v) }
    else if vertex1.len() == 2 {
      polygon += (v, sub(v, vertex1.at(1))).dedup()
    } else if vertex1.len() == 3 {
      polygon += (v, add(v, vertex1.at(2))).dedup()
    }
  } else {
    polygon.push(vertex1)
  }
  if type(vertex2.at(0)) == array {
    let v = vertex2.at(0)
    if vertex2.len() == 1 { polygon.push(v) }
    else {
      polygon += (add(v, vertex2.at(1)), v).dedup()
    } 
  } else {
    polygon.push(vertex2)
  }
  
  return polygon
}

// When encountering a final curve element with an `auto` control,
// we can use this function to compute this control based on the 
// previous curve element. 
#let get-prev-mirrored-control(points) = {
  let p = points.at(-2, default: std.curve.move((0pt, 0pt)))
  if p.func() == std.curve.close { p = std.curve.move((0pt, 0pt)) }
  
  if p.func() == std.curve.move { p.start }
  else if p.func() == std.curve.line { p.end }
  else if p.func() == std.curve.quad { 
    if p.control == none {p.end}
    else { mirror(p.control, p.end) }
  }
  else if p.func() == std.curve.cubic { 
    if p.control-end == none {p.end}
    else { mirror(p.control-end, p.end) }
  }
}

#let is-relative(segment) = {
  if segment.has("relative") { return segment.relative }
  return segment.func().relative
}



#let curve-to-absolute-polygon(segments) = {
  let base = (0pt, 0pt)
  let index-last-absolute-segment = -1

  for i in range(1, segments.len() + 1) {
    let index = segments.len() - i
    let segment = segments.at(index)

    if segment.func() == std.curve.move {
      index-last-absolute-segment = index
      base = segment.start
      break
    } else if not is-relative(segment) {
      index-last-absolute-segment = index
      base = segment.end
      break
    }
  }
  let polygon = (base, )
  
  for (i, segment) in segments.enumerate().slice(index-last-absolute-segment + 1) {
    if segment.func() == std.curve.line {
      base = add(base, segment.end)
      polygon.push(base)
    } else if segment.func() == std.curve.quad {
      if i == segments.len() - 1 {
        polygon.push(add(base, segment.control))
      }
      base = add(base, segment.end)
      polygon.push(base)
    } else if segment.func() == std.curve.cubic {
      if i == segments.len() - 1 {
        polygon.push(add(base, segment.control-start))
        polygon.push(add(base, segment.control-end))
      }
      base = add(base, segment.end)
      polygon.push(base)
    }
    
  }
  polygon
}


#assert.eq(curve-to-absolute-polygon((
    std.curve.move((10pt, 10pt)),
    std.curve.line((10pt, 10pt), relative: true),
  )),
  ((10pt, 10pt), (20pt, 20pt))
)
#assert.eq(curve-to-absolute-polygon((
    std.curve.move((10pt, 10pt)),
    std.curve.line((0pt, 10pt), relative: true),
    std.curve.line((10pt, 0pt), relative: true),
  )),
  ((10pt, 10pt), (10pt, 20pt), (20pt, 20pt))
)
#assert.eq(curve-to-absolute-polygon((
    std.curve.move((10pt, 10pt)),
    std.curve.quad((0pt, 10pt), (10pt, 10pt), relative: true),
    std.curve.line((10pt, 0pt), relative: true),
  )),
  ((10pt, 10pt), (20pt, 20pt), (30pt, 20pt))
)

#let resolve-relative(curve-elements) = {
  let base = (0pt, 0pt)
  for curve-element in curve-elements.rev() {
    if curve-element.func() == std.curve.move {
      base = add(base, curve-element.start)
      break
    } else {
      base = add(base, curve-element.end)
      if not is-relative(curve-element) {
        break
      }
    }
  }
  let prev
  if curve-elements.last().func() == std.curve.move {
    prev = sub(base, curve-element.last().start)
  } else {
    prev = sub(base, curve-elements.last().end)
  }
  (prev, base)
}


#assert.eq(resolve-relative((
    std.curve.move((10pt, 10pt)),
    std.curve.line((10pt, 10pt), relative: true),
  )),
  ((10pt, 10pt), (20pt, 20pt))
)
#assert.eq(resolve-relative((
    std.curve.move((10pt, 10pt)),
    std.curve.line((0pt, 10pt), relative: true),
    std.curve.line((10pt, 0pt), relative: true),
  )),
  ((10pt, 20pt), (20pt, 20pt))
)
#assert.eq(resolve-relative((
    std.curve.move((10pt, 10pt)),
    std.curve.line((0pt, 10pt), relative: true),
    std.curve.line((0pt, 10pt), relative: true),
    std.curve.line((0pt, 10pt), relative: false),
    std.curve.line((10pt, 0pt), relative: true),
  )),
  ((0pt, 10pt), (10pt, 10pt))
)

#assert.eq(resolve-relative((
    std.curve.move((10pt, 10pt)),
    std.curve.line((10pt, 10pt), relative: true),
  )),
  ((10pt, 10pt), (20pt, 20pt))
)


#let treat-tip(mark, points, inner, shorten: 100%) = {
  let final-segment = points.last()
  let args = (:)
  let end = final-segment.end
  
  if is-relative(final-segment) {
    if final-segment.has("relative") {
      args.relative = true
    }
    (inner, end) = resolve-relative(points)

    (.., inner, end) = curve-to-absolute-polygon(points)

  }

  let dx = (end.at(0) - inner.at(0)).length.to-absolute() / 1pt
  let dy = (end.at(1) - inner.at(1)).length.to-absolute() / 1pt
  let angle = calc.atan2(dx, dy)
  let mark-content = place(
    dx: end.at(0), dy: end.at(1), 
    rotate(angle, mark.mark)
  )
  end.at(0) -= calc.cos(angle) * mark.end * shorten
  end.at(1) -= calc.sin(angle) * mark.end * shorten
  (mark-content, end, args)
}
#let treat-toe(mark, start, inner, shorten: 100%) = {

  let dx = (start.at(0) - inner.at(0)).length.to-absolute() / 1pt
  let dy = (start.at(1) - inner.at(1)).length.to-absolute() / 1pt
  let angle = calc.atan2(dx, dy)
  let mark-content = place(
    dx: start.at(0), dy: start.at(1), 
    rotate(angle, mark.mark)
  )
  start.at(0) -= calc.cos(angle) * mark.end * shorten
  start.at(1) -= calc.sin(angle) * mark.end * shorten
  (mark-content, start)
}

#let curve(
  ..segments, 
  fill: none,
  fill-rule: auto,
  stroke: 1pt,
  tip: none,
  toe: none,
  shorten: 100%,
) = {
  if segments.named().len() != 0 {
    assert(false, message: "Unexpected named argument \"" + segments.named().keys().first() + "\"")
  }

  stroke = std.stroke(stroke)

  assert(
    type(shorten) in (ratio, dictionary), 
    message: "Expected ratio or dictionary for parameter `shorten`, found " + str(type(shorten))
  )
  if type(shorten) == ratio {
    shorten = (start: shorten, end: shorten)
  } else if type(shorten) == dictionary {
    assert(
      shorten.keys().sorted() == ("end", "start"), 
      message: "Unexpected key, valid keys are \"start\" and \"end\""
    )
  }


  context {
    let segments = segments.pos()
    let original-points = segments
    
    let treat-mark(mark, i1, i2, pos: start, shorten: 100%) = {
      mark = mark(line: stroke) 
      
      let polygon = extract-bezier-polygon(segments.at(i1), segments.at(i2))
      if pos == end { polygon = polygon.rev() }
      let inner = polygon.at(1)
      let outer = polygon.at(0)
      
      let dx = (outer.at(0) - inner.at(0)).to-absolute() / 1pt
      let dy = (outer.at(1) - inner.at(1)).to-absolute() / 1pt
      let angle = calc.atan2(dx, dy)
      
      let mark-content = place(
        dx: outer.at(0), dy: outer.at(1), 
        rotate(angle, mark.mark)
      )
      outer.at(0) -= calc.cos(angle) * mark.end * shorten
      outer.at(1) -= calc.sin(angle) * mark.end * shorten
      return (mark-content, outer)
    }
    
    let marks


    if toe != none and segments.len() >= 1 { 

      assert-mark(toe, kind: "toe")

      let first-segment = segments.first() 
      
      if first-segment.func() == std.curve.move and segments.len() >= 2 {

        let start = first-segment.start 
        let second-segment = segments.at(1)

        let relative = is-relative(second-segment)

        let to = {
          let se = second-segment
          if se.func() == std.curve.line {
            if relative {
              segments.at(1) = std.curve.line(add(start, se.end), relative: false)
            }
            se.end
          } else if se.func() == std.curve.quad {
            if relative {
              segments.at(1) = std.curve.quad(add-if-array(se.control, start), add(se.end, start), relative: false)
            }
            first-not-none-or-auto(se.control, se.end)
          } else if se.func() == std.curve.cubic {
            if relative {
              segments.at(1) = std.curve.cubic(add-if-array(se.control-start, start), add-if-array(se.control-end, start), add(se.end, start), relative: false)
            }
            first-not-none-or-auto(se.control-start, se.control-end, se.end)
          }
        }
        
        if relative {
          to = add(start, to)
        }
        
        if to != none {
          let (mark, start) = treat-toe(
            toe(line: stroke), 
            start, to, 
            shorten: shorten.start
          )
          marks += mark
          segments.first() = std.curve.move(start)
        }

      } else if first-segment.func() == std.curve.line {

        let (mark, start) = treat-toe(
          toe(line: stroke), 
          (0pt, 0pt), first-segment.end, 
          shorten: shorten.start
        )
        marks += mark
        segments.first() = std.curve.line(first-segment.end, relative: false)
        segments.insert(0, std.curve.move(start))

      } else if first-segment.func() == std.curve.quad {
        
        let inner = first-segment.control
        if inner in (none, auto) { inner = first-segment.end }
        let (mark, start) = treat-toe(
          toe(line: stroke), 
          (0pt, 0pt), inner, 
          shorten: shorten.start
        )
        marks += mark
        segments.first() = std.curve.quad(
          first-segment.control, 
          first-segment.end, 
          relative: false
        )
        segments.insert(0, std.curve.move(start))

      } else if first-segment.func() == std.curve.cubic {
        
        let inner = first-segment.control-start
        if inner in (none, auto) { inner = first-segment.control-end }
        if inner == none { inner = first-segment.end }
        let (mark, start) = treat-toe(
          toe(line: stroke), 
          (0pt, 0pt), inner, 
          shorten: shorten.start
        )
        marks += mark
        segments.first() = std.curve.cubic(
          first-segment.control-start,
          first-segment.control-end, 
          first-segment.end, 
          relative: false
        )
        segments.insert(0, std.curve.move(start))

      }

    }
    


    if tip != none and segments.len() >= 1 { 

      assert-mark(tip, kind: "tip")

      let final-segment = segments.last()
      let inner = {
        let p = segments.at(-2, default: std.curve.move((0pt, 0pt)))
        if p.func() == std.curve.close { p = std.curve.move((0pt, 0pt)) }
        if p.func() == std.curve.move { p.start }
        else { p.end }
      }

      if final-segment.func() == std.curve.close {
        assert(false, message: "Tips are not supported on the `curve.close` element")
      } else if final-segment.func() == std.curve.line {

        let (mark, end, args) = treat-tip(
          tip(line: stroke), 
          segments, inner, 
          shorten: shorten.end
        )
        marks += mark
        segments.last() = std.curve.line(end, relative: false)

      } else if final-segment.func() == std.curve.quad {
        
        if final-segment.control != none {
          if final-segment.control == auto {
            inner = get-prev-mirrored-control(segments)
          } else {
            inner = final-segment.control
          }
        }

        let (mark, end, args) = treat-tip(
          tip(line: stroke), 
          segments, inner, 
          shorten: shorten.end
        )

        marks += mark
        segments.last() = std.curve.quad(final-segment.control, end)

      } else if final-segment.func() == std.curve.cubic {

        if final-segment.control-end != none {
          inner = final-segment.control-end
        } else if final-segment.control-start != none {
          inner = final-segment.control-start
        }

        let (mark, end, args) = treat-tip(
          tip(line: stroke), 
          segments, inner, 
          shorten: shorten.end
        )

        marks += mark
        segments.last() = std.curve.cubic(final-segment.control-start, final-segment.control-end, end)

      }
    }
    
    let fill-rule = fill-rule
    if fill-rule == auto {
      fill-rule = std.curve.fill-rule
    }
    
    place(std.curve(
      ..segments, 
      stroke: stroke, 
      fill: fill, 
      fill-rule: fill-rule
    )) + marks
  }
}

== Move
#curve(
  std.curve.move((20pt, 20pt)),
  tip: stealth
) \


== Line
- Normal
#curve(
  std.curve.line((20pt, 10pt)),
  tip: stealth
) \
- Move + line
#curve(
  std.curve.move((40pt, 0pt)),
  std.curve.line((20pt, 10pt)),
  tip: stealth
) \
- Line + Line
#curve(
  std.curve.line((20pt, 0pt)),
  std.curve.line((20pt, 10pt)),
  tip: stealth
) \
- Quad + Line
#curve(
  std.curve.quad((0pt, 10pt), (20pt, 0pt)),
  std.curve.line((20pt, 10pt)),
  tip: stealth
) \


== Quad 
- Normal
#curve(
  std.curve.quad((10pt, 0pt), (20pt, 10pt)),
  tip: stealth
) \
- With `control: none`
#curve(
  std.curve.quad(none, (20pt, 10pt)),
  tip: stealth
) \
- With `control: none` and `curve.move` before
#curve(
  std.curve.move((10pt, 0pt)),
  std.curve.quad(none, (30pt, 10pt)),
  tip: stealth
) \
- With `control: none` and `curve.close` before
#curve(
  std.curve.close(),
  std.curve.quad(none, (20pt, 10pt)),
  tip: stealth
) \
- With `control: none` and `curve.line` before
#curve(
  std.curve.line((10pt, 0pt)),
  std.curve.quad(none, (30pt, 10pt)),
  tip: stealth
) \
- With `control: none` and `curve.quad` before
#curve(
  std.curve.quad(none, (10pt, 0pt)),
  std.curve.quad(none, (30pt, 10pt)),
  tip: stealth
) \
- With `control: auto` and nothing before
#curve(
  std.curve.quad(auto, (20pt, 10pt)),
  tip: stealth, 
) \
- With `control: auto` and `curve.line` before
#curve(
  std.curve.line((10pt, 0pt)),
  std.curve.quad(auto, (20pt, 10pt)),
  tip: stealth, 
) \
- With `control: auto` and `curve.quad` before
#curve(
  std.curve.quad((10pt, 0pt), (20pt, 0pt)),
  std.curve.quad(auto, (20pt, 10pt)),
  tip: stealth, 
) \
- With `control: auto` and `curve.quad` before but with `control: none`
#curve(
  std.curve.quad(none, (20pt, 0pt)),
  std.curve.quad(auto, (20pt, 10pt)),
  tip: stealth, 
) \
- With `control: auto` and `curve.cubic` before
#curve(
  std.curve.cubic(none, (10pt, 0pt), (20pt, 0pt)),
  std.curve.quad(auto, (20pt, 10pt)),
  tip: stealth, 
) \
- With `control: auto` and `curve.cubic` before but with `control: none`
#curve(
  std.curve.cubic(none, none, (20pt, 0pt)),
  std.curve.quad(auto, (20pt, 10pt)),
  tip: stealth, 
) \

== Cubic 
- Normal
#curve(
  std.curve.cubic(none, (10pt, 0pt), (20pt, 10pt)),
  tip: stealth
) \
- With `control-end: none`
#curve(
  std.curve.cubic((10pt, 0pt), none, (20pt, 10pt)),
  tip: stealth
) \
- With `control-start: none` and `control-end: none`
#curve(
  std.curve.cubic(none, none, (20pt, 10pt)),
  tip: stealth
) \
- With `control-start: none` and `control-end: none` and `curve.move` before
#curve(
  std.curve.move((40pt, 0pt)),
  std.curve.cubic(none, none, (20pt, 10pt)),
  tip: stealth
) \
- With `control-start: none` and `control-end: none` and `curve.line` before
#curve(
  std.curve.line((40pt, 0pt)),
  std.curve.cubic(none, none, (20pt, 10pt)),
  tip: stealth
) \


= Relative
not quite done yet
== line
// #set std.curve.line(relative: true)
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.line((10pt, 10pt), relative: true),
  std.curve.line((20pt, 20pt), relative: true),
  tip: stealth
) \
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.line((10pt, 10pt)),
  std.curve.line((20pt, 20pt), relative: true),
  tip: stealth
) \
#curve(
  std.curve.move((40pt, 0pt)),
  std.curve.line((20pt, 20pt), relative: true),
  tip: stealth
) \


#curve(
  std.curve.quad((0pt, 10pt), (20pt, 0pt)),
  std.curve.line((10pt, 20pt), relative: true),
  tip: stealth
) \

#curve(
  std.curve.quad((0pt, 10pt), (40pt, 0pt)),
  // std.curve.quad(auto, (10pt, 20pt), relative: true),
  tip: stealth
) \









#pagebreak()
= Toes

sorted by the types of the first segments

== Move

=== Move + move
#std.curve(
  std.curve.move((20pt, 0pt)),
  std.curve.move((30pt, 0pt), relative: true),
  std.curve.line((30pt, 0pt), relative: true),
  // toe: stealth.with(stroke: red)
) \
#highlight[todo]
=== Move + line
- normal
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.line((30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- `relative: true`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.line((10pt, 10pt), relative: true),
  toe: stealth.with(stroke: red)
) \
- `relative: true` in `set` rule
#[
  #set std.curve.line(relative: true)
  #curve(
    std.curve.move((20pt, 0pt)),
    std.curve.line((10pt, 10pt)),
    toe: stealth.with(stroke: red)
  ) \ 
]

=== Move + quad
- Normal
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.quad((30pt, 0pt), (30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control: none`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.quad(none, (30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` 
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.quad((10pt, 0pt), (10pt, 10pt), relative: true),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` in `set` rule
#[
  #set std.curve.line(relative: true)
  #curve(
    std.curve.move((20pt, 0pt)),
    std.curve.line((10pt, 10pt)),
    toe: stealth.with(stroke: red)
  ) \ 
]


=== Move + cubic
- Normal
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic((20pt, 20pt), (30pt, 0pt), (30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control-start: none` 
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic(none, (30pt, 0pt), (30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control-start: auto`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic(auto, (30pt, 0pt), (30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control-start: auto` and `control-end: none`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic(auto, none, (30pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` 
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic((0pt, 20pt), (10pt, 0pt), (10pt, 10pt), relative: true),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` and `control-start: none`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic(none, (10pt, 0pt), (10pt, 10pt), relative: true),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` and `control-start: auto`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic(auto, (10pt, 0pt), (10pt, 10pt), relative: true),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` and `control-start: none` and `control-end: none`
#curve(
  std.curve.move((20pt, 0pt)),
  std.curve.cubic(none, none, (10pt, 10pt), relative: true),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` in `set` rule
#[
  #set std.curve.line(relative: true)
  #curve(
    std.curve.move((20pt, 0pt)),
    std.curve.line((10pt, 10pt)),
    toe: stealth.with(stroke: red)
  ) \ 
]


== Line 
- Normal
#curve(
  std.curve.line((20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` in `set` rule
#[
  #set std.curve.line(relative: true)
  #curve(
    std.curve.line((20pt, 10pt)),
    toe: stealth.with(stroke: red)
  ) \
]


== Quad

- Normal
#curve(
  std.curve.quad((10pt, 0pt), (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control: none`
#curve(
  std.curve.quad(none, (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control: auto`
#curve(
  std.curve.quad(auto, (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` in `set` rule
#[
  #set std.curve.quad(relative: true)
  #curve(
    std.curve.quad((10pt, 0pt), (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  )
] \


== Cubic

- Normal
#curve(
  std.curve.cubic((0pt, 20pt), (10pt, 0pt), (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control-start: none`
#curve(
  std.curve.cubic(none, (0pt, 20pt), (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control-start: auto`
#curve(
  std.curve.cubic(auto, (0pt, 20pt), (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `control-start: none` and `control-end: none`
#curve(
  std.curve.cubic(none, none, (20pt, 10pt)),
  toe: stealth.with(stroke: red)
) \
- With `relative: true` in `set` rule
#[
  #set std.curve.cubic(relative: true)
  #curve(
    std.curve.cubic((0pt, 20pt), (10pt, 0pt), (20pt, 10pt)),
    toe: stealth.with(stroke: red)
  )
]