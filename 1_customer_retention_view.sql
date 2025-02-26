-- Question:  
-- What is the total number of customers, and how many of them are likely  
-- to book again, not book again, or are uncertain?  
-- Additionally, what are the customer retention, churn, and uncertainty rates?  


-- Creating a view to analyze customer retention and churn rates  
-- Based on the 'BookAgain' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Customer_Retention_Churn AS  
SELECT  
    COUNT(*) AS Total_Customers,  
    SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) AS Will_Book_Again,  
    SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) AS Will_Not_Book_Again,  
    SUM(CASE WHEN BookAgain = 'May Be' THEN 1 ELSE 0 END) AS Uncertain_Customers,  
    ROUND((SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Retention_Rate,  
    ROUND((SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Churn_Rate,  
    ROUND((SUM(CASE WHEN BookAgain = 'May Be' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Uncertainty_Rate  
FROM purpledata2024;  
