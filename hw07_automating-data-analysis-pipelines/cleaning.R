library(stringr)

wd <- getwd()

if(!str_detect(wd, "pipelines$")) {
  setwd(str_c(getwd(), "/hw07_automating-data-analysis-pipelines"))
}

unlink("*.csv")
unlink("*.tsv")
unlink("*.png")
unlink("*.html")
unlink("report.md")

