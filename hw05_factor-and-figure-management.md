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
kable(gap_euro)
```

|  year| country                |   gdpPercap|
|-----:|:-----------------------|-----------:|
|  1952| Albania                |   1601.0561|
|  1957| Albania                |   1942.2842|
|  1962| Albania                |   2312.8890|
|  1967| Albania                |   2760.1969|
|  1972| Albania                |   3313.4222|
|  1977| Albania                |   3533.0039|
|  1982| Albania                |   3630.8807|
|  1987| Albania                |   3738.9327|
|  1992| Albania                |   2497.4379|
|  1997| Albania                |   3193.0546|
|  2002| Albania                |   4604.2117|
|  2007| Albania                |   5937.0295|
|  1952| Austria                |   6137.0765|
|  1957| Austria                |   8842.5980|
|  1962| Austria                |  10750.7211|
|  1967| Austria                |  12834.6024|
|  1972| Austria                |  16661.6256|
|  1977| Austria                |  19749.4223|
|  1982| Austria                |  21597.0836|
|  1987| Austria                |  23687.8261|
|  1992| Austria                |  27042.0187|
|  1997| Austria                |  29095.9207|
|  2002| Austria                |  32417.6077|
|  2007| Austria                |  36126.4927|
|  1952| Belgium                |   8343.1051|
|  1957| Belgium                |   9714.9606|
|  1962| Belgium                |  10991.2068|
|  1967| Belgium                |  13149.0412|
|  1972| Belgium                |  16672.1436|
|  1977| Belgium                |  19117.9745|
|  1982| Belgium                |  20979.8459|
|  1987| Belgium                |  22525.5631|
|  1992| Belgium                |  25575.5707|
|  1997| Belgium                |  27561.1966|
|  2002| Belgium                |  30485.8838|
|  2007| Belgium                |  33692.6051|
|  1952| Bosnia and Herzegovina |    973.5332|
|  1957| Bosnia and Herzegovina |   1353.9892|
|  1962| Bosnia and Herzegovina |   1709.6837|
|  1967| Bosnia and Herzegovina |   2172.3524|
|  1972| Bosnia and Herzegovina |   2860.1698|
|  1977| Bosnia and Herzegovina |   3528.4813|
|  1982| Bosnia and Herzegovina |   4126.6132|
|  1987| Bosnia and Herzegovina |   4314.1148|
|  1992| Bosnia and Herzegovina |   2546.7814|
|  1997| Bosnia and Herzegovina |   4766.3559|
|  2002| Bosnia and Herzegovina |   6018.9752|
|  2007| Bosnia and Herzegovina |   7446.2988|
|  1952| Bulgaria               |   2444.2866|
|  1957| Bulgaria               |   3008.6707|
|  1962| Bulgaria               |   4254.3378|
|  1967| Bulgaria               |   5577.0028|
|  1972| Bulgaria               |   6597.4944|
|  1977| Bulgaria               |   7612.2404|
|  1982| Bulgaria               |   8224.1916|
|  1987| Bulgaria               |   8239.8548|
|  1992| Bulgaria               |   6302.6234|
|  1997| Bulgaria               |   5970.3888|
|  2002| Bulgaria               |   7696.7777|
|  2007| Bulgaria               |  10680.7928|
|  1952| Croatia                |   3119.2365|
|  1957| Croatia                |   4338.2316|
|  1962| Croatia                |   5477.8900|
|  1967| Croatia                |   6960.2979|
|  1972| Croatia                |   9164.0901|
|  1977| Croatia                |  11305.3852|
|  1982| Croatia                |  13221.8218|
|  1987| Croatia                |  13822.5839|
|  1992| Croatia                |   8447.7949|
|  1997| Croatia                |   9875.6045|
|  2002| Croatia                |  11628.3890|
|  2007| Croatia                |  14619.2227|
|  1952| Czech Republic         |   6876.1403|
|  1957| Czech Republic         |   8256.3439|
|  1962| Czech Republic         |  10136.8671|
|  1967| Czech Republic         |  11399.4449|
|  1972| Czech Republic         |  13108.4536|
|  1977| Czech Republic         |  14800.1606|
|  1982| Czech Republic         |  15377.2285|
|  1987| Czech Republic         |  16310.4434|
|  1992| Czech Republic         |  14297.0212|
|  1997| Czech Republic         |  16048.5142|
|  2002| Czech Republic         |  17596.2102|
|  2007| Czech Republic         |  22833.3085|
|  1952| Denmark                |   9692.3852|
|  1957| Denmark                |  11099.6593|
|  1962| Denmark                |  13583.3135|
|  1967| Denmark                |  15937.2112|
|  1972| Denmark                |  18866.2072|
|  1977| Denmark                |  20422.9015|
|  1982| Denmark                |  21688.0405|
|  1987| Denmark                |  25116.1758|
|  1992| Denmark                |  26406.7399|
|  1997| Denmark                |  29804.3457|
|  2002| Denmark                |  32166.5001|
|  2007| Denmark                |  35278.4187|
|  1952| Finland                |   6424.5191|
|  1957| Finland                |   7545.4154|
|  1962| Finland                |   9371.8426|
|  1967| Finland                |  10921.6363|
|  1972| Finland                |  14358.8759|
|  1977| Finland                |  15605.4228|
|  1982| Finland                |  18533.1576|
|  1987| Finland                |  21141.0122|
|  1992| Finland                |  20647.1650|
|  1997| Finland                |  23723.9502|
|  2002| Finland                |  28204.5906|
|  2007| Finland                |  33207.0844|
|  1952| France                 |   7029.8093|
|  1957| France                 |   8662.8349|
|  1962| France                 |  10560.4855|
|  1967| France                 |  12999.9177|
|  1972| France                 |  16107.1917|
|  1977| France                 |  18292.6351|
|  1982| France                 |  20293.8975|
|  1987| France                 |  22066.4421|
|  1992| France                 |  24703.7961|
|  1997| France                 |  25889.7849|
|  2002| France                 |  28926.0323|
|  2007| France                 |  30470.0167|
|  1952| Germany                |   7144.1144|
|  1957| Germany                |  10187.8267|
|  1962| Germany                |  12902.4629|
|  1967| Germany                |  14745.6256|
|  1972| Germany                |  18016.1803|
|  1977| Germany                |  20512.9212|
|  1982| Germany                |  22031.5327|
|  1987| Germany                |  24639.1857|
|  1992| Germany                |  26505.3032|
|  1997| Germany                |  27788.8842|
|  2002| Germany                |  30035.8020|
|  2007| Germany                |  32170.3744|
|  1952| Greece                 |   3530.6901|
|  1957| Greece                 |   4916.2999|
|  1962| Greece                 |   6017.1907|
|  1967| Greece                 |   8513.0970|
|  1972| Greece                 |  12724.8296|
|  1977| Greece                 |  14195.5243|
|  1982| Greece                 |  15268.4209|
|  1987| Greece                 |  16120.5284|
|  1992| Greece                 |  17541.4963|
|  1997| Greece                 |  18747.6981|
|  2002| Greece                 |  22514.2548|
|  2007| Greece                 |  27538.4119|
|  1952| Hungary                |   5263.6738|
|  1957| Hungary                |   6040.1800|
|  1962| Hungary                |   7550.3599|
|  1967| Hungary                |   9326.6447|
|  1972| Hungary                |  10168.6561|
|  1977| Hungary                |  11674.8374|
|  1982| Hungary                |  12545.9907|
|  1987| Hungary                |  12986.4800|
|  1992| Hungary                |  10535.6285|
|  1997| Hungary                |  11712.7768|
|  2002| Hungary                |  14843.9356|
|  2007| Hungary                |  18008.9444|
|  1952| Iceland                |   7267.6884|
|  1957| Iceland                |   9244.0014|
|  1962| Iceland                |  10350.1591|
|  1967| Iceland                |  13319.8957|
|  1972| Iceland                |  15798.0636|
|  1977| Iceland                |  19654.9625|
|  1982| Iceland                |  23269.6075|
|  1987| Iceland                |  26923.2063|
|  1992| Iceland                |  25144.3920|
|  1997| Iceland                |  28061.0997|
|  2002| Iceland                |  31163.2020|
|  2007| Iceland                |  36180.7892|
|  1952| Ireland                |   5210.2803|
|  1957| Ireland                |   5599.0779|
|  1962| Ireland                |   6631.5973|
|  1967| Ireland                |   7655.5690|
|  1972| Ireland                |   9530.7729|
|  1977| Ireland                |  11150.9811|
|  1982| Ireland                |  12618.3214|
|  1987| Ireland                |  13872.8665|
|  1992| Ireland                |  17558.8155|
|  1997| Ireland                |  24521.9471|
|  2002| Ireland                |  34077.0494|
|  2007| Ireland                |  40675.9964|
|  1952| Italy                  |   4931.4042|
|  1957| Italy                  |   6248.6562|
|  1962| Italy                  |   8243.5823|
|  1967| Italy                  |  10022.4013|
|  1972| Italy                  |  12269.2738|
|  1977| Italy                  |  14255.9847|
|  1982| Italy                  |  16537.4835|
|  1987| Italy                  |  19207.2348|
|  1992| Italy                  |  22013.6449|
|  1997| Italy                  |  24675.0245|
|  2002| Italy                  |  27968.0982|
|  2007| Italy                  |  28569.7197|
|  1952| Montenegro             |   2647.5856|
|  1957| Montenegro             |   3682.2599|
|  1962| Montenegro             |   4649.5938|
|  1967| Montenegro             |   5907.8509|
|  1972| Montenegro             |   7778.4140|
|  1977| Montenegro             |   9595.9299|
|  1982| Montenegro             |  11222.5876|
|  1987| Montenegro             |  11732.5102|
|  1992| Montenegro             |   7003.3390|
|  1997| Montenegro             |   6465.6133|
|  2002| Montenegro             |   6557.1943|
|  2007| Montenegro             |   9253.8961|
|  1952| Netherlands            |   8941.5719|
|  1957| Netherlands            |  11276.1934|
|  1962| Netherlands            |  12790.8496|
|  1967| Netherlands            |  15363.2514|
|  1972| Netherlands            |  18794.7457|
|  1977| Netherlands            |  21209.0592|
|  1982| Netherlands            |  21399.4605|
|  1987| Netherlands            |  23651.3236|
|  1992| Netherlands            |  26790.9496|
|  1997| Netherlands            |  30246.1306|
|  2002| Netherlands            |  33724.7578|
|  2007| Netherlands            |  36797.9333|
|  1952| Norway                 |  10095.4217|
|  1957| Norway                 |  11653.9730|
|  1962| Norway                 |  13450.4015|
|  1967| Norway                 |  16361.8765|
|  1972| Norway                 |  18965.0555|
|  1977| Norway                 |  23311.3494|
|  1982| Norway                 |  26298.6353|
|  1987| Norway                 |  31540.9748|
|  1992| Norway                 |  33965.6611|
|  1997| Norway                 |  41283.1643|
|  2002| Norway                 |  44683.9753|
|  2007| Norway                 |  49357.1902|
|  1952| Poland                 |   4029.3297|
|  1957| Poland                 |   4734.2530|
|  1962| Poland                 |   5338.7521|
|  1967| Poland                 |   6557.1528|
|  1972| Poland                 |   8006.5070|
|  1977| Poland                 |   9508.1415|
|  1982| Poland                 |   8451.5310|
|  1987| Poland                 |   9082.3512|
|  1992| Poland                 |   7738.8812|
|  1997| Poland                 |  10159.5837|
|  2002| Poland                 |  12002.2391|
|  2007| Poland                 |  15389.9247|
|  1952| Portugal               |   3068.3199|
|  1957| Portugal               |   3774.5717|
|  1962| Portugal               |   4727.9549|
|  1967| Portugal               |   6361.5180|
|  1972| Portugal               |   9022.2474|
|  1977| Portugal               |  10172.4857|
|  1982| Portugal               |  11753.8429|
|  1987| Portugal               |  13039.3088|
|  1992| Portugal               |  16207.2666|
|  1997| Portugal               |  17641.0316|
|  2002| Portugal               |  19970.9079|
|  2007| Portugal               |  20509.6478|
|  1952| Romania                |   3144.6132|
|  1957| Romania                |   3943.3702|
|  1962| Romania                |   4734.9976|
|  1967| Romania                |   6470.8665|
|  1972| Romania                |   8011.4144|
|  1977| Romania                |   9356.3972|
|  1982| Romania                |   9605.3141|
|  1987| Romania                |   9696.2733|
|  1992| Romania                |   6598.4099|
|  1997| Romania                |   7346.5476|
|  2002| Romania                |   7885.3601|
|  2007| Romania                |  10808.4756|
|  1952| Serbia                 |   3581.4594|
|  1957| Serbia                 |   4981.0909|
|  1962| Serbia                 |   6289.6292|
|  1967| Serbia                 |   7991.7071|
|  1972| Serbia                 |  10522.0675|
|  1977| Serbia                 |  12980.6696|
|  1982| Serbia                 |  15181.0927|
|  1987| Serbia                 |  15870.8785|
|  1992| Serbia                 |   9325.0682|
|  1997| Serbia                 |   7914.3203|
|  2002| Serbia                 |   7236.0753|
|  2007| Serbia                 |   9786.5347|
|  1952| Slovak Republic        |   5074.6591|
|  1957| Slovak Republic        |   6093.2630|
|  1962| Slovak Republic        |   7481.1076|
|  1967| Slovak Republic        |   8412.9024|
|  1972| Slovak Republic        |   9674.1676|
|  1977| Slovak Republic        |  10922.6640|
|  1982| Slovak Republic        |  11348.5459|
|  1987| Slovak Republic        |  12037.2676|
|  1992| Slovak Republic        |   9498.4677|
|  1997| Slovak Republic        |  12126.2306|
|  2002| Slovak Republic        |  13638.7784|
|  2007| Slovak Republic        |  18678.3144|
|  1952| Slovenia               |   4215.0417|
|  1957| Slovenia               |   5862.2766|
|  1962| Slovenia               |   7402.3034|
|  1967| Slovenia               |   9405.4894|
|  1972| Slovenia               |  12383.4862|
|  1977| Slovenia               |  15277.0302|
|  1982| Slovenia               |  17866.7218|
|  1987| Slovenia               |  18678.5349|
|  1992| Slovenia               |  14214.7168|
|  1997| Slovenia               |  17161.1073|
|  2002| Slovenia               |  20660.0194|
|  2007| Slovenia               |  25768.2576|
|  1952| Spain                  |   3834.0347|
|  1957| Spain                  |   4564.8024|
|  1962| Spain                  |   5693.8439|
|  1967| Spain                  |   7993.5123|
|  1972| Spain                  |  10638.7513|
|  1977| Spain                  |  13236.9212|
|  1982| Spain                  |  13926.1700|
|  1987| Spain                  |  15764.9831|
|  1992| Spain                  |  18603.0645|
|  1997| Spain                  |  20445.2990|
|  2002| Spain                  |  24835.4717|
|  2007| Spain                  |  28821.0637|
|  1952| Sweden                 |   8527.8447|
|  1957| Sweden                 |   9911.8782|
|  1962| Sweden                 |  12329.4419|
|  1967| Sweden                 |  15258.2970|
|  1972| Sweden                 |  17832.0246|
|  1977| Sweden                 |  18855.7252|
|  1982| Sweden                 |  20667.3812|
|  1987| Sweden                 |  23586.9293|
|  1992| Sweden                 |  23880.0168|
|  1997| Sweden                 |  25266.5950|
|  2002| Sweden                 |  29341.6309|
|  2007| Sweden                 |  33859.7484|
|  1952| Switzerland            |  14734.2327|
|  1957| Switzerland            |  17909.4897|
|  1962| Switzerland            |  20431.0927|
|  1967| Switzerland            |  22966.1443|
|  1972| Switzerland            |  27195.1130|
|  1977| Switzerland            |  26982.2905|
|  1982| Switzerland            |  28397.7151|
|  1987| Switzerland            |  30281.7046|
|  1992| Switzerland            |  31871.5303|
|  1997| Switzerland            |  32135.3230|
|  2002| Switzerland            |  34480.9577|
|  2007| Switzerland            |  37506.4191|
|  1952| Turkey                 |   1969.1010|
|  1957| Turkey                 |   2218.7543|
|  1962| Turkey                 |   2322.8699|
|  1967| Turkey                 |   2826.3564|
|  1972| Turkey                 |   3450.6964|
|  1977| Turkey                 |   4269.1223|
|  1982| Turkey                 |   4241.3563|
|  1987| Turkey                 |   5089.0437|
|  1992| Turkey                 |   5678.3483|
|  1997| Turkey                 |   6601.4299|
|  2002| Turkey                 |   6508.0857|
|  2007| Turkey                 |   8458.2764|
|  1952| United Kingdom         |   9979.5085|
|  1957| United Kingdom         |  11283.1779|
|  1962| United Kingdom         |  12477.1771|
|  1967| United Kingdom         |  14142.8509|
|  1972| United Kingdom         |  15895.1164|
|  1977| United Kingdom         |  17428.7485|
|  1982| United Kingdom         |  18232.4245|
|  1987| United Kingdom         |  21664.7877|
|  1992| United Kingdom         |  22705.0925|
|  1997| United Kingdom         |  26074.5314|
|  2002| United Kingdom         |  29478.9992|
|  2007| United Kingdom         |  33203.2613|

``` r
kable(gap_reordered)
```

|  year| country                |   gdpPercap|
|-----:|:-----------------------|-----------:|
|  1952| Albania                |   1601.0561|
|  1957| Albania                |   1942.2842|
|  1962| Albania                |   2312.8890|
|  1967| Albania                |   2760.1969|
|  1972| Albania                |   3313.4222|
|  1977| Albania                |   3533.0039|
|  1982| Albania                |   3630.8807|
|  1987| Albania                |   3738.9327|
|  1992| Albania                |   2497.4379|
|  1997| Albania                |   3193.0546|
|  2002| Albania                |   4604.2117|
|  2007| Albania                |   5937.0295|
|  1952| Austria                |   6137.0765|
|  1957| Austria                |   8842.5980|
|  1962| Austria                |  10750.7211|
|  1967| Austria                |  12834.6024|
|  1972| Austria                |  16661.6256|
|  1977| Austria                |  19749.4223|
|  1982| Austria                |  21597.0836|
|  1987| Austria                |  23687.8261|
|  1992| Austria                |  27042.0187|
|  1997| Austria                |  29095.9207|
|  2002| Austria                |  32417.6077|
|  2007| Austria                |  36126.4927|
|  1952| Belgium                |   8343.1051|
|  1957| Belgium                |   9714.9606|
|  1962| Belgium                |  10991.2068|
|  1967| Belgium                |  13149.0412|
|  1972| Belgium                |  16672.1436|
|  1977| Belgium                |  19117.9745|
|  1982| Belgium                |  20979.8459|
|  1987| Belgium                |  22525.5631|
|  1992| Belgium                |  25575.5707|
|  1997| Belgium                |  27561.1966|
|  2002| Belgium                |  30485.8838|
|  2007| Belgium                |  33692.6051|
|  1952| Bosnia and Herzegovina |    973.5332|
|  1957| Bosnia and Herzegovina |   1353.9892|
|  1962| Bosnia and Herzegovina |   1709.6837|
|  1967| Bosnia and Herzegovina |   2172.3524|
|  1972| Bosnia and Herzegovina |   2860.1698|
|  1977| Bosnia and Herzegovina |   3528.4813|
|  1982| Bosnia and Herzegovina |   4126.6132|
|  1987| Bosnia and Herzegovina |   4314.1148|
|  1992| Bosnia and Herzegovina |   2546.7814|
|  1997| Bosnia and Herzegovina |   4766.3559|
|  2002| Bosnia and Herzegovina |   6018.9752|
|  2007| Bosnia and Herzegovina |   7446.2988|
|  1952| Bulgaria               |   2444.2866|
|  1957| Bulgaria               |   3008.6707|
|  1962| Bulgaria               |   4254.3378|
|  1967| Bulgaria               |   5577.0028|
|  1972| Bulgaria               |   6597.4944|
|  1977| Bulgaria               |   7612.2404|
|  1982| Bulgaria               |   8224.1916|
|  1987| Bulgaria               |   8239.8548|
|  1992| Bulgaria               |   6302.6234|
|  1997| Bulgaria               |   5970.3888|
|  2002| Bulgaria               |   7696.7777|
|  2007| Bulgaria               |  10680.7928|
|  1952| Croatia                |   3119.2365|
|  1957| Croatia                |   4338.2316|
|  1962| Croatia                |   5477.8900|
|  1967| Croatia                |   6960.2979|
|  1972| Croatia                |   9164.0901|
|  1977| Croatia                |  11305.3852|
|  1982| Croatia                |  13221.8218|
|  1987| Croatia                |  13822.5839|
|  1992| Croatia                |   8447.7949|
|  1997| Croatia                |   9875.6045|
|  2002| Croatia                |  11628.3890|
|  2007| Croatia                |  14619.2227|
|  1952| Czech Republic         |   6876.1403|
|  1957| Czech Republic         |   8256.3439|
|  1962| Czech Republic         |  10136.8671|
|  1967| Czech Republic         |  11399.4449|
|  1972| Czech Republic         |  13108.4536|
|  1977| Czech Republic         |  14800.1606|
|  1982| Czech Republic         |  15377.2285|
|  1987| Czech Republic         |  16310.4434|
|  1992| Czech Republic         |  14297.0212|
|  1997| Czech Republic         |  16048.5142|
|  2002| Czech Republic         |  17596.2102|
|  2007| Czech Republic         |  22833.3085|
|  1952| Denmark                |   9692.3852|
|  1957| Denmark                |  11099.6593|
|  1962| Denmark                |  13583.3135|
|  1967| Denmark                |  15937.2112|
|  1972| Denmark                |  18866.2072|
|  1977| Denmark                |  20422.9015|
|  1982| Denmark                |  21688.0405|
|  1987| Denmark                |  25116.1758|
|  1992| Denmark                |  26406.7399|
|  1997| Denmark                |  29804.3457|
|  2002| Denmark                |  32166.5001|
|  2007| Denmark                |  35278.4187|
|  1952| Finland                |   6424.5191|
|  1957| Finland                |   7545.4154|
|  1962| Finland                |   9371.8426|
|  1967| Finland                |  10921.6363|
|  1972| Finland                |  14358.8759|
|  1977| Finland                |  15605.4228|
|  1982| Finland                |  18533.1576|
|  1987| Finland                |  21141.0122|
|  1992| Finland                |  20647.1650|
|  1997| Finland                |  23723.9502|
|  2002| Finland                |  28204.5906|
|  2007| Finland                |  33207.0844|
|  1952| France                 |   7029.8093|
|  1957| France                 |   8662.8349|
|  1962| France                 |  10560.4855|
|  1967| France                 |  12999.9177|
|  1972| France                 |  16107.1917|
|  1977| France                 |  18292.6351|
|  1982| France                 |  20293.8975|
|  1987| France                 |  22066.4421|
|  1992| France                 |  24703.7961|
|  1997| France                 |  25889.7849|
|  2002| France                 |  28926.0323|
|  2007| France                 |  30470.0167|
|  1952| Germany                |   7144.1144|
|  1957| Germany                |  10187.8267|
|  1962| Germany                |  12902.4629|
|  1967| Germany                |  14745.6256|
|  1972| Germany                |  18016.1803|
|  1977| Germany                |  20512.9212|
|  1982| Germany                |  22031.5327|
|  1987| Germany                |  24639.1857|
|  1992| Germany                |  26505.3032|
|  1997| Germany                |  27788.8842|
|  2002| Germany                |  30035.8020|
|  2007| Germany                |  32170.3744|
|  1952| Greece                 |   3530.6901|
|  1957| Greece                 |   4916.2999|
|  1962| Greece                 |   6017.1907|
|  1967| Greece                 |   8513.0970|
|  1972| Greece                 |  12724.8296|
|  1977| Greece                 |  14195.5243|
|  1982| Greece                 |  15268.4209|
|  1987| Greece                 |  16120.5284|
|  1992| Greece                 |  17541.4963|
|  1997| Greece                 |  18747.6981|
|  2002| Greece                 |  22514.2548|
|  2007| Greece                 |  27538.4119|
|  1952| Hungary                |   5263.6738|
|  1957| Hungary                |   6040.1800|
|  1962| Hungary                |   7550.3599|
|  1967| Hungary                |   9326.6447|
|  1972| Hungary                |  10168.6561|
|  1977| Hungary                |  11674.8374|
|  1982| Hungary                |  12545.9907|
|  1987| Hungary                |  12986.4800|
|  1992| Hungary                |  10535.6285|
|  1997| Hungary                |  11712.7768|
|  2002| Hungary                |  14843.9356|
|  2007| Hungary                |  18008.9444|
|  1952| Iceland                |   7267.6884|
|  1957| Iceland                |   9244.0014|
|  1962| Iceland                |  10350.1591|
|  1967| Iceland                |  13319.8957|
|  1972| Iceland                |  15798.0636|
|  1977| Iceland                |  19654.9625|
|  1982| Iceland                |  23269.6075|
|  1987| Iceland                |  26923.2063|
|  1992| Iceland                |  25144.3920|
|  1997| Iceland                |  28061.0997|
|  2002| Iceland                |  31163.2020|
|  2007| Iceland                |  36180.7892|
|  1952| Ireland                |   5210.2803|
|  1957| Ireland                |   5599.0779|
|  1962| Ireland                |   6631.5973|
|  1967| Ireland                |   7655.5690|
|  1972| Ireland                |   9530.7729|
|  1977| Ireland                |  11150.9811|
|  1982| Ireland                |  12618.3214|
|  1987| Ireland                |  13872.8665|
|  1992| Ireland                |  17558.8155|
|  1997| Ireland                |  24521.9471|
|  2002| Ireland                |  34077.0494|
|  2007| Ireland                |  40675.9964|
|  1952| Italy                  |   4931.4042|
|  1957| Italy                  |   6248.6562|
|  1962| Italy                  |   8243.5823|
|  1967| Italy                  |  10022.4013|
|  1972| Italy                  |  12269.2738|
|  1977| Italy                  |  14255.9847|
|  1982| Italy                  |  16537.4835|
|  1987| Italy                  |  19207.2348|
|  1992| Italy                  |  22013.6449|
|  1997| Italy                  |  24675.0245|
|  2002| Italy                  |  27968.0982|
|  2007| Italy                  |  28569.7197|
|  1952| Montenegro             |   2647.5856|
|  1957| Montenegro             |   3682.2599|
|  1962| Montenegro             |   4649.5938|
|  1967| Montenegro             |   5907.8509|
|  1972| Montenegro             |   7778.4140|
|  1977| Montenegro             |   9595.9299|
|  1982| Montenegro             |  11222.5876|
|  1987| Montenegro             |  11732.5102|
|  1992| Montenegro             |   7003.3390|
|  1997| Montenegro             |   6465.6133|
|  2002| Montenegro             |   6557.1943|
|  2007| Montenegro             |   9253.8961|
|  1952| Netherlands            |   8941.5719|
|  1957| Netherlands            |  11276.1934|
|  1962| Netherlands            |  12790.8496|
|  1967| Netherlands            |  15363.2514|
|  1972| Netherlands            |  18794.7457|
|  1977| Netherlands            |  21209.0592|
|  1982| Netherlands            |  21399.4605|
|  1987| Netherlands            |  23651.3236|
|  1992| Netherlands            |  26790.9496|
|  1997| Netherlands            |  30246.1306|
|  2002| Netherlands            |  33724.7578|
|  2007| Netherlands            |  36797.9333|
|  1952| Norway                 |  10095.4217|
|  1957| Norway                 |  11653.9730|
|  1962| Norway                 |  13450.4015|
|  1967| Norway                 |  16361.8765|
|  1972| Norway                 |  18965.0555|
|  1977| Norway                 |  23311.3494|
|  1982| Norway                 |  26298.6353|
|  1987| Norway                 |  31540.9748|
|  1992| Norway                 |  33965.6611|
|  1997| Norway                 |  41283.1643|
|  2002| Norway                 |  44683.9753|
|  2007| Norway                 |  49357.1902|
|  1952| Poland                 |   4029.3297|
|  1957| Poland                 |   4734.2530|
|  1962| Poland                 |   5338.7521|
|  1967| Poland                 |   6557.1528|
|  1972| Poland                 |   8006.5070|
|  1977| Poland                 |   9508.1415|
|  1982| Poland                 |   8451.5310|
|  1987| Poland                 |   9082.3512|
|  1992| Poland                 |   7738.8812|
|  1997| Poland                 |  10159.5837|
|  2002| Poland                 |  12002.2391|
|  2007| Poland                 |  15389.9247|
|  1952| Portugal               |   3068.3199|
|  1957| Portugal               |   3774.5717|
|  1962| Portugal               |   4727.9549|
|  1967| Portugal               |   6361.5180|
|  1972| Portugal               |   9022.2474|
|  1977| Portugal               |  10172.4857|
|  1982| Portugal               |  11753.8429|
|  1987| Portugal               |  13039.3088|
|  1992| Portugal               |  16207.2666|
|  1997| Portugal               |  17641.0316|
|  2002| Portugal               |  19970.9079|
|  2007| Portugal               |  20509.6478|
|  1952| Romania                |   3144.6132|
|  1957| Romania                |   3943.3702|
|  1962| Romania                |   4734.9976|
|  1967| Romania                |   6470.8665|
|  1972| Romania                |   8011.4144|
|  1977| Romania                |   9356.3972|
|  1982| Romania                |   9605.3141|
|  1987| Romania                |   9696.2733|
|  1992| Romania                |   6598.4099|
|  1997| Romania                |   7346.5476|
|  2002| Romania                |   7885.3601|
|  2007| Romania                |  10808.4756|
|  1952| Serbia                 |   3581.4594|
|  1957| Serbia                 |   4981.0909|
|  1962| Serbia                 |   6289.6292|
|  1967| Serbia                 |   7991.7071|
|  1972| Serbia                 |  10522.0675|
|  1977| Serbia                 |  12980.6696|
|  1982| Serbia                 |  15181.0927|
|  1987| Serbia                 |  15870.8785|
|  1992| Serbia                 |   9325.0682|
|  1997| Serbia                 |   7914.3203|
|  2002| Serbia                 |   7236.0753|
|  2007| Serbia                 |   9786.5347|
|  1952| Slovak Republic        |   5074.6591|
|  1957| Slovak Republic        |   6093.2630|
|  1962| Slovak Republic        |   7481.1076|
|  1967| Slovak Republic        |   8412.9024|
|  1972| Slovak Republic        |   9674.1676|
|  1977| Slovak Republic        |  10922.6640|
|  1982| Slovak Republic        |  11348.5459|
|  1987| Slovak Republic        |  12037.2676|
|  1992| Slovak Republic        |   9498.4677|
|  1997| Slovak Republic        |  12126.2306|
|  2002| Slovak Republic        |  13638.7784|
|  2007| Slovak Republic        |  18678.3144|
|  1952| Slovenia               |   4215.0417|
|  1957| Slovenia               |   5862.2766|
|  1962| Slovenia               |   7402.3034|
|  1967| Slovenia               |   9405.4894|
|  1972| Slovenia               |  12383.4862|
|  1977| Slovenia               |  15277.0302|
|  1982| Slovenia               |  17866.7218|
|  1987| Slovenia               |  18678.5349|
|  1992| Slovenia               |  14214.7168|
|  1997| Slovenia               |  17161.1073|
|  2002| Slovenia               |  20660.0194|
|  2007| Slovenia               |  25768.2576|
|  1952| Spain                  |   3834.0347|
|  1957| Spain                  |   4564.8024|
|  1962| Spain                  |   5693.8439|
|  1967| Spain                  |   7993.5123|
|  1972| Spain                  |  10638.7513|
|  1977| Spain                  |  13236.9212|
|  1982| Spain                  |  13926.1700|
|  1987| Spain                  |  15764.9831|
|  1992| Spain                  |  18603.0645|
|  1997| Spain                  |  20445.2990|
|  2002| Spain                  |  24835.4717|
|  2007| Spain                  |  28821.0637|
|  1952| Sweden                 |   8527.8447|
|  1957| Sweden                 |   9911.8782|
|  1962| Sweden                 |  12329.4419|
|  1967| Sweden                 |  15258.2970|
|  1972| Sweden                 |  17832.0246|
|  1977| Sweden                 |  18855.7252|
|  1982| Sweden                 |  20667.3812|
|  1987| Sweden                 |  23586.9293|
|  1992| Sweden                 |  23880.0168|
|  1997| Sweden                 |  25266.5950|
|  2002| Sweden                 |  29341.6309|
|  2007| Sweden                 |  33859.7484|
|  1952| Switzerland            |  14734.2327|
|  1957| Switzerland            |  17909.4897|
|  1962| Switzerland            |  20431.0927|
|  1967| Switzerland            |  22966.1443|
|  1972| Switzerland            |  27195.1130|
|  1977| Switzerland            |  26982.2905|
|  1982| Switzerland            |  28397.7151|
|  1987| Switzerland            |  30281.7046|
|  1992| Switzerland            |  31871.5303|
|  1997| Switzerland            |  32135.3230|
|  2002| Switzerland            |  34480.9577|
|  2007| Switzerland            |  37506.4191|
|  1952| Turkey                 |   1969.1010|
|  1957| Turkey                 |   2218.7543|
|  1962| Turkey                 |   2322.8699|
|  1967| Turkey                 |   2826.3564|
|  1972| Turkey                 |   3450.6964|
|  1977| Turkey                 |   4269.1223|
|  1982| Turkey                 |   4241.3563|
|  1987| Turkey                 |   5089.0437|
|  1992| Turkey                 |   5678.3483|
|  1997| Turkey                 |   6601.4299|
|  2002| Turkey                 |   6508.0857|
|  2007| Turkey                 |   8458.2764|
|  1952| United Kingdom         |   9979.5085|
|  1957| United Kingdom         |  11283.1779|
|  1962| United Kingdom         |  12477.1771|
|  1967| United Kingdom         |  14142.8509|
|  1972| United Kingdom         |  15895.1164|
|  1977| United Kingdom         |  17428.7485|
|  1982| United Kingdom         |  18232.4245|
|  1987| United Kingdom         |  21664.7877|
|  1992| United Kingdom         |  22705.0925|
|  1997| United Kingdom         |  26074.5314|
|  2002| United Kingdom         |  29478.9992|
|  2007| United Kingdom         |  33203.2613|

``` r
kable(gap_arranged)
```

|  year| country                |   gdpPercap|
|-----:|:-----------------------|-----------:|
|  1952| Bosnia and Herzegovina |    973.5332|
|  1957| Bosnia and Herzegovina |   1353.9892|
|  1952| Albania                |   1601.0561|
|  1962| Bosnia and Herzegovina |   1709.6837|
|  1957| Albania                |   1942.2842|
|  1952| Turkey                 |   1969.1010|
|  1967| Bosnia and Herzegovina |   2172.3524|
|  1957| Turkey                 |   2218.7543|
|  1962| Albania                |   2312.8890|
|  1962| Turkey                 |   2322.8699|
|  1952| Bulgaria               |   2444.2866|
|  1992| Albania                |   2497.4379|
|  1992| Bosnia and Herzegovina |   2546.7814|
|  1952| Montenegro             |   2647.5856|
|  1967| Albania                |   2760.1969|
|  1967| Turkey                 |   2826.3564|
|  1972| Bosnia and Herzegovina |   2860.1698|
|  1957| Bulgaria               |   3008.6707|
|  1952| Portugal               |   3068.3199|
|  1952| Croatia                |   3119.2365|
|  1952| Romania                |   3144.6132|
|  1997| Albania                |   3193.0546|
|  1972| Albania                |   3313.4222|
|  1972| Turkey                 |   3450.6964|
|  1977| Bosnia and Herzegovina |   3528.4813|
|  1952| Greece                 |   3530.6901|
|  1977| Albania                |   3533.0039|
|  1952| Serbia                 |   3581.4594|
|  1982| Albania                |   3630.8807|
|  1957| Montenegro             |   3682.2599|
|  1987| Albania                |   3738.9327|
|  1957| Portugal               |   3774.5717|
|  1952| Spain                  |   3834.0347|
|  1957| Romania                |   3943.3702|
|  1952| Poland                 |   4029.3297|
|  1982| Bosnia and Herzegovina |   4126.6132|
|  1952| Slovenia               |   4215.0417|
|  1982| Turkey                 |   4241.3563|
|  1962| Bulgaria               |   4254.3378|
|  1977| Turkey                 |   4269.1223|
|  1987| Bosnia and Herzegovina |   4314.1148|
|  1957| Croatia                |   4338.2316|
|  1957| Spain                  |   4564.8024|
|  2002| Albania                |   4604.2117|
|  1962| Montenegro             |   4649.5938|
|  1962| Portugal               |   4727.9549|
|  1957| Poland                 |   4734.2530|
|  1962| Romania                |   4734.9976|
|  1997| Bosnia and Herzegovina |   4766.3559|
|  1957| Greece                 |   4916.2999|
|  1952| Italy                  |   4931.4042|
|  1957| Serbia                 |   4981.0909|
|  1952| Slovak Republic        |   5074.6591|
|  1987| Turkey                 |   5089.0437|
|  1952| Ireland                |   5210.2803|
|  1952| Hungary                |   5263.6738|
|  1962| Poland                 |   5338.7521|
|  1962| Croatia                |   5477.8900|
|  1967| Bulgaria               |   5577.0028|
|  1957| Ireland                |   5599.0779|
|  1992| Turkey                 |   5678.3483|
|  1962| Spain                  |   5693.8439|
|  1957| Slovenia               |   5862.2766|
|  1967| Montenegro             |   5907.8509|
|  2007| Albania                |   5937.0295|
|  1997| Bulgaria               |   5970.3888|
|  1962| Greece                 |   6017.1907|
|  2002| Bosnia and Herzegovina |   6018.9752|
|  1957| Hungary                |   6040.1800|
|  1957| Slovak Republic        |   6093.2630|
|  1952| Austria                |   6137.0765|
|  1957| Italy                  |   6248.6562|
|  1962| Serbia                 |   6289.6292|
|  1992| Bulgaria               |   6302.6234|
|  1967| Portugal               |   6361.5180|
|  1952| Finland                |   6424.5191|
|  1997| Montenegro             |   6465.6133|
|  1967| Romania                |   6470.8665|
|  2002| Turkey                 |   6508.0857|
|  1967| Poland                 |   6557.1528|
|  2002| Montenegro             |   6557.1943|
|  1972| Bulgaria               |   6597.4944|
|  1992| Romania                |   6598.4099|
|  1997| Turkey                 |   6601.4299|
|  1962| Ireland                |   6631.5973|
|  1952| Czech Republic         |   6876.1403|
|  1967| Croatia                |   6960.2979|
|  1992| Montenegro             |   7003.3390|
|  1952| France                 |   7029.8093|
|  1952| Germany                |   7144.1144|
|  2002| Serbia                 |   7236.0753|
|  1952| Iceland                |   7267.6884|
|  1997| Romania                |   7346.5476|
|  1962| Slovenia               |   7402.3034|
|  2007| Bosnia and Herzegovina |   7446.2988|
|  1962| Slovak Republic        |   7481.1076|
|  1957| Finland                |   7545.4154|
|  1962| Hungary                |   7550.3599|
|  1977| Bulgaria               |   7612.2404|
|  1967| Ireland                |   7655.5690|
|  2002| Bulgaria               |   7696.7777|
|  1992| Poland                 |   7738.8812|
|  1972| Montenegro             |   7778.4140|
|  2002| Romania                |   7885.3601|
|  1997| Serbia                 |   7914.3203|
|  1967| Serbia                 |   7991.7071|
|  1967| Spain                  |   7993.5123|
|  1972| Poland                 |   8006.5070|
|  1972| Romania                |   8011.4144|
|  1982| Bulgaria               |   8224.1916|
|  1987| Bulgaria               |   8239.8548|
|  1962| Italy                  |   8243.5823|
|  1957| Czech Republic         |   8256.3439|
|  1952| Belgium                |   8343.1051|
|  1967| Slovak Republic        |   8412.9024|
|  1992| Croatia                |   8447.7949|
|  1982| Poland                 |   8451.5310|
|  2007| Turkey                 |   8458.2764|
|  1967| Greece                 |   8513.0970|
|  1952| Sweden                 |   8527.8447|
|  1957| France                 |   8662.8349|
|  1957| Austria                |   8842.5980|
|  1952| Netherlands            |   8941.5719|
|  1972| Portugal               |   9022.2474|
|  1987| Poland                 |   9082.3512|
|  1972| Croatia                |   9164.0901|
|  1957| Iceland                |   9244.0014|
|  2007| Montenegro             |   9253.8961|
|  1992| Serbia                 |   9325.0682|
|  1967| Hungary                |   9326.6447|
|  1977| Romania                |   9356.3972|
|  1962| Finland                |   9371.8426|
|  1967| Slovenia               |   9405.4894|
|  1992| Slovak Republic        |   9498.4677|
|  1977| Poland                 |   9508.1415|
|  1972| Ireland                |   9530.7729|
|  1977| Montenegro             |   9595.9299|
|  1982| Romania                |   9605.3141|
|  1972| Slovak Republic        |   9674.1676|
|  1952| Denmark                |   9692.3852|
|  1987| Romania                |   9696.2733|
|  1957| Belgium                |   9714.9606|
|  2007| Serbia                 |   9786.5347|
|  1997| Croatia                |   9875.6045|
|  1957| Sweden                 |   9911.8782|
|  1952| United Kingdom         |   9979.5085|
|  1967| Italy                  |  10022.4013|
|  1952| Norway                 |  10095.4217|
|  1962| Czech Republic         |  10136.8671|
|  1997| Poland                 |  10159.5837|
|  1972| Hungary                |  10168.6561|
|  1977| Portugal               |  10172.4857|
|  1957| Germany                |  10187.8267|
|  1962| Iceland                |  10350.1591|
|  1972| Serbia                 |  10522.0675|
|  1992| Hungary                |  10535.6285|
|  1962| France                 |  10560.4855|
|  1972| Spain                  |  10638.7513|
|  2007| Bulgaria               |  10680.7928|
|  1962| Austria                |  10750.7211|
|  2007| Romania                |  10808.4756|
|  1967| Finland                |  10921.6363|
|  1977| Slovak Republic        |  10922.6640|
|  1962| Belgium                |  10991.2068|
|  1957| Denmark                |  11099.6593|
|  1977| Ireland                |  11150.9811|
|  1982| Montenegro             |  11222.5876|
|  1957| Netherlands            |  11276.1934|
|  1957| United Kingdom         |  11283.1779|
|  1977| Croatia                |  11305.3852|
|  1982| Slovak Republic        |  11348.5459|
|  1967| Czech Republic         |  11399.4449|
|  2002| Croatia                |  11628.3890|
|  1957| Norway                 |  11653.9730|
|  1977| Hungary                |  11674.8374|
|  1997| Hungary                |  11712.7768|
|  1987| Montenegro             |  11732.5102|
|  1982| Portugal               |  11753.8429|
|  2002| Poland                 |  12002.2391|
|  1987| Slovak Republic        |  12037.2676|
|  1997| Slovak Republic        |  12126.2306|
|  1972| Italy                  |  12269.2738|
|  1962| Sweden                 |  12329.4419|
|  1972| Slovenia               |  12383.4862|
|  1962| United Kingdom         |  12477.1771|
|  1982| Hungary                |  12545.9907|
|  1982| Ireland                |  12618.3214|
|  1972| Greece                 |  12724.8296|
|  1962| Netherlands            |  12790.8496|
|  1967| Austria                |  12834.6024|
|  1962| Germany                |  12902.4629|
|  1977| Serbia                 |  12980.6696|
|  1987| Hungary                |  12986.4800|
|  1967| France                 |  12999.9177|
|  1987| Portugal               |  13039.3088|
|  1972| Czech Republic         |  13108.4536|
|  1967| Belgium                |  13149.0412|
|  1982| Croatia                |  13221.8218|
|  1977| Spain                  |  13236.9212|
|  1967| Iceland                |  13319.8957|
|  1962| Norway                 |  13450.4015|
|  1962| Denmark                |  13583.3135|
|  2002| Slovak Republic        |  13638.7784|
|  1987| Croatia                |  13822.5839|
|  1987| Ireland                |  13872.8665|
|  1982| Spain                  |  13926.1700|
|  1967| United Kingdom         |  14142.8509|
|  1977| Greece                 |  14195.5243|
|  1992| Slovenia               |  14214.7168|
|  1977| Italy                  |  14255.9847|
|  1992| Czech Republic         |  14297.0212|
|  1972| Finland                |  14358.8759|
|  2007| Croatia                |  14619.2227|
|  1952| Switzerland            |  14734.2327|
|  1967| Germany                |  14745.6256|
|  1977| Czech Republic         |  14800.1606|
|  2002| Hungary                |  14843.9356|
|  1982| Serbia                 |  15181.0927|
|  1967| Sweden                 |  15258.2970|
|  1982| Greece                 |  15268.4209|
|  1977| Slovenia               |  15277.0302|
|  1967| Netherlands            |  15363.2514|
|  1982| Czech Republic         |  15377.2285|
|  2007| Poland                 |  15389.9247|
|  1977| Finland                |  15605.4228|
|  1987| Spain                  |  15764.9831|
|  1972| Iceland                |  15798.0636|
|  1987| Serbia                 |  15870.8785|
|  1972| United Kingdom         |  15895.1164|
|  1967| Denmark                |  15937.2112|
|  1997| Czech Republic         |  16048.5142|
|  1972| France                 |  16107.1917|
|  1987| Greece                 |  16120.5284|
|  1992| Portugal               |  16207.2666|
|  1987| Czech Republic         |  16310.4434|
|  1967| Norway                 |  16361.8765|
|  1982| Italy                  |  16537.4835|
|  1972| Austria                |  16661.6256|
|  1972| Belgium                |  16672.1436|
|  1997| Slovenia               |  17161.1073|
|  1977| United Kingdom         |  17428.7485|
|  1992| Greece                 |  17541.4963|
|  1992| Ireland                |  17558.8155|
|  2002| Czech Republic         |  17596.2102|
|  1997| Portugal               |  17641.0316|
|  1972| Sweden                 |  17832.0246|
|  1982| Slovenia               |  17866.7218|
|  1957| Switzerland            |  17909.4897|
|  2007| Hungary                |  18008.9444|
|  1972| Germany                |  18016.1803|
|  1982| United Kingdom         |  18232.4245|
|  1977| France                 |  18292.6351|
|  1982| Finland                |  18533.1576|
|  1992| Spain                  |  18603.0645|
|  2007| Slovak Republic        |  18678.3144|
|  1987| Slovenia               |  18678.5349|
|  1997| Greece                 |  18747.6981|
|  1972| Netherlands            |  18794.7457|
|  1977| Sweden                 |  18855.7252|
|  1972| Denmark                |  18866.2072|
|  1972| Norway                 |  18965.0555|
|  1977| Belgium                |  19117.9745|
|  1987| Italy                  |  19207.2348|
|  1977| Iceland                |  19654.9625|
|  1977| Austria                |  19749.4223|
|  2002| Portugal               |  19970.9079|
|  1982| France                 |  20293.8975|
|  1977| Denmark                |  20422.9015|
|  1962| Switzerland            |  20431.0927|
|  1997| Spain                  |  20445.2990|
|  2007| Portugal               |  20509.6478|
|  1977| Germany                |  20512.9212|
|  1992| Finland                |  20647.1650|
|  2002| Slovenia               |  20660.0194|
|  1982| Sweden                 |  20667.3812|
|  1982| Belgium                |  20979.8459|
|  1987| Finland                |  21141.0122|
|  1977| Netherlands            |  21209.0592|
|  1982| Netherlands            |  21399.4605|
|  1982| Austria                |  21597.0836|
|  1987| United Kingdom         |  21664.7877|
|  1982| Denmark                |  21688.0405|
|  1992| Italy                  |  22013.6449|
|  1982| Germany                |  22031.5327|
|  1987| France                 |  22066.4421|
|  2002| Greece                 |  22514.2548|
|  1987| Belgium                |  22525.5631|
|  1992| United Kingdom         |  22705.0925|
|  2007| Czech Republic         |  22833.3085|
|  1967| Switzerland            |  22966.1443|
|  1982| Iceland                |  23269.6075|
|  1977| Norway                 |  23311.3494|
|  1987| Sweden                 |  23586.9293|
|  1987| Netherlands            |  23651.3236|
|  1987| Austria                |  23687.8261|
|  1997| Finland                |  23723.9502|
|  1992| Sweden                 |  23880.0168|
|  1997| Ireland                |  24521.9471|
|  1987| Germany                |  24639.1857|
|  1997| Italy                  |  24675.0245|
|  1992| France                 |  24703.7961|
|  2002| Spain                  |  24835.4717|
|  1987| Denmark                |  25116.1758|
|  1992| Iceland                |  25144.3920|
|  1997| Sweden                 |  25266.5950|
|  1992| Belgium                |  25575.5707|
|  2007| Slovenia               |  25768.2576|
|  1997| France                 |  25889.7849|
|  1997| United Kingdom         |  26074.5314|
|  1982| Norway                 |  26298.6353|
|  1992| Denmark                |  26406.7399|
|  1992| Germany                |  26505.3032|
|  1992| Netherlands            |  26790.9496|
|  1987| Iceland                |  26923.2063|
|  1977| Switzerland            |  26982.2905|
|  1992| Austria                |  27042.0187|
|  1972| Switzerland            |  27195.1130|
|  2007| Greece                 |  27538.4119|
|  1997| Belgium                |  27561.1966|
|  1997| Germany                |  27788.8842|
|  2002| Italy                  |  27968.0982|
|  1997| Iceland                |  28061.0997|
|  2002| Finland                |  28204.5906|
|  1982| Switzerland            |  28397.7151|
|  2007| Italy                  |  28569.7197|
|  2007| Spain                  |  28821.0637|
|  2002| France                 |  28926.0323|
|  1997| Austria                |  29095.9207|
|  2002| Sweden                 |  29341.6309|
|  2002| United Kingdom         |  29478.9992|
|  1997| Denmark                |  29804.3457|
|  2002| Germany                |  30035.8020|
|  1997| Netherlands            |  30246.1306|
|  1987| Switzerland            |  30281.7046|
|  2007| France                 |  30470.0167|
|  2002| Belgium                |  30485.8838|
|  2002| Iceland                |  31163.2020|
|  1987| Norway                 |  31540.9748|
|  1992| Switzerland            |  31871.5303|
|  1997| Switzerland            |  32135.3230|
|  2002| Denmark                |  32166.5001|
|  2007| Germany                |  32170.3744|
|  2002| Austria                |  32417.6077|
|  2007| United Kingdom         |  33203.2613|
|  2007| Finland                |  33207.0844|
|  2007| Belgium                |  33692.6051|
|  2002| Netherlands            |  33724.7578|
|  2007| Sweden                 |  33859.7484|
|  1992| Norway                 |  33965.6611|
|  2002| Ireland                |  34077.0494|
|  2002| Switzerland            |  34480.9577|
|  2007| Denmark                |  35278.4187|
|  2007| Austria                |  36126.4927|
|  2007| Iceland                |  36180.7892|
|  2007| Netherlands            |  36797.9333|
|  2007| Switzerland            |  37506.4191|
|  2007| Ireland                |  40675.9964|
|  1997| Norway                 |  41283.1643|
|  2002| Norway                 |  44683.9753|
|  2007| Norway                 |  49357.1902|

From the three tables above, we can see that the output table of the reordered data set is the same as the original table. However, the rows of the arranged data set are ordered according to the values of the specified veriable.

``` r
gap_euro %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "Figure 1 The GDP per capita for all European countries from 1952 to 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
gap_reordered %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "Figure 2 The average GDP per capita for all European countries over the years between 1952 and 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-7-2.png)

