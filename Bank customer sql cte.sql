-- CTE 1: Churn Rate by Age Group
WITH age_churn AS (
    SELECT 
        CASE 
            WHEN age < 30 THEN '<30'
            WHEN age BETWEEN 30 AND 45 THEN '30-45'
            WHEN age BETWEEN 46 AND 60 THEN '46-60'
            ELSE '>60'
        END AS age_group,
        COUNT(*) AS total_customers,
        SUM(churn) AS churned,
        ROUND(SUM(churn)/COUNT(*)*100, 2) AS churn_rate
    FROM bank_project
    GROUP BY age_group
),
-- CTE 2: Country Risk
country_risk AS (
    SELECT 
        country,
        COUNT(*) AS total_customers,
        SUM(churn) AS churned,
        ROUND(SUM(churn)/COUNT(*)*100, 2) AS churn_rate
    FROM bank_project
    GROUP BY country
),
-- CTE 3: Balance Risk
balance_risk AS (
    SELECT 
        CASE
            WHEN balance = 0 THEN 'Zero Balance'
            WHEN balance < 50000 THEN 'Low'
            WHEN balance BETWEEN 50000 AND 100000 THEN 'Medium'
            ELSE 'High'
        END AS balance_segment,
        COUNT(*) AS total_customers,
        SUM(churn) AS churned,
        ROUND(SUM(churn)/COUNT(*)*100, 2) AS churn_rate
    FROM bank_project
    GROUP BY balance_segment
)

-- Final Output
SELECT 'Age Group' AS analysis_type, age_group AS segment, total_customers, churned, churn_rate FROM age_churn
UNION ALL
SELECT 'Country', country, total_customers, churned, churn_rate FROM country_risk
UNION ALL
SELECT 'Balance Segment', balance_segment, total_customers, churned, churn_rate FROM balance_risk
ORDER BY analysis_type, churn_rate DESC;