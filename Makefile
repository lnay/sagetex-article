MAINTEXFILE = main.tex
TEXFILES = ${MAINTEXFILE} preamble.fmt
SAGETEXSCRIPT = main.sagetex.sage
SAGEARTIFACT = main.sagetex.sout

main.pdf: ${TEXFILES} ${SAGEARTIFACT}
	latexmk

sage_artifacts: ${SAGEARTIFACT}

main.sagetex.sout.tmp: ${SAGETEXSCRIPT} notebook.py
	sage ${SAGETEXSCRIPT}

${SAGETEXSCRIPT}: ${TEXFILES}
	latexmk || echo this shoud fail

notebook.py: notebook.ipynb
	jupyter nbconvert --to script notebook.ipynb
	mv notebook.py notebook.sage
	sed -e "/get_ipython/d" -i notebook.sage
	sage --preparse notebook.sage
	mv notebook.sage.py notebook.py
	
preamble: preamble.fmt
	
preamble.fmt: preamble.tex
	pdflatex -ini -jobname="preamble" "&pdflatex preamble.tex\dump"

.PHONY: clean nosage
clean:
	rm -rf **/__pycache__
	latexmk -C

nosage:
	latexmk
