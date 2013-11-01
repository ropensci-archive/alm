vignettes: 
	Rscript -e 'library(knitr); knit("alm_vignette.Rmd")'
	pandoc alm_vignette.md -o alm_vignette.tex
	mv alm_vignette.tex alm_vignette.Rnw
	pandoc -H margins.sty alm_vignette.md -o alm_vignette.pdf