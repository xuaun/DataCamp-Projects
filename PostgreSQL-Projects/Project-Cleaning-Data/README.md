# Project: Analyzing and Formatting PostgreSQL Sales Data
## Context and Questions to solve

### Let's dive into the world of SQL and work our magic to clean and analyze data from our hypothetical Super Store.

1. Find the top 5 products from each category based on highest total sales. The output should be sorted by category in ascending order and by sales in descending order within each category, i.e. within each category product with highest margin should sit on the top. Save the query as top_five_products_each_category, containing the following columns:

- category

- product_name

- product_total_sales (rounded to two decimal places)

- product_total_profit (rounded to two decimal places)

- product_rank

2. Calculate the quantity for orders with missing values in the quantity column. To do this, first calculate the unit price for each product based on the orders where the quantity is available, considering factors that might affect pricing. Then, use this unit price to estimate the missing quantity values for orders where the quantity is missing. The calculated values should be stored in the calculated_quantity column. Save query output as impute_missing_values, containing the following columns:

- product_id

- discount

- market

- region

- sales

- quantity

- calculated_quantity (rounded to zero decimal places)

## Code with solution
- ```Query (.sql)``` code [here](./workspace/cleaning-data.sql)
- ```Jupyter Notebook (.ipynb)``` file [here](./workspace/notebook.ipynb)
