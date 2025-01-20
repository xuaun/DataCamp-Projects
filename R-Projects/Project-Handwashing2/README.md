# Project: Dr. Semmelweis and the Importance of Handwashing
## Context and Questions to solve

### How much did handwashing reduce monthly death rates on average?

- Load the CSV files into yearly and monthly data frames and check the data.

- Add a proportion_deaths column to each df, calculating the proportion of deaths per number of births for each year in yearly and month in monthly.

- Create two ggplot line plots: one for the yearly proportion of deaths and another for the monthly proportion of deaths. For the yearly plot, create a different colored line for each clinic.

- Add a handwashing_started boolean column to monthly using June 1st, 1847 as the threshold; TRUE should mean that handwashing has started at the clinic. Plot the new df with different colored lines depending on handwashing_started.

- Calculate the mean proportion of deaths before and after handwashing from the monthly data, and store the result as a 2x2 df named monthly_summary with the first column containing the handwashing_started groups and the second column having the mean proportion of deaths.

## Code with solution
- ```Script (.R)``` code [here](./workspace/handwashing2.R)
- ```Jupyter Notebook (.ipynb)``` file [here](./workspace/notebook.ipynb)
