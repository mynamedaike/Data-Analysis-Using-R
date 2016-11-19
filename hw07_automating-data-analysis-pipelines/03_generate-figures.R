library(dplyr)
library(ggplot2)

best_countries <- read.csv("best_countries.csv")
gapminder <- read.csv("gap_reordered.csv")

## Africa

p <- gapminder %>% 
  filter(country %in% best_countries$country, continent == "Africa") %>% 
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE, method = "lm") +
  facet_wrap(~ country) +
  ggtitle("4 best fitted countries for Africa")

ggsave("Africa.png", p)

## Americas

p <- gapminder %>% 
  filter(country %in% best_countries$country, continent == "Americas") %>% 
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE, method = "lm") +
  facet_wrap(~ country) +
  ggtitle("4 best fitted countries for Americas")

ggsave("Americas.png", p)

## Asia

p <- gapminder %>% 
  filter(country %in% best_countries$country, continent == "Asia") %>% 
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE, method = "lm") +
  facet_wrap(~ country) +
  ggtitle("4 best fitted countries for Asia")

ggsave("Asia.png", p)

## Europe

p <- gapminder %>% 
  filter(country %in% best_countries$country, continent == "Europe") %>% 
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE, method = "lm") +
  facet_wrap(~ country) +
  ggtitle("4 best fitted countries for Europe")

ggsave("Europe.png", p)

## Oceania

p <- gapminder %>% 
  filter(country %in% best_countries$country, continent == "Oceania") %>% 
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE, method = "lm") +
  facet_wrap(~ country) +
  ggtitle("4 best fitted countries for Oceania")

ggsave("Oceania.png", p)