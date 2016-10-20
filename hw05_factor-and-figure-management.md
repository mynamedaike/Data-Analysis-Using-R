Homework 05: Factor and figure management; Repo hygiene
================
Ke Dai
2016/10/19

Import gapminder and tools
--------------------------

``` r
library(gapminder)
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(knitr)
library(forcats)
```

Factor management
-----------------

**Drop Oceania**. Filter the Gapminder data to remove observations associated with the continent of Oceania. Additionally, remove unused factor levels. Provide concrete information on the data before and after removing these rows and Oceania; address the number of rows and the levels of the affected factors.

**Reorder the levels of country or continent**. Use the forcats package to change the order of the factor levels, based on a principled summary of one of the quantitative variables. Consider experimenting with a summary statistic beyond the most basic choice of the median. While you’re here, practice writing to file and reading back in (see next section).

Characterize the (derived) data before and after your factor re-leveling.

-   Explore the effects of arrange(). Does merely arranging the data have any effect on, say, a figure?
-   Explore the effects of reordering a factor and factor reordering coupled with arrange(). Especially, what effect does this have on a figure?

These explorations should involve the data, the factor levels, and some figures.

**Drop Oceania**

``` r
gap_dropped <- gapminder %>% 
  filter(continent != "Oceania") %>% 
  droplevels()
```

``` r
str(gapminder)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

``` r
str(gap_dropped)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1680 obs. of  6 variables:
    ##  $ country  : Factor w/ 140 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 4 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

We can see that there are 5 levels for continent and 142 levels for country before dropping Oceania while there are 4 levels for continent and 140 levels for country after dropping Oceania. We can also see that there are 1704 observations before dropping Oceania while there are 1680 observations after dropping Oceania.

Supposing I do not have the knowledge about which countries are in Oceania, I want to further explore which country levels are associated with Oceania. Let's get started.

``` r
gapminder %>% 
  filter(continent == "Oceania") %>% 
  count(country) %>% 
  kable()
```

| country     |    n|
|:------------|----:|
| Australia   |   12|
| New Zealand |   12|

We can see that the countries associated with Oceania are Australia and New Zealand and there are 24 observations for these two countries which are just the rows removed from gapminder.

**Reorder the levels of country or continent**

``` r
## get the subset of gapminder for all European countries
gap_euro <- gapminder %>% 
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap) %>% 
  droplevels()

## reorder the subset
gap_reordered <- gap_euro %>% 
  mutate(country = reorder(country, gdpPercap, mean))

## arrnage the subset
gap_arranged <- gap_euro %>% 
  arrange(gdpPercap)
```

``` r
## original data set
kable(gap_euro[1:20, ])
```

|  year| country |  gdpPercap|
|-----:|:--------|----------:|
|  1952| Albania |   1601.056|
|  1957| Albania |   1942.284|
|  1962| Albania |   2312.889|
|  1967| Albania |   2760.197|
|  1972| Albania |   3313.422|
|  1977| Albania |   3533.004|
|  1982| Albania |   3630.881|
|  1987| Albania |   3738.933|
|  1992| Albania |   2497.438|
|  1997| Albania |   3193.055|
|  2002| Albania |   4604.212|
|  2007| Albania |   5937.030|
|  1952| Austria |   6137.076|
|  1957| Austria |   8842.598|
|  1962| Austria |  10750.721|
|  1967| Austria |  12834.602|
|  1972| Austria |  16661.626|
|  1977| Austria |  19749.422|
|  1982| Austria |  21597.084|
|  1987| Austria |  23687.826|

``` r
## reordered data set
kable(gap_reordered[1:20, ])
```

