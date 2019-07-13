# metanorma:
# 	docker run -v "$(pwd)":/metanorma/ -w /metanorma ribose/metanorma "metanorma -t iso -x html,doc,xml main.adoc"

main.adoc: main.xml
	saxon \
		-s:main.xml \
		-xsl:Metanorma.xsl \
		-o:main.adoc

main.xml: main.tex
	latexml \
		main.tex \
		--output=main.xml \
		--nocomments

main.pdf: main.tex
	latexmk -pdf main.tex

clear:
	rm -f main.xml
	rm -f main.adoc
	latexmk -c main.tex

clobber: clear
	rm -f main.adoc
	rm -f main.pdf
	latexmk -C main.tex

watch:
	ls ../Metanorma* Makefile main.tex | entr make clobber main.adoc
