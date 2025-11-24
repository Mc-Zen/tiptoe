#import "template.typ": *
#show: template

#let content = figure[
  #grid(
    columns: 3, column-gutter: 2em, row-gutter: 1em,
    box(height: 1.55cm, width: 1.1cm, 
      ring(origin: (0pt, 30pt), angle: -90deg, arc: 90deg)
    ),
    box(height: 1.55cm, width: 1.7cm, 
      ring(origin: (15pt, 30pt), angle: -180deg, arc: 180deg, fill: blue)
    ),
    box(height: 1.55cm, width: 2cm, 
      ring(origin: (35pt, 25pt), angle: 60deg, arc: 360deg)
    ),
    ```typc
    ring(
      angle: -90deg,
      arc: 90deg
    )
    ```,
    ```typc
    ring(
      angle: 0deg,
      arc: 180deg,
      fill: blue
    )
    ```,
    ```typc
    ring(
      arc: 360deg,
    )
    ```,
  )
]
#content