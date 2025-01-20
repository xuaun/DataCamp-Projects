# Project: Analyzing Electric Vehicle Charging Habits
## Context and Questions to solve

### Write three SQL queries to answer the following questions:

1. Find the number of unique individuals that use each garage’s shared charging stations. The output should contain two columns: garage_id and num_unique_users. Sort your results by the number of unique users from highest to lowest. Save the result as unique_users_per_garage.

2. Find the top 10 most popular charging start times (by weekday and start hour) for sessions that use shared charging stations. Your result should contain three columns: weekdays_plugin, start_plugin_hour, and a column named num_charging_sessions containing the number of plugins on that weekday at that hour. Sort your results from the most to the least number of sessions. Save the result as most_popular_shared_start_times.

3. Find the users whose average charging duration last longer than 10 hours when using shared charging stations. Your result should contain two columns: user_id and avg_charging_duration. Sort your result from highest to lowest average charging duration. Save the result as long_duration_shared_users.

Three SQL cells have been created for you in the workbook. To access the data, you will need to select data using the syntax FROM charging_sessions.

Note: Please also ensure that you do not change the names of the DataFrames that the three query results will be saved as - creating new cells in the workbook will rename the DataFrame (see image below). Make sure that your final solutions use the names provided: unique_users_per_garage, most_popular_shared_start_times, and long_duration_shared_users.

SQL cell showing the DataFrame named unique_users_per_garage

## Code with solution
- ```Query (.sql)``` code [here](./workspace/eletric-vehicle.sql)
- ```Jupyter Notebook (.ipynb)``` file [here](./workspace/notebook.ipynb)
