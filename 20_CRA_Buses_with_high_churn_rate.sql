-- Question:
-- Create a view to identify the top 10 buses with the highest churn rate, based on customer responses regarding their willingness to book again.

-- Description:
-- This view analyzes customer retention by categorizing feedback into:
    --Will Book Again (Yes)
    -- Will Not Book Again (No)
    --Uncertain Customers (May Be)
--It calculates the Retention Rate, Churn Rate, and Uncertainty Rate for each bus and filters only those with more than 5 customers to avoid small sample biases. 
--The buses are ranked in descending order of churn rate, with the top 10 worst performers listed.

CREATE VIEW 18_CRA_Buses_with_high_churn_rate AS
SELECT 
    BusNo,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) AS Will_Book_Again,
    SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) AS Will_Not_Book_Again,
    SUM(CASE WHEN BookAgain = 'May Be' THEN 1 ELSE 0 END) AS Uncertain_Customers,
    ROUND((SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Retention_Rate,
    ROUND((SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Churn_Rate,
    ROUND((SUM(CASE WHEN BookAgain = 'May Be' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Uncertainty_Rate
FROM purpledata2024
GROUP BY BusNo
HAVING Total_Customers > 5
ORDER BY Churn_Rate DESC
LIMIT 10; -- Get top 10 buses with highest churn
