-- # GoodThought NGO has been a catalyst for positive change, focusing its efforts on education, healthcare, and sustainable development to make a significant difference in communities worldwide. With this mission, GoodThought has orchestrated an array of assignments aimed at uplifting underprivileged populations and fostering long-term growth.
-- # 
-- # This project offers a hands-on opportunity to explore how data-driven insights can direct and enhance these humanitarian efforts. In this project, you'll engage with the GoodThought PostgreSQL database, which encapsulates detailed records of assignments, funding, impacts, and donor activities from 2010 to 2023. This comprehensive dataset includes:
-- # 
-- # - **`Assignments`:** Details about each project, including its name, duration (start and end dates), budget, geographical region, and the impact score.
-- # - **`Donations`:** Records of financial contributions, linked to specific donors and assignments, highlighting how financial support is allocated and utilized.
-- # - **`Donors`:** Information on individuals and organizations that fund GoodThought’s projects, including donor types.
-- # 
-- # Refer to the below ERD diagram for a visual representation of the relationships between these data tables:
-- # <img src="erd.png" alt="ERD" width="50%" height="50%">
-- # 
-- # 
-- # You will execute SQL queries to answer two questions, as listed in the instructions. Good luck!
-- # 

SELECT *
FROM public.assignments
LIMIT 5;

SELECT *
FROM public.donations
LIMIT 5;

SELECT *
FROM public.donors
LIMIT 5;

-- highest_donation_assignments
SELECT 
	a.assignment_name,
	a.region,
	ROUND(SUM(d.amount), 2) AS rounded_total_donation_amount,
	dr.donor_type
FROM assignments AS a
INNER JOIN donations AS d
USING(assignment_id)
INNER JOIN donors AS dr
USING(donor_id)
GROUP BY assignment_name, region, donor_type
ORDER BY rounded_total_donation_amount DESC
LIMIT 5;

-- top_regional_impact_assignments
SELECT
	a.assignment_name,
	a.region,
	a.impact_score,
	d.num_total_donations
FROM assignments AS a
INNER JOIN (
	SELECT assignment_id, COUNT(*) AS num_total_donations
	FROM donations
	WHERE amount <> 0
	GROUP BY assignment_id
) AS d
USING(assignment_id)
INNER JOIN (
	SELECT assignment_id, ROW_NUMBER() OVER(PARTITION BY region ORDER BY impact_score DESC) AS rank
	FROM assignments
) AS sub_rank
USING(assignment_id)
WHERE 
	rank = 1
ORDER BY region ASC;


