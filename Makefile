default : compile

.PHONY : default clean

compile : ./analisi/analisi.tex
	pdflatex ./analisi/analisi.tex
	pdflatex ./analisi/analisi.tex
	pdflatex ./analisi/analisi.tex

clean :
	rm *.aux *.log *.out *.toc
