-- # # Cleaning a PostgreSQL Database
-- # ![Clean PostgreSQL Database](Project_Image.jpeg)
-- # 
-- # In this project, you will work with data from a hypothetical Super Store to challenge and enhance your SQL skills in data cleaning. This project will engage you in identifying top categories based on the highest profit margins and detecting missing values, utilizing your comprehensive knowledge of SQL concepts.
-- # 
-- # ## Data Dictionary:
-- # 
-- # ### `orders`:
-- # | Column | Definition | Data type | Comments |
-- # |--------|------------|-----------|----------|
-- # | `row_id`| Unique Record ID | `INTEGER` |
-- # | `order_id` | Identifier for each order in table | `TEXT` | Connects to `order_id` in `returned_orders` table |
-- # | `order_date` | Date when order was placed | `TEXT` |
-- # | `market` | Market order_id belongs to | `TEXT` |
-- # | `region` | Region Customer belongs to | `TEXT` | Connects to `region` in `people` table |
-- # | `product_id` | Identifier of Product bought | `TEXT` | Connects to `product_id` in `products` table |
-- # | `sales` | Total Sales Amount for the Line Item | `DOUBLE PRECISION` |
-- # | `quantity` | Total Quantity for the Line Item | `DOUBLE PRECISION` |
-- # | `discount` | Discount applied for the Line Item | `DOUBLE PRECISION` |
-- # | `profit` | Total Profit earned on the Line Item | `DOUBLE PRECISION` |
-- # 
-- # ### `returned_orders`:
-- # | Column | Definition | Data type |
-- # |--------|------------|-----------|
-- # | `returned`| Yes values for Order / Line Item Returned | `TEXT` |
-- # | `order_id` | Identifier for each order in table | `TEXT` |
-- # | `market` | Market order_id belongs to | `TEXT` |
-- # 
-- # ### `people`:
-- # | Column | Definition | Data type |
-- # |--------|------------|-----------|
-- # | `person`| Name of Salesperson credited with Order | `TEXT` |
-- # | `region` | Region Salesperson in operating in | `TEXT` |
-- # 
-- # ### `products`:
-- # | Column | Definition | Data type |
-- # |--------|------------|-----------|
-- # | `product_id`| Unique Identifier for the Product | `TEXT` |
-- # | `category` | Category Product belongs to | `TEXT` |
-- # | `sub_category` | Sub Category Product belongs to | `TEXT` |
-- # | `product_name` | Detailed Name of the Product | `TEXT` |
-- # 
-- # As you can see in the Data Dictionary above, date fields have been written to the `orders` table as `TEXT` and numeric fields like sales, profit, etc. have been written to the `orders` table as `Double Precision`. You will need to take care of these types in some of the queries. This project is an excellent opportunity to apply your SQL skills in a practical setting and gain valuable experience in data cleaning and analysis. Good luck, and happy querying!

-- top_five_products_each_category
SELECT
		category,
		product_name,
		product_total_sales,
		product_total_profit,
		product_rank
FROM (
		SELECT 
				p.category,
				p.product_name,
				o.product_total_sales,
				o.product_total_profit,
				RANK() OVER (
					PARTITION BY p.category
					ORDER BY o.product_total_sales DESC) AS product_rank
		FROM products AS p
		INNER JOIN 
					(SELECT 
							product_id,
							ROUND(SUM(sales::numeric), 2) AS product_total_sales,
							ROUND(SUM(profit::numeric), 2) AS product_total_profit
					FROM orders
					GROUP BY product_id) AS o
		ON o.product_id = p.product_id
		ORDER BY p.category ASC, o.product_total_sales DESC) AS sub
WHERE product_rank <= 5;

SELECT * FROM (
SELECT products.category, 
	products.product_name,
    ROUND(SUM(CAST(ord.sales AS NUMERIC)), 2) AS product_total_sales,
	ROUND(SUM(CAST(ord.profit AS NUMERIC)), 2) AS product_total_profit,
	RANK() OVER(PARTITION BY products.category ORDER BY SUM(ord.sales) DESC) AS product_rank
	FROM orders AS ord
	INNER JOIN products
		ON ord.product_id = products.product_id
	GROUP BY products.category, products.product_name
) AS tmp
WHERE product_rank < 6;

-- impute_missing_values
SELECT  product_id,
        discount,
        market,
        region,
        sales,
        quantity,
        calculated_quantity
FROM (
        SELECT
                o.product_id,
                o.discount,
                o.market,
                o.region,
                o.sales,
                o.quantity,
                CASE WHEN o.quantity IS NULL THEN (o.sales::numeric / ((1 - o.discount::numeric) * sub.unit_price))
                     ELSE o.quantity END AS calculated_quantity
        FROM orders AS o
        LEFT JOIN (
                    SELECT  product_id,
                            AVG(sales::numeric / ((1 - discount::numeric) * quantity::int)) AS unit_price
                    FROM orders
                    WHERE quantity IS NOT NULL
			        GROUP BY product_id
        ) AS sub
        ON o.product_id = sub.product_id
) AS sub2
WHERE quantity IS NULL;

WITH missing AS (
	SELECT product_id,
		discount, 
		market,
		region,
		sales,
		quantity
	FROM orders 
	WHERE quantity IS NULL
), 

unit_prices AS (SELECT o.product_id,
	CAST(o.sales / o.quantity AS NUMERIC) AS unit_price
FROM orders o
RIGHT JOIN missing AS m 
	ON o.product_id = m.product_id
	AND o.discount = m.discount
WHERE o.quantity IS NOT NULL
)

SELECT DISTINCT m.*,
	ROUND(CAST(m.sales AS NUMERIC) / up.unit_price,0) AS calculated_quantity
FROM missing AS m
INNER JOIN unit_prices AS up
	ON m.product_id = up.product_id;


