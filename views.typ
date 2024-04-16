// Get Polylux from the official package repository
#import "@preview/polylux:0.3.1": *
#import "@preview/polylux:0.3.1": polylux-slide as slide

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")
#set page(fill: rgb(39,40,34))
#set text(size: 25pt)
#set text(fill: rgb(255, 255, 255))

#slide[
  #align(horizon + center)[
    #box(width: 75%)[
      = Views: A way for pattern matching to cohabit with data abstraction
    ]

    Domantas Keturakis
  ]
]

#slide[
  == Miranda

  Haskell'io pirmtakas

  #columns(2)[

    ```miranda
    data Nat = S Nat | Z
    ```

    #colbreak()

    ```
    data Nat = S Nat | Z
    ```

  ]
]

// #pagebreak()
// === Panašumai tarp `Idris` ir `Miranda`

#slide[== Indukcija ir Pattern matching'as

]

#slide[
  == Views

  + Abstrakcija

    #quote(
      "Pattern matching depends on making public a free data type representation, while data abstraction depends on hiding the representation."
    )

  + Indukcija

    #quote("Pattern matching in a language feature that supports induction")


]

#slide[
  == First slide

  Some static text on this slide.
]

#polylux-slide[
  == This slide changes!

  You can always see this.
  // Make use of features like #uncover, #only, and others to create dynamic content
  #uncover(2)[But this appears later!]
]