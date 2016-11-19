library(rmarkdown)
library(knitr)

Sys.setenv(RSTUDIO_PANDOC = "/Applications/RStudio.app/Contents/MacOS/pandoc")

render("report.Rmd")
