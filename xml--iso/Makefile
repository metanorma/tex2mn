main--iso.xml: main--tex.xml
	latexmlpost \
		main--tex.xml \
		--stylesheet=IsoStandardDocument.xsl \
		--destination=main--iso.xml \
		--nodefaultresources \
		--novalidate
	xmllint \
		--output main--iso.xml \
		--format main--iso.xml

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
