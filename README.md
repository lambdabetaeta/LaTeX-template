# LaTeX article template

A personal LaTeX article template geared towards papers in programming
languages, type theory, logic, and category theory. It bundles a KOMA-Script
document class, a curated preamble, and a set of semantic macro packages for
typesetting lambda calculi, inference rules, proofs, and categorical
constructions.

With thanks to Daniel Gratzer and Jon Sterling for many of the macros.

## Quick start

1. Make sure you have a TeX distribution (TeX Live, MacTeX, or MiKTeX) with
   `latexmk` and `biber` on your `PATH`.
2. Compile the example document:

   ```sh
   latexmk
   ```

   `latexmkrc` sets `main.tex` as the default target and uses `pdflatex` with
   `--shell-escape` enabled (needed if you add `minted`). `biber` is run
   automatically for the bibliography.
3. To start your own paper, edit `main.tex` and put any one-off macros in
   `macros.sty`.

To clean up build artifacts:

```sh
latexmk -c    # remove auxiliary files, keep the PDF
latexmk -C    # also remove the PDF
```

## Layout

The document class and preamble are factored apart from the semantic macros so
you can pull in only what a given paper needs.

| File              | Purpose |
|-------------------|---------|
| `main.tex`        | Example document — copy this as the starting point for a paper. |
| `gak-article.cls` | Document class built on `scrartcl` (KOMA-Script). Sets fonts, theorem environments, `cleveref` names, and a `diagram` environment. |
| `preamble.sty`    | Shared preamble: bibliography setup (`biblatex`/`biber`), colours, the `grammar` environment, and inductive-proof list macros. |
| `macros.sty`      | Empty by design — put macros local to *this* article here. |
| `latexmkrc`       | `latexmk` configuration (default target, shell-escape). |
| `refs.bib`        | Example bibliography database. |

### Semantic macro packages

These are optional; `\usepackage` only the ones you need.

| Package            | Provides |
|--------------------|----------|
| `maths.sty`        | General mathematics: `\defeq`, bracket shorthands (`\prn`, `\brk`, `\sem`, …), sets, functions, lists, booleans. |
| `lambda-macros.sty`| Lambda-calculus and type-system notation: judgements, terms (`\Lam`, `\App`, `\Let`, `\Fix`), STLC connectives, operational-semantics arrows, and semantic colouring. |
| `tt-macros.sty`    | Type-theory macros: dependent sums/products, universes, contexts and substitutions, modal `box`/`circ` operators. |
| `categories.sty`   | Category theory: named categories, hom-sets, op/slice/functor categories, Kan extensions, the Yoneda embedding, profunctors. |
| `logic.sty`        | Logic macros: booleans, Kripke forcing, valuations, semantic brackets. |
| `pftools.sty`      | Proof tooling: hyperlinked inference rules (`\inferH`, `\ruleref`), bi-implication rules, and tabbed proof-outline environments. |

### Third-party / vendored packages

| File             | Source |
|------------------|--------|
| `jmsdelim.sty`   | Jon Sterling's compositional delimiter-sizing package (LPPL). Underpins the bracket macros in `maths.sty` and elsewhere. |
| `locallabel.sty` | Local labelling support used by `pftools.sty`. |
| `lambda.sty`     | Duplicate of `lambda-macros.sty` (declares the same package name); kept for older documents that `\usepackage{lambda}`. |

## A tour of `main.tex`

The example file demonstrates the main features:

- **Theorem environments** — `theorem`, `lemma`, `definition`, `remark`,
  `example`, etc., numbered per section. `example`/`remark` print an end-of-block
  marker.
- **Grammars** — the `grammar` environment from `preamble.sty`:

  ```latex
  \begin{grammar}
    Terms & M, N & x \mid \Lam{x}{M} \mid \App{M}{N}
  \end{grammar}
  ```

- **Inference rules** — `mathpar` from `mathpartir`, plus `pftools`'
  `\inferH{Name}{premises}{conclusion}` for rules you can cross-reference with
  `\ruleref{Name}`.
- **Inductive proofs** — the `indproof` list with `\indcase{...}`.
- **Cross-references** — `cleveref`'s `\cref`, with `\S` styling for sections.
- **Citations** — `biblatex` with `\parencite` / `\printbibliography`.

## Customisation notes

- **Bibliography backend.** `preamble.sty` uses `biber` with an alphabetic
  style. If a venue mandates BibTeX, swap the `biblatex` options accordingly.
- **Fonts.** `gak-article.cls` loads `mlmodern`; an `adobe-utopia` /
  `mathdesign` alternative is commented out.
- **Engine.** The default is `pdflatex`. To switch to `xelatex`, set
  `$pdf_mode = 5` (and adjust `$pdflatex`) in `latexmkrc`.