|  year| country |  gdpPercap|
|-----:|:--------|----------:|
|  1952| Albania |   1601.056|
|  1957| Albania |   1942.284|
|  1962| Albania |   2312.889|
|  1967| Albania |   2760.197|
|  1972| Albania |   3313.422|
|  1977| Albania |   3533.004|
|  1982| Albania |   3630.881|
|  1987| Albania |   3738.933|
|  1992| Albania |   2497.438|
|  1997| Albania |   3193.055|
|  2002| Albania |   4604.212|
|  2007| Albania |   5937.030|
|  1952| Austria |   6137.076|
|  1957| Austria |   8842.598|
|  1962| Austria |  10750.721|
|  1967| Austria |  12834.602|
|  1972| Austria |  16661.626|
|  1977| Austria |  19749.422|
|  1982| Austria |  21597.084|
|  1987| Austria |  23687.826|

``` r
## arranged data set
kable(gap_arranged[1:20, ])
```

|  year| country                |  gdpPercap|
|-----:|:-----------------------|----------:|
|  1952| Bosnia and Herzegovina |   973.5332|
|  1957| Bosnia and Herzegovina |  1353.9892|
|  1952| Albania                |  1601.0561|
|  1962| Bosnia and Herzegovina |  1709.6837|
|  1957| Albania                |  1942.2842|
|  1952| Turkey                 |  1969.1010|
|  1967| Bosnia and Herzegovina |  2172.3524|
|  1957| Turkey                 |  2218.7543|
|  1962| Albania                |  2312.8890|
|  1962| Turkey                 |  2322.8699|
|  1952| Bulgaria               |  2444.2866|
|  1992| Albania                |  2497.4379|
|  1992| Bosnia and Herzegovina |  2546.7814|
|  1952| Montenegro             |  2647.5856|
|  1967| Albania                |  2760.1969|
|  1967| Turkey                 |  2826.3564|
|  1972| Bosnia and Herzegovina |  2860.1698|
|  1957| Bulgaria               |  3008.6707|
|  1952| Portugal               |  3068.3199|
|  1952| Croatia                |  3119.2365|

From the three tables above, we can see that the output table of the reordered data set is the same as the original table. However, the rows of the arranged data set are ordered according to the values of the specified veriable.

``` r
gap_euro %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "The GDP per capita for all European countries from 1952 to 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
gap_reordered %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "The GDP per capita for all European countries from 1952 to 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-7-2.png)

``` r
gap_arranged %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "The GDP per capita for all European countries from 1952 to 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-7-3.png)

From the three figures above, we can see that the output figure of the arranged data set is the same as the orignial figure. However, the levels of country of the reordered data set are ordered according to the values of gdpPercap.

``` r
## combine reorder() with arrange

gap_reordered_and_arranged <- gap_euro %>% 
  mutate(country = reorder(country, gdpPercap, mean))  %>% 
  arrange(gdpPercap)

kable(gap_reordered_and_arranged[1:20, ])
```

|  year| country                |  gdpPercap|
|-----:|:-----------------------|----------:|
|  1952| Bosnia and Herzegovina |   973.5332|
|  1957| Bosnia and Herzegovina |  1353.9892|
|  1952| Albania                |  1601.0561|
|  1962| Bosnia and Herzegovina |  1709.6837|
|  1957| Albania                |  1942.2842|
|  1952| Turkey                 |  1969.1010|
|  1967| Bosnia and Herzegovina |  2172.3524|
|  1957| Turkey                 |  2218.7543|
|  1962| Albania                |  2312.8890|
|  1962| Turkey                 |  2322.8699|
|  1952| Bulgaria               |  2444.2866|
|  1992| Albania                |  2497.4379|
|  1992| Bosnia and Herzegovina |  2546.7814|
|  1952| Montenegro             |  2647.5856|
|  1967| Albania                |  2760.1969|
|  1967| Turkey                 |  2826.3564|
|  1972| Bosnia and Herzegovina |  2860.1698|
|  1957| Bulgaria               |  3008.6707|
|  1952| Portugal               |  3068.3199|
|  1952| Croatia                |  3119.2365|

