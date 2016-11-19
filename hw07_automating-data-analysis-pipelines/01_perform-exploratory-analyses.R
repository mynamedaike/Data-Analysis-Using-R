library(ggplot2)
library(dplyr)
library(forcats)

## load the gapminder data frame
gapminder <- read.delim("gapminder.tsv")
str(gapminder)

## The median life expectancy for each continent on years
gap_lifeExp <- gapminder %>% 
  select(year, continent, lifeExp) %>% 
  group_by(year, continent) %>% 
  summarise(medianLifeExp = median(lifeExp))

p <- gap_lifeExp %>% 
  ggplot(aes(x = year, y = medianLifeExp, fill = continent)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("The median life expectancy for each continent on years")

ggsave("lifeExp_continent.png", p)

## The weighted mean of GDP per capita on population for each continent on years
gap_gdpPercap <- gapminder %>% 
  select(year, continent, gdpPercap, pop) %>% 
  group_by(year, continent) %>% 
  summarise(weightedMeanGdpPercap = weighted.mean(gdpPercap, pop))

p <- gap_gdpPercap %>% 
  ggplot(aes(x = year, y = weightedMeanGdpPercap, color = continent)) +
  geom_point() +
  geom_path() +
  ggtitle("The weighted mean of GDP per capita on population for each continent on years")

ggsave("gdpPercap_continent.png", p)

## The distribution of the population for each continent on years
p <- gapminder %>% 
  ggplot(aes(x = continent, y = gdpPercap, color = continent)) +
  scale_y_log10() +
  geom_violin() +
  facet_wrap(~ year) +
  ggtitle("The distribution of the population for each continent on years")

ggsave("pop_continent.png", p)

## The life expectancy with GDP per capita for each continent 
p <- gapminder %>% 
  mutate(country = fct_reorder(country, -1 * pop)) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, fill = continent)) + 
  scale_x_log10(limits = c(200, 65000)) +
  geom_point(pch = 21, show.legend = FALSE) +
  scale_size_continuous(range = c(1,10)) +
  facet_wrap(~ continent) +
  ggtitle("The life expectancy with GDP per capita for each continent")

ggsave("lifeExp_gdpPercap.png", p)

## Reorder the continent and country based on their median life expectancy and sort the actual data in the ascending order of life expectancy
gap_reordered <- gapminder %>% 
  mutate(country = fct_reorder(country, lifeExp)) %>% 
  mutate(continent = fct_reorder(continent, lifeExp)) %>% 
  arrange(lifeExp)

## Write the reordered gapminder data to a file
write.csv(gap_reordered, "gap_reordered.csv")