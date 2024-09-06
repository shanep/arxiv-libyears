# Makefile for ACM paper ID will be assigned by the publisher upon acceptance
PAPER_ID = 00
PROCEDINGS = arxiv
PAPER_PILE_BIB = TBD
TAPS := $(PROCEDINGS)-$(PAPER_ID)

%.pdf: %.tex
	latexmk -pdf $<

paper: paper.pdf

arxiv: paper
	mkdir -p arxiv/figures
	cp paper.tex arxiv
	cp paper.bib arxiv
	cp paper.bbl arxiv
	cp figures/* arxiv/figures/
	cp sn-jnl.cls arxiv
	cp sn-mathphys-num.bst arxiv
	zip -r arxiv.zip arxiv/

# Download the paperpile bib file if needed
.PHONY: bib
bib:
	wget --content-disposition -N $(PAPER_PILE_BIB)

.PHONY: clean
clean:
	rm -f paper.pdf *.synctex.gz *.bbl *.run.xml *.blg *.aux *.log *.out *.fls *.fdb_latexmk
	rm -rf $(TAPS) $(TAPS).zip arxiv arxiv.zip