``` r
gap_reordered_and_arranged %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "The GDP per capita for all European countries from 1952 to 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-8-1.png)

Now we can see that the rows of the table above are ordered according to the values of gdpPercap. Meanwhile, the levels of country are also ordered according to the mean values of gdpPercap for each country from 1952 to 2007. So arrange() and reorder() are suitable for different situations respectively. Specifically, arrange() is mainly used for displaying a data set using a table while reorder() is mainly used for displaying a data set using a figure.

File I/O
--------

Experiment with one or more of write\_csv()/read\_csv() (and/or TSV friends), saveRDS()/readRDS(), dput()/dget(). Create something new, probably by filtering or grouped-summarization of Gapminder. I highly recommend you fiddle with the factor levels, i.e. make them non-alphabetical (see previous section). Explore whether this survives the round trip of writing to file then reading back in.

**create a new data set**

``` r
gap_cont <- gapminder %>% 
  group_by(year, continent) %>% 
  summarise(medianLifeExp = median(lifeExp)) %>% 
  ungroup()

kable(head(gap_cont))
```

|  year| continent |  medianLifeExp|
|-----:|:----------|--------------:|
|  1952| Africa    |        38.8330|
|  1952| Americas  |        54.7450|
|  1952| Asia      |        44.8690|
|  1952| Europe    |        65.9000|
|  1952| Oceania   |        69.2550|
|  1957| Africa    |        40.5925|

**write\_csv()/read\_csv()**

``` r
## fiddle with the factor levels

gap_cont_csv <- gap_cont %>% 
  mutate(continent = fct_recode(continent, "Africa#$123" = "Africa"))

kable(head(gap_cont_csv))
```

|  year| continent    |  medianLifeExp|
|-----:|:-------------|--------------:|
|  1952| Africa\#$123 |        38.8330|
|  1952| Americas     |        54.7450|
|  1952| Asia         |        44.8690|
|  1952| Europe       |        65.9000|
|  1952| Oceania      |        69.2550|
|  1957| Africa\#$123 |        40.5925|

``` r
## write_csv
write_csv(gap_cont_csv, "gap_cont.csv")
rm(gap_cont_csv)

