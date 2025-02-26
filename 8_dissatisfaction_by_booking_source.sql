-- Question:  
-- Which booking sources have the highest customer dissatisfaction rate,  
-- considering only sources with more than 10 customers?  

-- Creating a view to analyze customer dissatisfaction by booking source  
-- Based on the 'BookBy' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Dissatisfaction_By_Booking_Source AS  
SELECT  
    BookBy,  
    COUNT(*) AS Total_Customers,  
    SUM(CASE WHEN OverallExperienceRate <= 2 THEN 1 ELSE 0 END) AS Dissatisfied_Customers,  
    ROUND((SUM(CASE WHEN OverallExperienceRate <= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS Dissatisfaction_Rate  
FROM purpledata2024  
GROUP BY BookBy  
HAVING Total_Customers > 10  
ORDER BY Dissatisfaction_Rate DESC;  
