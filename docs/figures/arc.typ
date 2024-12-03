#import "template.typ": *
#show: template

#let content = figure[
  #grid(
    columns: 4, column-gutter: 2em, row-gutter: 1em,
    box(height: 1.55cm, width: 1.1cm, 
      arc(origin: (0pt, 30pt), angle: -90deg, arc: 120deg)
    ),
    box(height: 1.55cm, width: 1.7cm, 
      arc(origin: (15pt, 30pt), angle: -110deg, arc: 120deg, closed: "sector")
    ),
    box(height: 1.55cm, width: 2cm, 
      arc(origin: (35pt, 10pt), angle: 60deg, arc: 130deg, closed: "segment")
    ),
    box(height: 1.55cm, width: 2.6cm, 
      arc(origin: (1.3cm, 20pt), angle: 60deg, arc: 300deg, width: 2cm, height: 1cm)
    ),
    ```typc
    arc(
      angle: -90deg,
      arc: 120deg
    )
    ```,
    ```typc
    arc(
      angle: -110deg,
      arc: 120deg,
      closed: "sector"
    )
    ```,
    ```typc
    arc(
      angle: 60deg,
      arc: 130deg,
      closed: "segment"
    )
    ```,
    ```typc
    arc(
      angle: 60deg,
      arc: 300deg,
      width: 2cm, 
      height: 1cm
    )
    ```,
  )
]
#content