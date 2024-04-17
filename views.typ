// Get Polylux from the official package repository
#import "@preview/polylux:0.3.1": *
#import "@preview/polylux:0.3.1": polylux-slide as slide

// Make the paper dimensions fit for a presentation and the text larger
#set page(fill: rgb(39,40,34))
#set text(fill: rgb(255, 255, 255))

#let TEXT_SIZE = 23pt
#set text(font: "Inria Sans")
#set text(size: TEXT_SIZE)
#show heading: set text(size: 30pt)

#set page(paper: "presentation-16-9")

#pdfpc.config()

#set quote(block: true, quotes: true)
#show quote: set emph()
#show quote: set pad(x: 1em)

#let code(lang: "none", size: TEXT_SIZE, width: auto, raw_text: "") = {
  block(radius: 5pt, fill: rgb(22,21,15), inset: 10pt, width: width)[
    #align(left + top)[
      #set text(size: size)
      #raw(raw_text, lang: lang)
    ]
  ]
}

#slide[
  #align(horizon + center)[
    #box(width: 70%)[
      = Views: A way for pattern matching to cohabit with data abstraction
    ]

    by Philip Wadler

    #v(1em)
  ]

  #pdfpc.speaker-note(
    "~~~ some notes ~~~"
  )
]

// #pagebreak()
// === Panašumai tarp `Idris` ir `Miranda`

#slide[== Indukcija ir Pattern matching'as
  #align(horizon + center)[
    #grid(columns: 3, rows: 1, gutter: 0.5em,
      [
        #set text(size: 35pt)
        $
          x^0 &= 1 \
          x^(n+1) &= x  dot x^n
        $
      ], [
        #set text(size: 35pt)
        $->$
      ], [
        #set text(size: 30pt)
        #code(lang: "idris", raw_text: read("ex/ind.idr"))
      ]
    )
  ]

  #pdfpc.speaker-note(
    "~~~ some notes ~~~"
  )

]

#slide[== Pattern matching'as vs abstrakcija

    #quote(attribution: "Philip Wadler")[
      Pattern matching depends on making public a free data type representation, while data abstraction depends on hiding the representation.
    ]
]


#slide[
  == Views

  #align(horizon + center)[
    #set text(size: 27pt)

      #box(width: 75%)[
        Paslėpti implementacijos detales _*ir*_ leisti pattern match'inti ant tam tikrų duomenų
      ]
  ]
    #quote(attribution: [Philip Wadler])[
      A view allows any type to be viewed as a free data type, thus combining the clarity of pattern matching with the efficiency of data abstraction.
    ]

]

#slide[
  == Sintaksė

  #columns(2)[

    *Miranda*
    #code(lang: "miranda", size: 20pt, raw_text: read("ex/syntax1.m").split("\n").join("\n"))

    #colbreak()

    *Idris*
    #code(lang: "idris", size: 20pt, raw_text: read("ex/syntax1.idr"))

  ]
]

#slide[
  == Sintaksė

  *Miranda*
  #grid(columns: 2, column-gutter: 1em,
  [
    #code(lang: "miranda", size: 20pt, raw_text: read("ex/syntax2_1.m"))
  ],[
    #code(lang: "miranda", size: 20pt, raw_text: read("ex/syntax2_2.m"))
  ])
]

#slide[=== Int $<->$ Nat
  #grid(columns: 2,
  [
    #code(raw_text: "view int ::= Zero | Succ int
  in n         = Zero,          if n = 0
               = Succ (n - 1),  if n > 0
  out Zero     = 0
  out (Succ n) = n + 1
")
    #code(raw_text: read("ex/fib1.m"))
  ],
  [])
  

  #pdfpc.speaker-note(
    "NOTE: rekursyviai konvertuojama (n - 1)"
  )
]

#slide[=== Int $<->$ Nat

#code(size: 20pt, raw_text: "viewtype ::= Zero | Succ int
  viewin n     = Zero,          if n = 0
               = Succ (n - 1),  if n > 0
  viewout Zero     = 0
  viewout (Succ n) = n + 1
