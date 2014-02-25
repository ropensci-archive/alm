all: move pandoc rmd2md reducepdf

move:
		cp inst/vign/alm_vignette.md vignettes/
		cp -rf inst/vign/figure/* vignettes/figure/

pandoc:
		cd vignettes;\
		pandoc -H margins.sty alm_vignette.md -o alm_vignette.pdf --highlight-style=tango;\
		pandoc -H margins.sty alm_vignette.md -o alm_vignette.html --highlight-style=tango

rmd2md:
		cd vignettes;\
		cp alm_vignette.md alm_vignette.Rmd;\

reducepdf:
		Rscript -e 'tools::compactPDF("vignettes/alm_vignette.pdf", gs_quality = "ebook")'