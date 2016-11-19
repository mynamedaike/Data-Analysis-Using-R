library(dplyr)

## Import the reordered gapminder data created in the first script
gapminder <- read.csv("gap_reordered.csv")

## Linear regression model
lin_fit <- function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ I(year - offset), dat)
  result <- data.frame("continent" = dat$continent %>% unique(),
                       "intercept" = coef(the_fit)[1],
                       "slope" = coef(the_fit)[2],
                       "res_err_var" =  (summary(the_fit)$sigma)**2)
  return(result)
}

fit_result <- gapminder %>% 
  group_by(country) %>% 
  do(lin_fit(.))

write.csv(fit_result, "fit_result.csv")

## Find 4 worst and best fitted countries for each continent

best_countries <- fit_result %>% 
  group_by(continent) %>% 
  filter(min_rank(res_err_var) <= 4) %>% 
  arrange(continent, res_err_var)

worst_countries <- fit_result %>% 
  group_by(continent) %>% 
  filter(min_rank(desc(res_err_var)) <= 4) %>% 
  arrange(continent, res_err_var)

write.csv(best_countries, "best_countries.csv")
write.csv(worst_countries, "worst_countries.csv")