")
#code(size: 20pt, raw_text: "fib m =
  case viewin m of
    Zero    => viewout Zero
    Succ m' => case vienin m' of
      Zero    => viewout (Succ (viewout Zero))
      Succ m' => fib n + fib (viewout (Succ n))
")

  #pdfpc.speaker-note(
"Views'ai - funkcijos konvertavimui"
  )
]

#slide[=== SnocList
  #code(raw_text: "view list α ::= Nil | (list α) Snoc α
  in (x Cons Nil)            = Nil Snoc x
  in (x Cons (xs Sonc x'))   = (x Cons xs) Snoc x'
  out (Nil Snoc x)           = x Cons Nil
  out ((x Cons xs) Snoc x')  = x Cons (xs Snoc x')
")

  TODO: pavyzdys
]

#slide[=== In, out & inout
  #code(raw_text: "view list α ::= Nil | (list α) Snoc α
  inout (x Cons Nil)            = Nil Snoc x
  inout (x Cons (xs Sonc x'))   = (x Cons xs) Snoc x'
")

  #pdfpc.speaker-note(
    "NOTE: inout"
  )
  
]

#slide[== Efektyvumas
  #one-by-one[
    #v(1em)

    `1 Cons (2 Cons (3 Cons (4 Cons Nil)))` $=>$\
  
    $=>$ `((((Nil Snoc 1) Snoc 2) Snoc 3) Snoc 4)`

  ][
    #v(1em)
    #code(raw_text: "list α :== Nil | Unit α | (list α) Join (list α)")
  ]

  #pdfpc.speaker-note(
    "yra tam tikras šališkumas"
  )

]

#slide[== `Join` reprezentacija
  #align(center + horizon)[
  #one-by-one[
    #v(1em)
    #code(raw_text: "list α :== Nil | Unit α | (list α) Join (list α)")
  ][
    #v(1em)
      #code(raw_text: "(Unit 1) Join (Unit 2)")
      #code(raw_text: "(Nil Join (Unit 1)) Join ((Unit 2) Join Nil)")
      #code(raw_text: "(Unit 1) Join (( Unit 2) Join Nil)")

    ]
  ]

  #pdfpc.speaker-note(
    "yra tam tikras šališkumas"
  )

]

#slide[== `Join` reprezentacija
  #code(raw_text: "view list α ::= Nil | α Cons (list α)
  in (Unit x)               = x Cons Nil
  in (Nil Join xs)          = in xs
  in ((Unit x) Join xs)     = x Cons xs
  in ((xs Join ys) Join zs) = in (xs Join (ys Join zs))
  out (x Cons xs)           = (Unit x) Join xs
")

  #pdfpc.speaker-note(
    "yra tam tikras šališkumas"
  )

]

#slide[=== Pavyzdys: koordinatės
  #image("img/view_coord.png", width: 50%)
]

#slide[=== Kiti pritaikymai: `zip`
  #image("img/view_zip.png", width: 26%)
]

#slide[=== Kiti pritaikymai: predikatai
  #image("img/m_pred.png")
]

#slide[=== Kiti pritaikymai: `@`
  #code(raw_text:
"view α ::= α as α
  in x          = x as x
  out (x as x') = x,         if x = x'
")

  #code(raw_text: "factorial (n as Zero) = 1
factorid (n as Succ n') = n × factorial n'
")
]

#slide[=== Kiti pritaikymai: `@`
  #grid(columns: 2, gutter: 1em,
  [
    #code(width: 100%, raw_text: read("ex/as2.idr"))
  ],
  [
    #code(width: 100%, raw_text: read("ex/as1.idr"))
  ]
  )
]

#slide[== Equational reasoning à la Referential Transparency

  // Viena iš savybių, kurią Views'ai išsaugo -- tai referential transparency

  #quote("A linguistic construction is called referentially transparent when for any expression built from it, replacing a subexpression with another one that denotes the same value does not change the value of the expression.", attribution: "Wikipedia")

  #align(center)[arba \ #v(0.1em)
    $ x(x + 1) = x^2 + x = x(x + 1)$
  ]
]

