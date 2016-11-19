all: report.html

clean:
	rm -f *.tsv *.png *.csv report.md *.html
  
gapminder.tsv: 00_download-the-data.R
	Rscript 00_download-the-data.R
  
exploratory_analyses: 01_perform-exploratory-analyses.R gapminder.tsv
	Rscript 01_perform-exploratory-analyses.R
  
statistical_analyses: 02_perform-statistical-analyses.R exploratory_analyses
	Rscript 02_perform-statistical-analyses.R
  
figures: 03_generate-figures.R statistical_analyses gapminder.tsv
	Rscript 03_generate-figures.R
  
report.html: report.Rmd figures
	Rscript 04_report.R
 