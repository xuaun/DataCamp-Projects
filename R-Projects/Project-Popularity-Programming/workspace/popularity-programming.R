# Load necessary packages
library(readr)
library(dplyr)
library(ggplot2)

# Load the dataset
data <- read_csv("stack_overflow_data.csv")

# Analysing data using glimpse()
glimpse(data)

r_over_time <- data %>%
    filter(tag == "r") %>%
    mutate(percentage = (num_questions / year_total) * 100)
glimpse(r_over_time)

r_2020 <- r_over_time %>%
    filter(year == 2020)

r_percentage <- r_2020$percentage
r_percentage

data_highest_top <- data %>%
    filter(year >= 2015 & year <= 2020) %>%
    group_by(tag) %>%
    summarise(total_tags = sum(num_questions)) %>%
    arrange(desc(total_tags)) %>%
    head(n = 5)

highest_tags <- data_highest_top$tag
highest_tags

# Q1 - geom_line
ggplot(r_over_time, aes(x = year, y = percentage)) +
    geom_line()

# Q3 - geom_bar
ggplot(data_highest_top, aes(x = tag, y = total_tags, fill = tag)) +
    geom_bar(stat = "identity")