#slide[== Equational reasoning à la Referential Transparency

  #one-by-one[
  #code(raw_text: "view list α ::= Nil | (list α) Snoc α
  inout (x Cons Nil)            = Nil Snoc x
  inout (x Cons (xs Sonc x'))   = (x Cons xs) Snoc x'
")
  ][
  #code(raw_text: "rotleft (x Cons xs) = x Snoc xs
rotright (xs Snoc x) = x Cons xs")
  #code(raw_text: "rotleft [1,2,3,4] = [2,3,4,1]
rotright [1,2,3,4] = [4,1,2,3]")

  ][

    #code(raw_text: "rotright (rotleft xs) = xs")

  ]
]

#slide[== Referential transparency
  #code(raw_text: "rotleft (x Cons xs) = xs Snoc x
rotright (xs Snoc x) = x Cons xs")

#alternatives[
  #align(top)[
    #code(raw_text: "rotright (rotleft (x Cons xs)) = ?


")
  ]
][
  #align(top)[
  #code(raw_text: "rotright (rotleft (x Cons xs)) =
= rotright (xs Snoc x)

")
  ]][
  #code(raw_text: "rotright (rotleft (x Cons xs)) =
= rotright (xs Snoc x)
= x Cons xs")
]
]

#slide[== Indukcija

  #v(1em)

  Norint įrodyti, kad savybė $P(x s)$ galioja kiekvienam sąrašui $x s$, pakanka parodyti, kad:

  #v(0.5em)
  #one-by-one[
    - $P("Nil")$ galioja, ir
    - $P(x s "Snoc" x)$ galioja, darant prielaidą, kad $P(x s)$ galioja.
  ]

  ditto: natūralūs skaičiai

]

#slide[== Realizacija

    #v(1em)
    #only(1)[#align(center)[
      `Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero))))))`
    ]]

  #align(horizon + center)[
      #only(2)[
        #code(raw_text: "view int ::= Zero | Succ int
  in n         = Zero,          if n = 0
               = Succ (n - 1),  if n > 0
  out Zero     = 0
  out (Succ n) = n + 1
")
    #code(raw_text: read("ex/fib1.m"))
]
      #only(3)[
        #code(size: 20pt, raw_text: "viewcase z s n  = z,         if n = 0
                = s (n - 1), if n > 0
zero            = 0
succ            = n + 1
")
        #code(size: 20pt, raw_text: "fib m = viewcase
          zero
          (\λm'. viewcase
                 (succ zero)
                 (\λn. n + fib (succ n))
                 m')
          m")

]

  ]
]

#slide[== Realizacija
  #align(center + horizon)[
        #code(raw_text: "fibx a b Zero = a
fibx a b (Succ n) = fibx b (a+b) n
")
        $ arrow.b $
        #code(raw_text: "fibx a b m = a,                        if m = 0
           = fibx b (a + b) (m - 1),   if m > 0
")

  ]

]

#slide[== Diskusija / mano nuomonės

  - Abstrackija

  - Performance

]

#slide[=== Efficiency?

  #set text(size: 20pt)
  #quote()[
  The representation of the number seven is the data structure

  `Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero))))))`


  Compared with the representation of integers built-in to the computer hardware, this representation is astonishingly inefficient. If we had followed the fundamental principle of dafa abstraction (or representation hiding) then this problem would not arise, because we would be free to implement naturaI numbers in any convenient way, including the built-in integer data type.
  ]

]

#slide[=== Efficiency??

  #set text(size: 20pt)
  #quote()[
    In short, pattern matching supports clear delinitiona and induction, but it requires that the representing type be a free data type and be visible. Data abstraction supports &Iicicncy, but it requires that the representing type be hidden. Thus, the programmer is often faced with an unenviabIe choice between clarity and efficiency.
  ]

]

#slide[== Extra pavyzdys: medžiai]
