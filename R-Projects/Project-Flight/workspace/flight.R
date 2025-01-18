# Import required packages
library(dplyr)
library(readr)

# Load the data
flights <- read_csv("flights2022-h2.csv")
airlines <- read_csv("airlines.csv")
airports <- read_csv("airports.csv")

head(flights)

head(airlines)

head(airports)

# flights
# airlines
# airports
data <- flights %>%
    left_join(airlines, by = "carrier") %>%
    rename(airline_name = name) %>%
    left_join(airports, by = c("dest" = "faa")) %>%
    rename(airport_name = name) %>%
    mutate(air_time_hour = (air_time / 60)) %>%
    group_by(airline_name, airport_name) %>%
    summarise(avg = mean(air_time_hour), n = n(), na.rm = TRUE) %>%
    ungroup()
data

frequent <- data %>%
    arrange(desc(n)) %>%
    head(1)
frequent

longest <- data %>%
    arrange(desc(avg)) %>%
    head(1)
longest

least <- flights %>%
    left_join(airlines, by = "carrier") %>%
    rename(airline_name = name) %>%
    left_join(airports, by = c("dest" = "faa")) %>%
    rename(airport_name = name) %>%
    mutate(air_time_hour = (air_time / 60)) %>%
    filter(origin == "JFK") %>%
    group_by(airport_name) %>%
    summarise(n = n()) %>%
    arrange(n) %>%
    head(1)
least <- as.character(least[1, 1])
least
