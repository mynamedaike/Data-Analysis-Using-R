Homework 08: Building a Shiny app
================
Ke Dai
2016年11月26日

New Features I implemented
--------------------------
+ Add an option to sort the results table by price.
+ Add an image of the BC Liquor Store to the UI.
+ Use the DT package to turn the current results table into an interactive table.
+ Add parameters to the plot.
+ The app currently behaves strangely when the user selects filters that return 0 results. For example, try searching for wines from Belgium. There will be an empty plot and empty table generated, and there will be a warning message in the R console. Try to figure out why this warning message is appearing, and how to fix it.
+ Place the plot and the table in separate tabs.
+ If you know CSS, add CSS to make your app look nicer.
+ Show the number of results found whenever the filters change. For example, when searching for Italian wines $20-$40, the app would show the text “We found 122 options for you”.
+ Allow the user to download the results table as a ..csv file.
+ When the user wants to see only wines, show a new input that allows the user to filter by sweetness level. Only show this input if wines are selected.
+ Allow the user to search for multiple alcohol types simultaneously, instead of being able to choose only wines/beers/etc.
+ If you look at the dataset, you’ll see that each product has a “type” (beer, wine, spirit, or refreshment) and also a “subtype” (red wine, rum, cider, etc.). Add an input for “subtype” that will let the user filter for only a specific subtype of products. Since each type has different subtype options, the choices for subtype should get re-generated every time a new type is chosen. For example, if “wine” is selected, then the subtypes available should be white wine, red wine, etc.
+ Provide a way for the user to show results from all countries (instead of forcing a filter by only one specific country).

The link to the URL where the app is hosted
-------------------------------------------
I have deployed this Shiny app on both shinyapps.io and my own Shiny Server. So you can access it at https://kedai.shinyapps.io/hw08_Building-Shiny-apps/ or http://shiny.stat.ubc.ca/ke.dai/hw08_Building-Shiny-apps/.

Report my process
-----------------
This is the first time I build a web application using R. It's interesting. I learned a lot from this homework. It's not very difficult for me to implement the features recommended in the homework page as each feature is accompanied by a corresponding hint. Meanwhile the tutorials provided are really helpful for me to get started  from scratch. However, I still encountered some tricky problems when developing this Shiny app. For example, when I tried to include a checkbox for “Filter by country” which controls the display of the dropdown list of country options. At the beginning, I used *`"input.filterByCountry == TRUE"`* as the condition of a conditionalPanel. It does not work. Then I tried to solve it by myself, but I failed. So I googled this problem online. Fortunately, I found an example about it. It turned out that *`TRUE`* should be changed to *`true`* because the condition is a JavaScript expression not a R expression.

Some useful links
-----------------
+ http://stat545.com/shiny01_activity.html#final-shiny-app-code
+ http://shiny.rstudio.com/articles/app-formats.html
+ http://shiny.rstudio.com/articles/css.html
+ http://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/
