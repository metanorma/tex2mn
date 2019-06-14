main--iso.xml: main--tex.xml
	latexmlpost \
		main--tex.xml \
		--stylesheet=IsoStandardDocument.xsl \
		--destination=main--iso.xml \
		--nodefaultresources \
		--novalidate

main--tex.xml: main.tex
	latexml main.tex --output=main--tex.xml

main.pdf: main.tex
	latexmk -pdf main.tex

clear:
	rm -f main--tex.xml
	rm -f main--iso.xml
	latexmk -c main.tex

clobber: clear
	rm -f main.pdf
	latexmk -C main.tex

meta:
	docker run -v "$(pwd)":/metanorma/ -w /metanorma ribose/metanorma "metanorma -t iso -x html,doc,xml meta.adoc"
