USE bank_project;

DROP TABLE IF EXISTS bank_project;

CREATE TABLE bank_project (
    customer_id VARCHAR(20),
    credit_score INT,
    country VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    tenure INT,
    balance DECIMAL(15,2),
    products_number INT,
    credit_card TINYINT,
    active_member TINYINT,
    estimated_salary DECIMAL(15,2),
    churn TINYINT
);
SELECT 
    SUM(churn) AS total_churned,
    ROUND(SUM(churn)/COUNT(*)*100,2) AS churn_rate_percentage
FROM bank_project;
SELECT 
    CASE 
        WHEN age < 30 THEN '<30'
        WHEN age BETWEEN 30 AND 45 THEN '30-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '>60'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned,
    ROUND(SUM(churn)/COUNT(*)*100,2) AS churn_rate
FROM bank_project
GROUP BY age_group
ORDER BY age_group;

SELECT country,
       COUNT(*) AS total_customers,
       SUM(churn) AS churned,
       ROUND(SUM(churn)/COUNT(*)*100,2) AS churn_rate
FROM bank_project
GROUP BY country
ORDER BY churn_rate DESC;

SELECT gender,
       COUNT(*) AS total_customers,
       SUM(churn) AS churned,
       ROUND(SUM(churn)/COUNT(*)*100,2) AS churn_rate
FROM bank_project
GROUP BY gender;

SELECT tenure,
       COUNT(*) AS total_customers,
       SUM(churn) AS churned,
       ROUND(SUM(churn)/COUNT(*)*100,2) AS churn_rate
FROM bank_project
GROUP BY tenure
ORDER BY tenure;
SELECT gender,
       COUNT(*) AS total_customers,
       SUM(churn) AS total_churned,
       ROUND(SUM(churn)/COUNT(*)*100,2) AS churn_rate_percentage
FROM bank_customers
GROUP BY gender;
SELECT tenure,
       COUNT(*) AS total_customers,
       SUM(churn) AS total_churned,
       ROUND(SUM(churn)/COUNT(*)*100,2)
AS churn_rate
From bank_project
Group by tenure
Order by tenure;
Select credit_card,
       count(*) AS total_customers,
       sum(churn) AS churned,
       Round(sum(churn)/count(*)*100,2)
AS churn_rate
From bank_project
Group by credit_card;