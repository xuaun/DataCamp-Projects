# Imported libraries
library(tidyverse)

# Start coding here..
# 1. Load and inspect the data
yearly <- as.data.frame(read_csv("data/yearly_deaths_by_clinic.csv"))
monthly <- as.data.frame(read_csv("data/monthly_deaths.csv"))

print(yearly)
print(monthly)

# 2. Add a new column with the proportions
yearly <- yearly %>%
    mutate(proportion_deaths = deaths / births)

monthly <- monthly %>%
    mutate(proportion_deaths = deaths / births)


# 3. Make a line plot for each data frame
ggplot(yearly, aes(x = year, y = proportion_deaths, color = clinic)) +
    geom_line()

ggplot(monthly, aes(x = date, y = proportion_deaths)) +
    geom_line()

# 4. Visualize the threshold
monthly <- monthly %>%
    mutate(handwashing_started = date >= as.Date("1847-06-01"))

ggplot(monthly, aes(x = date, y = proportion_deaths, color = handwashing_started)) +
    geom_line()

# 5. Calculate the mean proportion of deaths
monthly_summary <- monthly %>%
    group_by(handwashing_started) %>%
    summarise(mean_prop_deaths = mean(proportion_deaths))
monthly_summary
