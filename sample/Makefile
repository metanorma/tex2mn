# metanorma:
# 	docker run -v "$(pwd)":/metanorma/ -w /metanorma ribose/metanorma "metanorma -t iso -x html,doc,xml main--iso.adoc"

main--iso.adoc: main--tex.xml
	saxon \
		-s:main--tex.xml \
		-xsl:IsoStandardDocument.xsl \
		-o:main--iso.adoc

main--tex.xml: main.tex
	latexml \
		main.tex \
		--output=main--tex.xml \
		--nocomments

main.pdf: main.tex
	latexmk -pdf main.tex

clear:
	rm -f main--tex.xml
	rm -f main--iso.xml
	rm -f main--iso.adoc
	latexmk -c main.tex

clobber: clear
	rm -f main.pdf
	latexmk -C main.tex

watch:
	ls ../Iso* Iso* Makefile main.tex | entr make clobber main--iso.adoc
