# Project: When Was the Golden Era of Video Games?
## Context and Questions to solve

- Find the ten best-selling games. The output should contain all the columns in the game_sales table and be sorted by the games_sold column in descending order. Save the output as best_selling_games.

- Find the ten years with the highest average critic score, where at least four games were released (to ensure a good sample size). Return an output with the columns year, num_games released, and avg_critic_score. The avg_critic_score should be rounded to 2 decimal places. The table should be ordered by avg_critic_score in descending order. Save the output as critics_top_ten_years. Do not use the critics_avg_year_rating table provided; this has been provided for your third query.

- Find the years where critics and users broadly agreed that the games released were highly rated. Specifically, return the years where the average critic score was over 9 OR the average user score was over 9. The pre-computed average critic and user scores per year are stored in users_avg_year_rating and critics_avg_year_rating tables respectively. The query should return the following columns: year, num_games, avg_critic_score, avg_user_score, and diff. The diff column should be the difference between the avg_critic_score and avg_user_score. The table should be ordered by the year in ascending order, save this as a DataFrame named golden_years.

Note: Please also ensure that you do not change the names of the DataFrames that the three query results will be saved as - creating new cells in the workbook will rename the DataFrame. Make sure that your final solutions use the names provided: best_selling_games, critics_top_ten_years, and golden_years.