## read_csv
gap_cont_csv <- read_csv("gap_cont.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   year = col_integer(),
    ##   continent = col_character(),
    ##   medianLifeExp = col_double()
    ## )

``` r
kable(head(gap_cont_csv))
```

|  year| continent    |  medianLifeExp|
|-----:|:-------------|--------------:|
|  1952| Africa\#$123 |        38.8330|
|  1952| Americas     |        54.7450|
|  1952| Asia         |        44.8690|
|  1952| Europe       |        65.9000|
|  1952| Oceania      |        69.2550|
|  1957| Africa\#$123 |        40.5925|

**saveRDS()/readRDS()**

``` r
## fiddle with the factor levels

gap_cont_rds <- gap_cont %>% 
  mutate(continent = fct_recode(continent, "Africa#$123" = "Africa"))

kable(head(gap_cont_rds))
```

|  year| continent    |  medianLifeExp|
|-----:|:-------------|--------------:|
|  1952| Africa\#$123 |        38.8330|
|  1952| Americas     |        54.7450|
|  1952| Asia         |        44.8690|
|  1952| Europe       |        65.9000|
|  1952| Oceania      |        69.2550|
|  1957| Africa\#$123 |        40.5925|

``` r
## saveRDS()
saveRDS(gap_cont_rds, "gap_cont.rds")
rm(gap_cont_rds)

## readRDS()
gap_cont_rds <- readRDS("gap_cont.rds")
kable(head(gap_cont_rds))
```

|  year| continent    |  medianLifeExp|
|-----:|:-------------|--------------:|
|  1952| Africa\#$123 |        38.8330|
|  1952| Americas     |        54.7450|
|  1952| Asia         |        44.8690|
|  1952| Europe       |        65.9000|
|  1952| Oceania      |        69.2550|
|  1957| Africa\#$123 |        40.5925|

**dput()/dget()**

``` r
## fiddle with the factor levels

gap_cont_txt <- gap_cont %>% 
  mutate(continent = fct_recode(continent, "Africa#$123" = "Africa"))

kable(head(gap_cont_txt))
```

|  year| continent    |  medianLifeExp|
|-----:|:-------------|--------------:|
|  1952| Africa\#$123 |        38.8330|
|  1952| Americas     |        54.7450|
|  1952| Asia         |        44.8690|
|  1952| Europe       |        65.9000|
|  1952| Oceania      |        69.2550|
|  1957| Africa\#$123 |        40.5925|

``` r
## dput()
dput(gap_cont_txt, "gap_cont.txt")
rm(gap_cont_txt)

## dget()
gap_cont_txt <- dget("gap_cont.txt")
kable(head(gap_cont_txt))
```

|  year| continent    |  medianLifeExp|
|-----:|:-------------|--------------:|
|  1952| Africa\#$123 |        38.8330|
|  1952| Americas     |        54.7450|
|  1952| Asia         |        44.8690|
|  1952| Europe       |        65.9000|
|  1952| Oceania      |        69.2550|
|  1957| Africa\#$123 |        40.5925|

I created a new data set: the median life expectacy for each continent and each year, modified Africa to Africa\#$123, and then wrote and read the data set using write\_csv()/read\_csv(), saveRDS()/readRDS() and dput()/dget(). From the experiments above, we can see the factor level "Africa\#$123" survived all three round trips of writing to file then reading back in.

Visualization design
--------------------

Remake at least one figure, in light of something you learned in the recent class meetings about visualization design and color. Maybe juxtapose before and after and reflect on the differences. Use the country or continent color scheme that ships with Gapminder. Consult the guest lecture from Tamara Munzner and everything here.

I want to remake a figure in my Homework 02. Here is the original figure.

``` r
originalFigure <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() +
  geom_point() +
  facet_wrap(~ continent)

originalFigure
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-13-1.png)

The new figure is shown below.

``` r
newFigure <- gapminder %>% 
  mutate(country = reorder(country, -1 * pop)) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, fill = continent)) + 
  scale_x_log10(limits = c(200, 65000)) +
  geom_point(pch = 21, show.legend = FALSE) +
  scale_size_continuous(range = c(1,10)) +
  facet_wrap(~ continent)

newFigure
```

    ## Warning: Removed 5 rows containing missing values (geom_point).

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-14-1.png)

Now it looks much better. Different continents are represented with different colors and the population is also reflected with the area of the circle.

Writing figures to file
-----------------------

Use ggsave() to explicitly write a figure to file. Embed it in your report. Things to play around with:

-   Arguments of ggsave(), such as width, height, resolution or text scaling.
-   Various graphics devices, e.g. a vector vs. raster format.
-   Explicit provision of the plot object p via ggsave(..., plot = p). Show a situation in which this actually matters.

**width and height**

``` r
ggsave("figure1.png", width = 15, height = 10, units = "cm")
```

    ## Warning: Removed 5 rows containing missing values (geom_point).

![Figure 1](figure1.png)

``` r
ggsave("figure2.png", width = 30, height = 20, units = "cm")
```

    ## Warning: Removed 5 rows containing missing values (geom_point).

![Figure 2](figure2.png)

**resolution**

``` r
ggsave("figure3.png", dpi = 200)
```

    ## Saving 7 x 5 in image

    ## Warning: Removed 5 rows containing missing values (geom_point).

![Figure 3](figure3.png)

``` r
ggsave("figure4.png", dpi = 300)
```

    ## Saving 7 x 5 in image

    ## Warning: Removed 5 rows containing missing values (geom_point).

![Figure 4](figure4.png)

**plot**

``` r
## By default, ggsave() saves the last plot. So if I want to save another plot, I have to specify the argument plot. 
ggsave("figure5.png", plot = originalFigure)
```

    ## Saving 7 x 5 in image

![Figure 5](figure5.png)
