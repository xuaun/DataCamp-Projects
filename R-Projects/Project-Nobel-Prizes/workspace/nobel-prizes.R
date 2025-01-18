# Loading in required libraries
library(tidyverse)
library(readr)
library(ggplot2)

# 1. Load the dataset and find the most common gender and birth country
nobel <- read_csv("data/nobel.csv")

head(nobel)

gender_nobel <- nobel %>%
    count(sex, sort = TRUE)

top_gender <- gender_nobel$sex[1]

country_nobel <- nobel %>%
    count(birth_country, sort = TRUE)

top_country <- country_nobel$birth_country[1]

# 2. Identify the decade with the highest proportion of US-born winners
decade_nobel_data <- nobel %>%
    mutate(decade = floor(year / 10) * 10)

# decade_nobel_data

decade_nobel <- decade_nobel_data %>%
    count(decade, sort = TRUE)

decade_usa_nobel <- decade_nobel_data %>%
    filter(birth_country == "United States of America") %>%
    count(decade, sort = TRUE)

# decade_usa_nobel

decade_usa_nobel_prop <- decade_usa_nobel %>%
    left_join(decade_nobel, "decade", suffix = c("_usa", "_all")) %>%
    mutate(usa_prop = n_usa / n_all) %>%
    arrange(desc(usa_prop))

# decade_usa_nobel_prop

max_decade_usa <- decade_usa_nobel_prop$decade[1]
max_decade_usa

# 3. Find the decade and category with the highest proportion of female laureates
decade_woman_nobel <- decade_nobel_data %>%
    filter(sex == "Female") %>%
    count(decade, sort = TRUE)

decade_woman_nobel_prop <- decade_woman_nobel %>%
    left_join(decade_nobel, "decade", suffix = c("_woman", "_all")) %>%
    mutate(woman_prop = n_woman / n_all) %>%
    arrange(desc(woman_prop))

# decade_woman_nobel_prop

category_nobel <- nobel %>%
    count(category, sort = TRUE)

category_woman_nobel <- nobel %>%
    filter(sex == "Female") %>%
    count(category, sort = TRUE)

category_woman_nobel_prop <- category_woman_nobel %>%
    left_join(category_nobel, "category", suffix = c("_woman", "_all")) %>%
    mutate(woman_prop = n_woman / n_all) %>%
    arrange(desc(woman_prop))

# category_woman_nobel_prop

max_female_list <- list(decade_woman_nobel_prop$decade, category_woman_nobel_prop$category)

# 4. Find first woman to win a Nobel Prize
first_woman_nobel <- nobel %>%
    filter(sex == "Female")

# nobel
# first_woman_nobel

first_woman_name <- first_woman_nobel$full_name[1]
# first_woman_name <- word(first_woman_name, 1)
# first_woman_name

first_woman_category <- first_woman_nobel$category[1]

# 5. Determine repeat winners
repeats <- nobel %>%
    count(full_name, sort = TRUE) %>%
    filter(n > 1)
# repeats
