# Import necessary libraries
library(tidyverse)

# Load men and women results
men <- read_csv("men_results.csv")
women <- read_csv("women_results.csv")

# Some EDA to understand the results
str(men)
str(women)

# Filter matches / date and total goals scored in a single variable
men <- men %>%
    filter(tournament == "FIFA World Cup", date > "2002-01-01") %>%
    mutate(goals_scored = home_score + away_score)

women <- women %>%
    filter(tournament == "FIFA World Cup", date > "2002-01-01") %>%
    mutate(goals_scored = home_score + away_score)

men_plot <- ggplot(men, aes(x = goals_scored)) +
    geom_histogram(bins = 30) +
    ggtitle("Goals Scored - Men") +
    xlab("Goals Scored") +
    ylab("Frequency")

men_plot

women_plot <- ggplot(women, aes(x = goals_scored)) +
    geom_histogram(bins = 30) +
    ggtitle("Goals Scored - Women") +
    xlab("Goals Scored") +
    ylab("Frequency")

women_plot

# Calculate the test results
test_results <- wilcox.test(
    x = women$goals_scored,
    y = men$goals_scored,
    alternative = "greater"
)

test_results

# Calculate the p_val and result based on the previous test results
p_val <- round(test_results$p.value, 4)
alpha <- 0.10
result <- ifelse(p_val <= alpha, "reject", "fail to reject")

result

result_df <- data.frame(p_val, result)
result_df
