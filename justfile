install-deps:
    brew install pdfpc typst
    cargo install --git https://github.com/andreasKroepelin/polylux/ --branch release

make-pdf:
    typst compile --root . views.typ

make-presentation: make-pdf
    polylux2pdfpc --root . views.typ

present:
    pdfpc views.pdf
