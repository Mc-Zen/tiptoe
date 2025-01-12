<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/logo.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/logo-dark.svg">
    <img alt="Logo" src="docs/figures/out/logo.svg">
  </picture>
</p>

_Arrows for [Typst][typst] paths and other stories._

[![Typst Package](https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2FMc-Zen%2Ftiptoe%2Fv0.2.0%2Ftypst.toml&query=%24.package.version&prefix=v&logo=typst&label=package&color=239DAD)](https://typst.app/universe/package/tiptoe)
[![Test Status](https://github.com/Mc-Zen/tiptoe/actions/workflows/run_tests.yml/badge.svg)](https://github.com/Mc-Zen/tiptoe/actions/workflows/run_tests.yml)
[![MIT License](https://img.shields.io/badge/license-MIT-blue)](https://github.com/Mc-Zen/tiptoe/blob/main/LICENSE)

---

*Tiptoe* adds configurable arrow tips (and toes) to the functions `line()` and `path()`. Moreover, it adds the geometric primitive `arc()`. 

- [Tiptoe vs. Fletcher](#tiptoe-vs-fletcher)
- [Available marks](#available-marks)
- [Mark sizing and styling](#mark-sizing-and-styling)
- [Mark alignment](#mark-alignment)
- [Path shortening](#path-shortening)
- [Combining marks](#combining-marks)
- [Defining custom marks](#defining-custom-marks)
- [Arc](#arc)
- [Difference between built in and tiptoe path](#difference-between-built-in-and-tiptoe-path)


The functions `tiptoe.line()` and `tiptoe.path()` act as a drop-in replacement (except that [they are placed by default](#difference-between-built-in-and-tiptoe-path)) for the built-in counterparts − but they are enhanced by additional `tip` and `toe` (you have read the title, what did you expect??) arguments. 

Let us consider a simple example to start off. 
```typ
#import "@preview/tiptoe:0.2.0": *

#line(tip: stealth, toe: stealth.with(rev: true))
#path(
  tip: triangle, toe: bar,
  ((0pt, 0pt), (-10pt, 0pt)),
  ((20pt, 10pt), (0pt, -10pt)),
  (0pt, 20pt)
)
```
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/intro-example.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/intro-example-dark.svg">
    <img alt="Basic introductory example" src="docs/figures/out/intro-example.svg">
  </picture>
</p>



## Tiptoe vs. [Fletcher][fletcher]

_Before going into the details:_ There exists another awesome package that provides great support for arrows and marks: [Fletcher][fletcher] by [Jollywatt][jollywatt]. If you wonder which package to use, the decision is easy because their use-cases are almost complementary. 
- Fletcher works with (and needs) [CeTZ][cetz] while
- Tiptoe does not need (and does not really work with) CeTZ. 

So, if you want to create CeTZ graphics − use Fletcher! If you don't want to use CeTZ − maybe because you just need a single arrow, can't use a canvas, or develop a package that provides graphics utilities − stay here 😉. 

Also note, that the tip sizing and configuration mechanism works quite differently. 


## Available marks

Tiptoe comes with a collection of predefined marks, listed below. In [Defining custom marks](#defining-custom-marks), you can learn how to define your own marks. 
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/marks.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/marks-dark.svg">
    <img alt="Available predefined marks" src="docs/figures/out/marks.svg">
  </picture>
</p>


## Mark sizing and styling

All predefined marks can be configured through `.with()` calls. Some options (like the `inset` of a stealth arrow) are mark-specific. 

*Be Typst!* If you use a configured mark more than once, define an alias for it. Typst makes it incredibly easy to define variables: 
```typ
#let my-mark = stealth.with(rev: true, inset: 20%)
#line(tip: my-mark)
```

### Sizing

The size of most arrows is primarily defined by their length and secondarily by their width (exceptions are `bar`, `barb`, `hooks`, and `tikz` which only have a width). Both width and length can be set using
- a `length` value, such as `10pt`, 
- or a ratio which is measured relative to the thickness of the line (e.g., `500%` corresponds to 5 times the line thickness),
- or a combination of both, e.g., `3pt + 450%` (this is btw. the default for the `stealth` mark). 
This makes it possible to fine-tune the sizing behavior of a mark. By default (`width: auto`), for most marks the width is defined in terms of the length via some predefined ratio. 


With the predefined marks, the length/width encompasses the *full* length/width of the mark, independent of the stroke thickness that is used. This is demonstrated below, where the fill is removed through `stealth.with(fill: none)`. 

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/sizing.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/sizing-dark.svg">
    <img alt="Arrow sizing" src="docs/figures/out/sizing.svg">
  </picture>
</p>

### Colors!

Usually, a mark inherits color and stroke thickness (but not other stroke attributes like `join` or `cap`) from the line that the mark is attached to. In order to override the color, the thickness or both, all marks feature a `stroke` parameter. Additionally, all solid marks feature a `fill` parameter that defaults (when set to `auto`) to the stroke color. 

Below are some examples for mark styling. 

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/styling.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/styling-dark.svg">
    <img alt="Examples for styling marks" src="docs/figures/out/styling.svg">
  </picture>
</p>

## More styling 

Apart from `length`, `width`, `fill`, and `stroke`, many marks possess additional styling parameters, such as 
- the `inset` for the arrows `stealth` and `round`,
- an arc angle parameter for the marks `barb` and `hooks`,

- and of course the `rev` parameter that allows for reversing all marks where this makes sense. 

The figure below shows the additional parameters that each mark supports. The red line indicates how much the underlying path is shortened (see [Path shortening](#path-shortening)). 

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/mark-parameters.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/mark-parameters-dark.svg">
    <img alt="Parameters of the predefined marks" src="docs/figures/out/mark-parameters.svg">
  </picture>
</p>



## Mark alignment

Most marks are aligned such that they point _right onto the end_ (or start) of the path. However, for some marks it is more desirable to have them _centered_ at the end (or start). This is for example the case for the `square` and `circle` marker. All markers that are by default centered on the path end have an `align` parameter that can be set to `center` or `end` to configure this behavior. 

The mark alignment for the built-in marks is summarized in the table below. 

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/alignment.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/alignment-dark.svg">
    <img alt="Alignment of marks" src="docs/figures/out/alignment.svg">
  </picture>
</p>



## Path shortening

In order to make room for the mark, the path needs to be shortened by some amount. This is trivial for straight segments but not for curved paths. 

The issue is demonstrated in the figure below. In all cases, the arrow is tangent to the curve at its end. In the left panel of the figure, the curve does not enter the arrow in the middle but rather from the side which definitely wouldn't make you look like a good designer when handing in professional work ;) 

To compensate this issue, the path is _transformed_, i.e., shortened by some amount to make it seem nicer. This happens at the cost of the path being not quite the same, but it yields a much prettier result. 


<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/shortening.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/shortening-dark.svg">
    <img alt="Path shortening" src="docs/figures/out/shortening.svg">
  </picture>
</p>



Not always is it desirable to shorten the path all the way (hey, a little asymmetry simply belongs in life). For this purpose, `path` has a parameter `shorten` which takes ratios between `0%` and `100%` (default). 



## Combining marks

The function `combine()` makes it quite easy to combine multiple marks into a single new one. It accepts any number of marks and can even process combined marks recursively. 

```typ
#line(tip: combine(bar, stealth))
```
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/combine.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/combine-dark.svg">
    <img alt="How to combine marks" src="docs/figures/out/combine.svg">
  </picture>
</p>



The combined marks are automatically lined up one after the other, always the next one where the previous one ended. In order to introduce or increase the space between two marks, you may use length values (like `10pt`) or even better ratios (which are measured relative to the line thickness). Negative values are allowed. 



<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/combined.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/combined-dark.svg">
    <img alt="Examples for combined arrows and marks" src="docs/figures/out/combined.svg">
  </picture>
</p>

By default, the path is shortened until the last mark. This behaviour can be overriden by adding an `end` element somewhere in the mark list. The position of the `end` element between the marks defines where the line or path should end. 


## Defining custom marks

A mark is just a function that accepts a named `line` argument and that returns a dictionary `(mark: .., end: ..)` where `mark` holds the rendered mark and `end` is a length that specifies the amount by which the line or path needs to be shortened. 

As an example, let us look at a simplified definition of the `bar` mark.
```typ
#import tiptoe.utility

#let bar(
  // mandatory, will be set by line(), path() and arc()
  line: stroke() 
  // optional configuration parameters
  width: 2.4pt + 360%, 
  stroke: auto, 
) = {
  stroke = utility.process-stroke(line, stroke)
  let (width,) = utility.process-dims(
    line, width: width
  )

  (
    mark: place(path(
      (0pt, -width / 2),
      (0pt, width / 2),
      stroke: stroke
    )),
    end: 0pt
  )
}
```

Let us first explain the difference between the parameters `line` and `stroke`:
- `line` is sort of a _private_ parameter. It is set by the functions `tiptoe.path()`, `tiptoe.line()` and `tiptoe.arc()`, when the mark is realized and contains the stroke used for drawing the path/line/arc. We use it often to make the mark inherit color and thickness. 
- `stroke` is totally optional for your mark, but all built-in marks have it. It allows the user of the mark to customize its stroke, overriding the stroke inherited from `line`. 

You can add an arbitrary number of other configuration parameters to your mark. 

The module `tiptoe.utility` provides two very useful helpers. The function `process-stroke()` takes the `line` and `stroke` parameter and returns a merged stroke to be used for drawing the mark. The merging obeys the following rules
- Only `thickness` and `paint` are inherited from `line`. 
- Thickness and paint are both (independently) only inherited if they are set to `auto` in `stroke`. This makes it for example possible to configure only the color of a mark without changing the thickness. 
- If `stroke` is `none`, nothing is inherited and `none` is returned. 
- The merged stroke is guaranteed to have a `thickness` that is not `auto`. 





The other helper function `process-dims()` is useful for processing length and/or width of the mark which may be (see the [section about sizing](#sizing)) a `ratio` (in terms of the line thickness), a `length`, or a combination thereof. It takes the `line` and optional `width` and `length` parameters and returns a dictionary with the evaluated `width` and `length` (if they were given). In addition, it can process a width set to `auto` in terms of the length with a coefficient that can be specified with the parameter `default-ratio`. As an example, the `stealth` mark has an automatic width by default which is then 80% of the length. 

Hints for rendering the mark:
- You only need to take care of the case where the mark is used as a `tip`. The `toe` case is handled automatically. 
- The path goes from left to right and ends at `(0pt, 0pt)`. The stealth arrow, e.g., points exactly to this coordinate. 
- The rotation of the mark is fully handled by tiptoe. 

## Arc

Many have noted that (as of now) Typst does not feature a function to draw arcs. This is sometimes unfortunate since circular arcs are not at all trivial to approximate with Bézier curves. 

Until a built-in arc function makes it into the core of Typst, enjoy this one:

```typ
#let arc(
  origin: (0pt, 0pt),  // Origin coordinates
  angle: 0deg,         // Start angle
  arc: 45deg,          // Arc angle
  radius: 1cm,         // The radius of the full circle
  width: auto,         // The width of the full ellipse
  height: auto,        // The height of the full ellipse
  stroke: 1pt + black,
  fill: none,
  closed: false,       // false, "segment" or "sector"
  tip: none,           // Mark placed at the start 
  toe: none,           // Mark placed at the toe
  shorten: 50%         // Path shortening
)
```



<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="docs/figures/out/arc.svg">
    <source media="(prefers-color-scheme: dark)" srcset="docs/figures/out/arc-dark.svg">
    <img alt="Usage of the arc() primitive" src="docs/figures/out/arc.svg">
  </picture>
</p>







## Difference between built-in and tiptoe `path()`


While the built-in [`path`][typst-path] function returns a block-level element with a size that measures from `(0pt, 0pt)` to the largest (positive) coordinate, the corresponding tiptoe function returns placed content (with zero-width and -height). 

The reasons are
- It is hard to measure the bounding box properly including the marks. 
- The behavior of the built-in functions is not particularly useful since they measure only in the positive direction. I suspect that most packages using the drawing primitives wrap them with `place()` anyway. 



[fletcher]: https://github.com/Jollywatt/typst-fletcher
[cetz]: https://github.com/cetz-package/cetz
[jollywatt]: https://github.com/Jollywatt/
[typst-path]: https://typst.app/docs/reference/visualize/path/
[typst]: https://typst.app
