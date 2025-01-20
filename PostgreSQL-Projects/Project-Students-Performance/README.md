# Project: Factors that Fuel Student Performance
## Context and Questions to solve

### Write three SQL queries to answer the following questions:

1. Do more study hours and extracurricular activities lead to better scores? Analyze how studying more than 10 hours per week, while also participating in extracurricular activities, impacts exam performance. The output should include two columns: 1) hours_studied and 2) avg_exam_score. Group and sort the results by hours_studied in descending order. Save the query as avg_exam_score_by_study_and_extracurricular.

2. Is there a sweet spot for study hours? Explore how different ranges of study hours impact exam performance by calculating the average exam score for each study range. Categorize students into four groups based on hours studied per week: 1-5 hours, 6-10 hours, 11-15 hours, and 16+ hours. The output should contain two columns: 1) hours_studied_range and 2) avg_exam_score. Group the results by hours_studied_range and sort them by avg_exam_score in descending order. Save the query as avg_exam_score_by_hours_studied_range.

3. A teacher wants to show their students their relative rank in the class, without revealing their exam scores to each other. Use a window function to assign ranks based on exam_score, ensuring that students with the same exam score share the same rank and no ranks are skipped. Return the columns attendance, hours_studied, sleep_hours, tutoring_sessions, and exam_rank. The students with the highest exam score should be at the top of the results, so order your query by exam_rank in ascending order. Limit your query to 30 students.

## Code with solution
- ```Query (.sql)``` code [here](./workspace/students-performance.sql)
- ```Jupyter Notebook (.ipynb)``` file [here](./workspace/notebook.ipynb)
