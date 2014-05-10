.PHONY: all clean process_management_and_process_schedule

all: process_management_and_process_schedule

process_management_and_process_schedule: process_management_and_process_schedule.pdf process_management_and_process_schedule.html process_management_and_process_schedule.epub process_management_and_process_schedule.mobi
process_management_and_process_schedule.tex: figures/context_switch.eps figures/fork.eps figures/multitask.eps figures/red-black-tree.eps figures/exec.eps figures/memory_map.eps figures/process_switch.eps
process_management_and_process_schedule.html: figures/context_switch.png figures/fork.png figures/multitask.png figures/red-black-tree.png figures/exec.png figures/memory_map.png figures/process_switch.png

clean:
	rm -fv *.tex *.aux *.dvi *.log *.pdf *.html *.epub *.mobi *.out figures/*.png

%.png: %.eps
	convert $< $@

%.pdf: %.dvi
	dvipdfmx $<

%.dvi: %.tex
	platex $<
	platex $<

%.tex: %.md
	pandoc $< -s -o $@ -V documentclass=jsarticle -V classoption=a4j --default-image-extension=.eps --filter pandoc-citeproc

%.html: %.md
	pandoc $< -s -o $@ --default-image-extension=.png --filter pandoc-citeproc

%.epub: %.md %.html
	pandoc $< -s -o $@ --default-image-extension=.png --filter pandoc-citeproc

%.mobi: %.epub
	-~/kindlegen/kindlegen $<