``` r
gap_arranged %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "Figure 3 The average GDP per capita for all European countries over the years between 1952 and 2007")
```

![](hw05_factor-and-figure-management_files/figure-markdown_github/unnamed-chunk-7-3.png)

From the three figures above, we can see that the output figure of the arranged data set is the same as the orignial figure. However, the levels of country of the reordered data set are ordered according to the values of gdpPercap.

``` r
## combine reorder() with arrange

gap_reordered_and_arranged <- gap_euro %>% 
  mutate(country = reorder(country, gdpPercap, mean))  %>% 
  arrange(gdpPercap)

kable(gap_reordered_and_arranged)
```

|  year| country                |   gdpPercap|
|-----:|:-----------------------|-----------:|
|  1952| Bosnia and Herzegovina |    973.5332|
|  1957| Bosnia and Herzegovina |   1353.9892|
|  1952| Albania                |   1601.0561|
|  1962| Bosnia and Herzegovina |   1709.6837|
|  1957| Albania                |   1942.2842|
|  1952| Turkey                 |   1969.1010|
|  1967| Bosnia and Herzegovina |   2172.3524|
|  1957| Turkey                 |   2218.7543|
|  1962| Albania                |   2312.8890|
|  1962| Turkey                 |   2322.8699|
|  1952| Bulgaria               |   2444.2866|
|  1992| Albania                |   2497.4379|
|  1992| Bosnia and Herzegovina |   2546.7814|
|  1952| Montenegro             |   2647.5856|
|  1967| Albania                |   2760.1969|
|  1967| Turkey                 |   2826.3564|
|  1972| Bosnia and Herzegovina |   2860.1698|
|  1957| Bulgaria               |   3008.6707|
|  1952| Portugal               |   3068.3199|
|  1952| Croatia                |   3119.2365|
|  1952| Romania                |   3144.6132|
|  1997| Albania                |   3193.0546|
|  1972| Albania                |   3313.4222|
|  1972| Turkey                 |   3450.6964|
|  1977| Bosnia and Herzegovina |   3528.4813|
|  1952| Greece                 |   3530.6901|
|  1977| Albania                |   3533.0039|
|  1952| Serbia                 |   3581.4594|
|  1982| Albania                |   3630.8807|
|  1957| Montenegro             |   3682.2599|
|  1987| Albania                |   3738.9327|
|  1957| Portugal               |   3774.5717|
|  1952| Spain                  |   3834.0347|
|  1957| Romania                |   3943.3702|
|  1952| Poland                 |   4029.3297|
|  1982| Bosnia and Herzegovina |   4126.6132|
|  1952| Slovenia               |   4215.0417|
|  1982| Turkey                 |   4241.3563|
|  1962| Bulgaria               |   4254.3378|
|  1977| Turkey                 |   4269.1223|
|  1987| Bosnia and Herzegovina |   4314.1148|
|  1957| Croatia                |   4338.2316|
|  1957| Spain                  |   4564.8024|
|  2002| Albania                |   4604.2117|
|  1962| Montenegro             |   4649.5938|
|  1962| Portugal               |   4727.9549|
|  1957| Poland                 |   4734.2530|
|  1962| Romania                |   4734.9976|
|  1997| Bosnia and Herzegovina |   4766.3559|
|  1957| Greece                 |   4916.2999|
|  1952| Italy                  |   4931.4042|
|  1957| Serbia                 |   4981.0909|
|  1952| Slovak Republic        |   5074.6591|
|  1987| Turkey                 |   5089.0437|
|  1952| Ireland                |   5210.2803|
|  1952| Hungary                |   5263.6738|
|  1962| Poland                 |   5338.7521|
|  1962| Croatia                |   5477.8900|
|  1967| Bulgaria               |   5577.0028|
|  1957| Ireland                |   5599.0779|
|  1992| Turkey                 |   5678.3483|
|  1962| Spain                  |   5693.8439|
|  1957| Slovenia               |   5862.2766|
|  1967| Montenegro             |   5907.8509|
|  2007| Albania                |   5937.0295|
|  1997| Bulgaria               |   5970.3888|
|  1962| Greece                 |   6017.1907|
|  2002| Bosnia and Herzegovina |   6018.9752|
|  1957| Hungary                |   6040.1800|
|  1957| Slovak Republic        |   6093.2630|
|  1952| Austria                |   6137.0765|
|  1957| Italy                  |   6248.6562|
|  1962| Serbia                 |   6289.6292|
|  1992| Bulgaria               |   6302.6234|
|  1967| Portugal               |   6361.5180|
|  1952| Finland                |   6424.5191|
|  1997| Montenegro             |   6465.6133|
|  1967| Romania                |   6470.8665|
|  2002| Turkey                 |   6508.0857|
|  1967| Poland                 |   6557.1528|
|  2002| Montenegro             |   6557.1943|
|  1972| Bulgaria               |   6597.4944|
|  1992| Romania                |   6598.4099|
|  1997| Turkey                 |   6601.4299|
|  1962| Ireland                |   6631.5973|
|  1952| Czech Republic         |   6876.1403|
|  1967| Croatia                |   6960.2979|
|  1992| Montenegro             |   7003.3390|
|  1952| France                 |   7029.8093|
|  1952| Germany                |   7144.1144|
|  2002| Serbia                 |   7236.0753|
|  1952| Iceland                |   7267.6884|
|  1997| Romania                |   7346.5476|
|  1962| Slovenia               |   7402.3034|
|  2007| Bosnia and Herzegovina |   7446.2988|
|  1962| Slovak Republic        |   7481.1076|
|  1957| Finland                |   7545.4154|
|  1962| Hungary                |   7550.3599|
|  1977| Bulgaria               |   7612.2404|
|  1967| Ireland                |   7655.5690|
|  2002| Bulgaria               |   7696.7777|
|  1992| Poland                 |   7738.8812|
|  1972| Montenegro             |   7778.4140|
|  2002| Romania                |   7885.3601|
|  1997| Serbia                 |   7914.3203|
|  1967| Serbia                 |   7991.7071|
|  1967| Spain                  |   7993.5123|
|  1972| Poland                 |   8006.5070|
|  1972| Romania                |   8011.4144|
|  1982| Bulgaria               |   8224.1916|
|  1987| Bulgaria               |   8239.8548|
|  1962| Italy                  |   8243.5823|
|  1957| Czech Republic         |   8256.3439|
|  1952| Belgium                |   8343.1051|
|  1967| Slovak Republic        |   8412.9024|
|  1992| Croatia                |   8447.7949|
|  1982| Poland                 |   8451.5310|
|  2007| Turkey                 |   8458.2764|
|  1967| Greece                 |   8513.0970|
|  1952| Sweden                 |   8527.8447|
|  1957| France                 |   8662.8349|
|  1957| Austria                |   8842.5980|
|  1952| Netherlands            |   8941.5719|
|  1972| Portugal               |   9022.2474|
|  1987| Poland                 |   9082.3512|
|  1972| Croatia                |   9164.0901|
|  1957| Iceland                |   9244.0014|
|  2007| Montenegro             |   9253.8961|
|  1992| Serbia                 |   9325.0682|
|  1967| Hungary                |   9326.6447|
|  1977| Romania                |   9356.3972|
|  1962| Finland                |   9371.8426|
|  1967| Slovenia               |   9405.4894|
|  1992| Slovak Republic        |   9498.4677|
|  1977| Poland                 |   9508.1415|
|  1972| Ireland                |   9530.7729|
|  1977| Montenegro             |   9595.9299|
|  1982| Romania                |   9605.3141|
|  1972| Slovak Republic        |   9674.1676|
|  1952| Denmark                |   9692.3852|
|  1987| Romania                |   9696.2733|
|  1957| Belgium                |   9714.9606|
|  2007| Serbia                 |   9786.5347|
|  1997| Croatia                |   9875.6045|
|  1957| Sweden                 |   9911.8782|
|  1952| United Kingdom         |   9979.5085|
|  1967| Italy                  |  10022.4013|
|  1952| Norway                 |  10095.4217|
|  1962| Czech Republic         |  10136.8671|
|  1997| Poland                 |  10159.5837|
|  1972| Hungary                |  10168.6561|
|  1977| Portugal               |  10172.4857|
|  1957| Germany                |  10187.8267|
|  1962| Iceland                |  10350.1591|
|  1972| Serbia                 |  10522.0675|
|  1992| Hungary                |  10535.6285|
|  1962| France                 |  10560.4855|
|  1972| Spain                  |  10638.7513|
|  2007| Bulgaria               |  10680.7928|
|  1962| Austria                |  10750.7211|
|  2007| Romania                |  10808.4756|
|  1967| Finland                |  10921.6363|
|  1977| Slovak Republic        |  10922.6640|
|  1962| Belgium                |  10991.2068|
|  1957| Denmark                |  11099.6593|
|  1977| Ireland                |  11150.9811|
|  1982| Montenegro             |  11222.5876|
|  1957| Netherlands            |  11276.1934|
|  1957| United Kingdom         |  11283.1779|
|  1977| Croatia                |  11305.3852|
|  1982| Slovak Republic        |  11348.5459|
|  1967| Czech Republic         |  11399.4449|
|  2002| Croatia                |  11628.3890|
|  1957| Norway                 |  11653.9730|
|  1977| Hungary                |  11674.8374|
|  1997| Hungary                |  11712.7768|
|  1987| Montenegro             |  11732.5102|
|  1982| Portugal               |  11753.8429|
|  2002| Poland                 |  12002.2391|
|  1987| Slovak Republic        |  12037.2676|
|  1997| Slovak Republic        |  12126.2306|
|  1972| Italy                  |  12269.2738|
|  1962| Sweden                 |  12329.4419|
|  1972| Slovenia               |  12383.4862|
|  1962| United Kingdom         |  12477.1771|
|  1982| Hungary                |  12545.9907|
|  1982| Ireland                |  12618.3214|
|  1972| Greece                 |  12724.8296|
|  1962| Netherlands            |  12790.8496|
|  1967| Austria                |  12834.6024|
|  1962| Germany                |  12902.4629|
|  1977| Serbia                 |  12980.6696|
|  1987| Hungary                |  12986.4800|
|  1967| France                 |  12999.9177|
|  1987| Portugal               |  13039.3088|
|  1972| Czech Republic         |  13108.4536|
|  1967| Belgium                |  13149.0412|
|  1982| Croatia                |  13221.8218|
|  1977| Spain                  |  13236.9212|
|  1967| Iceland                |  13319.8957|
|  1962| Norway                 |  13450.4015|
|  1962| Denmark                |  13583.3135|
|  2002| Slovak Republic        |  13638.7784|
|  1987| Croatia                |  13822.5839|
|  1987| Ireland                |  13872.8665|
|  1982| Spain                  |  13926.1700|
|  1967| United Kingdom         |  14142.8509|
|  1977| Greece                 |  14195.5243|
|  1992| Slovenia               |  14214.7168|
|  1977| Italy                  |  14255.9847|
|  1992| Czech Republic         |  14297.0212|
|  1972| Finland                |  14358.8759|
|  2007| Croatia                |  14619.2227|
|  1952| Switzerland            |  14734.2327|
|  1967| Germany                |  14745.6256|
|  1977| Czech Republic         |  14800.1606|
|  2002| Hungary                |  14843.9356|
|  1982| Serbia                 |  15181.0927|
|  1967| Sweden                 |  15258.2970|
|  1982| Greece                 |  15268.4209|
|  1977| Slovenia               |  15277.0302|
|  1967| Netherlands            |  15363.2514|
|  1982| Czech Republic         |  15377.2285|
|  2007| Poland                 |  15389.9247|
|  1977| Finland                |  15605.4228|
|  1987| Spain                  |  15764.9831|
|  1972| Iceland                |  15798.0636|
|  1987| Serbia                 |  15870.8785|
|  1972| United Kingdom         |  15895.1164|
|  1967| Denmark                |  15937.2112|
|  1997| Czech Republic         |  16048.5142|
|  1972| France                 |  16107.1917|
|  1987| Greece                 |  16120.5284|
|  1992| Portugal               |  16207.2666|
|  1987| Czech Republic         |  16310.4434|
|  1967| Norway                 |  16361.8765|
|  1982| Italy                  |  16537.4835|
|  1972| Austria                |  16661.6256|
|  1972| Belgium                |  16672.1436|
|  1997| Slovenia               |  17161.1073|
|  1977| United Kingdom         |  17428.7485|
|  1992| Greece                 |  17541.4963|
|  1992| Ireland                |  17558.8155|
|  2002| Czech Republic         |  17596.2102|
|  1997| Portugal               |  17641.0316|
|  1972| Sweden                 |  17832.0246|
|  1982| Slovenia               |  17866.7218|
|  1957| Switzerland            |  17909.4897|
|  2007| Hungary                |  18008.9444|
|  1972| Germany                |  18016.1803|
|  1982| United Kingdom         |  18232.4245|
|  1977| France                 |  18292.6351|
|  1982| Finland                |  18533.1576|
|  1992| Spain                  |  18603.0645|
|  2007| Slovak Republic        |  18678.3144|
|  1987| Slovenia               |  18678.5349|
|  1997| Greece                 |  18747.6981|
|  1972| Netherlands            |  18794.7457|
|  1977| Sweden                 |  18855.7252|
|  1972| Denmark                |  18866.2072|
|  1972| Norway                 |  18965.0555|
|  1977| Belgium                |  19117.9745|
|  1987| Italy                  |  19207.2348|
|  1977| Iceland                |  19654.9625|
|  1977| Austria                |  19749.4223|
|  2002| Portugal               |  19970.9079|
|  1982| France                 |  20293.8975|
|  1977| Denmark                |  20422.9015|
|  1962| Switzerland            |  20431.0927|
|  1997| Spain                  |  20445.2990|
|  2007| Portugal               |  20509.6478|
|  1977| Germany                |  20512.9212|
|  1992| Finland                |  20647.1650|
|  2002| Slovenia               |  20660.0194|
|  1982| Sweden                 |  20667.3812|
|  1982| Belgium                |  20979.8459|
|  1987| Finland                |  21141.0122|
|  1977| Netherlands            |  21209.0592|
|  1982| Netherlands            |  21399.4605|
|  1982| Austria                |  21597.0836|
|  1987| United Kingdom         |  21664.7877|
|  1982| Denmark                |  21688.0405|
|  1992| Italy                  |  22013.6449|
|  1982| Germany                |  22031.5327|
|  1987| France                 |  22066.4421|
|  2002| Greece                 |  22514.2548|
|  1987| Belgium                |  22525.5631|
|  1992| United Kingdom         |  22705.0925|
|  2007| Czech Republic         |  22833.3085|
|  1967| Switzerland            |  22966.1443|
|  1982| Iceland                |  23269.6075|
|  1977| Norway                 |  23311.3494|
|  1987| Sweden                 |  23586.9293|
|  1987| Netherlands            |  23651.3236|
|  1987| Austria                |  23687.8261|
|  1997| Finland                |  23723.9502|
|  1992| Sweden                 |  23880.0168|
|  1997| Ireland                |  24521.9471|
|  1987| Germany                |  24639.1857|
|  1997| Italy                  |  24675.0245|
|  1992| France                 |  24703.7961|
|  2002| Spain                  |  24835.4717|
|  1987| Denmark                |  25116.1758|
|  1992| Iceland                |  25144.3920|
|  1997| Sweden                 |  25266.5950|
|  1992| Belgium                |  25575.5707|
|  2007| Slovenia               |  25768.2576|
|  1997| France                 |  25889.7849|
|  1997| United Kingdom         |  26074.5314|
|  1982| Norway                 |  26298.6353|
|  1992| Denmark                |  26406.7399|
|  1992| Germany                |  26505.3032|
|  1992| Netherlands            |  26790.9496|
|  1987| Iceland                |  26923.2063|
|  1977| Switzerland            |  26982.2905|
|  1992| Austria                |  27042.0187|
|  1972| Switzerland            |  27195.1130|
|  2007| Greece                 |  27538.4119|
|  1997| Belgium                |  27561.1966|
|  1997| Germany                |  27788.8842|
|  2002| Italy                  |  27968.0982|
|  1997| Iceland                |  28061.0997|
|  2002| Finland                |  28204.5906|
|  1982| Switzerland            |  28397.7151|
|  2007| Italy                  |  28569.7197|
|  2007| Spain                  |  28821.0637|
|  2002| France                 |  28926.0323|
|  1997| Austria                |  29095.9207|
|  2002| Sweden                 |  29341.6309|
|  2002| United Kingdom         |  29478.9992|
|  1997| Denmark                |  29804.3457|
|  2002| Germany                |  30035.8020|
|  1997| Netherlands            |  30246.1306|
|  1987| Switzerland            |  30281.7046|
|  2007| France                 |  30470.0167|
|  2002| Belgium                |  30485.8838|
|  2002| Iceland                |  31163.2020|
|  1987| Norway                 |  31540.9748|
|  1992| Switzerland            |  31871.5303|
|  1997| Switzerland            |  32135.3230|
|  2002| Denmark                |  32166.5001|
|  2007| Germany                |  32170.3744|
|  2002| Austria                |  32417.6077|
|  2007| United Kingdom         |  33203.2613|
|  2007| Finland                |  33207.0844|
|  2007| Belgium                |  33692.6051|
|  2002| Netherlands            |  33724.7578|
|  2007| Sweden                 |  33859.7484|
|  1992| Norway                 |  33965.6611|
|  2002| Ireland                |  34077.0494|
|  2002| Switzerland            |  34480.9577|
|  2007| Denmark                |  35278.4187|
|  2007| Austria                |  36126.4927|
|  2007| Iceland                |  36180.7892|
|  2007| Netherlands            |  36797.9333|
|  2007| Switzerland            |  37506.4191|
|  2007| Ireland                |  40675.9964|
|  1997| Norway                 |  41283.1643|
|  2002| Norway                 |  44683.9753|
|  2007| Norway                 |  49357.1902|

``` r
gap_reordered_and_arranged %>% 
  ggplot(aes(x = gdpPercap, y = country, color = year)) +
  geom_point() +
  labs(title = "Figure 4 The average GDP per capita for all European countries over the years between 1952 and 2007")
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
