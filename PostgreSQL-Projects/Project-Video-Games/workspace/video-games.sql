-- # Video games are big business: the global gaming market is projected to be worth more than $300 billion by 2027 according to Mordor Intelligence. With so much money at stake, the major game publishers are hugely incentivized to create the next big hit. But are games getting better, or has the golden age of video games already passed?
-- # 
-- # In this project, you'll analyze video game critic and user scores as well as sales data for the top 400 video games released since 1977. You'll search for a golden age of video games by identifying release years that users and critics liked best, and you'll explore the business side of gaming by looking at game sales data.
-- # 
-- # Your search will involve joining datasets and comparing results with set theory. You'll also filter, group, and order data. Make sure you brush up on these skills before trying this project! The database contains two tables. Each table has been limited to 400 rows for this project, but you can find the complete dataset with over 13,000 games on Kaggle.
-- # 
-- # ### `game_sales` table
-- # 
-- # | Column | Definition | Data Type |
-- # |-|-|-|  
-- # |name|Name of the video game|`varchar`|
-- # |platform|Gaming platform|`varchar`|
-- # |publisher|Game publisher|`varchar`|
-- # |developer|Game developer|`varchar`|
-- # |games_sold|Number of copies sold (millions)|`float`|
-- # |year|Release year|`int`|
-- # 
-- # ### `reviews` table
-- # 
-- # | Column | Definition | Data Type |
-- # |-|-|-|
-- # |name|Name of the video game|`varchar`|  
-- # |critic_score|Critic score according to Metacritic|`float`|
-- # |user_score|User score according to Metacritic|`float`|
-- # 
-- # 
-- # ### `users_avg_year_rating` table
-- # 
-- # | Column | Definition | Data Type |
-- # |-|-|-|
-- # |year| Release year of the games reviewed |`int`|  
-- # |num_games| Number of games released that year |`int`|
-- # |avg_user_score| Average score of all the games ratings for the year |`float`|
-- # 
-- # ### `critics_avg_year_rating` table
-- # 
-- # | Column | Definition | Data Type |
-- # |-|-|-|
-- # |year| Release year of the games reviewed |`int`|  
-- # |num_games| Number of games released that year |`int`|
-- # |avg_critic_score| Average score of all the games ratings for the year |`float`|

-- best_selling_games
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;

-- critics_top_ten_years
SELECT 
	gs.year,
	COUNT(gs.name) AS num_games,
	ROUND(AVG(r.critic_score), 2) AS avg_critic_score
FROM game_sales AS gs
INNER JOIN reviews AS r
ON gs.name = r.name
GROUP BY year
HAVING COUNT(gs.name) > 3
ORDER BY avg_critic_score DESC
LIMIT 10;


-- golden_years
SELECT 
	c.year, 
	c.num_games, 
	c.avg_critic_score,
	u.avg_user_score,
	(c.avg_critic_score - u.avg_user_score) AS diff
FROM critics_avg_year_rating AS c
INNER JOIN users_avg_year_rating AS u
ON c.year = u.year
WHERE 
	avg_critic_score > 9.0 
	OR 
	avg_user_score > 9.0
ORDER BY year ASC;


