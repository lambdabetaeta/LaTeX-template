# LaTeX article template

A KOMA-Script article template for papers in programming languages, type
theory, logic and category theory.

With thanks to Daniel Gratzer and Jon Sterling for many of the macros.

## Requirements

- A TeX distribution (TeX Live, MacTeX or MiKTeX) that includes `latexmk`
  and `biber`.
- `latexminted` for `minted` code listings. TeX Live ships it and allows it
  under its default restricted shell escape, so `--shell-escape` is not needed.

## Building

```sh
latexmk       # build main.pdf
latexmk -c    # remove auxiliary files, keep the PDF
latexmk -C    # also remove the PDF
```

`latexmkrc` makes `main.tex` the default target and builds with `pdflatex`.
latexmk runs `biber` and reruns LaTeX until cross-references settle. To use
XeLaTeX, set `$pdf_mode = 5` there (`4` for LuaLaTeX).

Every push to `main` is built on GitHub Actions, and the PDF is published at
`releases/latest/download/main-latest.pdf`.

## Starting a paper

This repository is a GitHub template. To create a new paper from it:

```sh
gh repo create my-paper --template lambdabetaeta/LaTeX-template --private --clone
```

Then edit `main.tex`, and put macros that belong only to that paper in
`macros.sty`. Load only the macro packages the paper needs.
