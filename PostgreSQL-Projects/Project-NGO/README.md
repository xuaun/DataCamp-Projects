# Project: Impact Analysis of GoodThought NGO Initiatives
## Context and Questions to solve

### Write two SQL queries to answer the following questions:

- List the top five assignments based on total value of donations, categorized by donor type. The output should include four columns: 1) assignment_name, 2) region, 3) rounded_total_donation_amount rounded to two decimal places, and 4) donor_type, sorted by rounded_total_donation_amount in descending order. Save the result as highest_donation_assignments.

- Identify the assignment with the highest impact score in each region, ensuring that each listed assignment has received at least one donation. The output should include four columns: 1) assignment_name, 2) region, 3) impact_score, and 4) num_total_donations, sorted by region in ascending order. Include only the highest-scoring assignment per region, avoiding duplicates within the same region. Save the result as top_regional_impact_assignments.

Note: Please also ensure that you do not change the names of the DataFrames that the three query results will be saved as - creating new cells in the workbook will rename the DataFrame (see image below). Make sure that your final solutions use the names provided: highest_donation_assignments and top_regional_impact_assignments.

SQL cell showing the location of the DataFrame name field

## Code with solution
- ```Query (.sql)``` code [here](./workspace/ngo.sql)
- ```Jupyter Notebook (.ipynb)``` file [here](./workspace/notebook.ipynb)
