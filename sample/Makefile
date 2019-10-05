# metanorma:
# 	docker run -v "$(pwd)":/metanorma/ -w /metanorma ribose/metanorma "metanorma -t iso -x html,doc,xml main.adoc"

main.diff: main.adoc main--saxon.adoc
	diff \
		main.adoc \
		main--saxon.adoc \
		> main.diff

main--saxon.adoc: main.xml
	saxon \
		-s:main.xml \
		-xsl:Metanorma.xsl \
		-o:main--saxon.adoc

main.adoc: main.xml
	latexmlpost \
		main.xml \
		--nocrossref \
		--stylesheet=Metanorma.xsl \
		--destination=main.adoc \
		--nodefaultresources \
		--novalidate

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
