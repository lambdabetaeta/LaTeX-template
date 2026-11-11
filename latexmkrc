@default_files = ('main.tex');
$pdf_mode = 1;                            # pdflatex is 1, xelatex is 5, lualatex is 4
# minted (v3) runs latexminted, which TeX Live permits under restricted shell
# escape, so no --shell-escape is needed.
