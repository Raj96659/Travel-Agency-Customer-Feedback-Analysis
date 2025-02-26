-- Question:  
-- Which booking sources have the highest uncertainty rate regarding customer rebooking decisions,  
-- considering only sources with more than 20 customers?  

-- Creating a view to analyze customer uncertainty by booking source  
-- Based on the 'BookBy' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Uncertainty_By_Booking_Source AS  
SELECT  
    BookBy,  
    COUNT(*) AS Total_Customers,  
    SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) AS Will_Book_Again,  
    SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) AS Will_Not_Book_Again,  
    SUM(CASE WHEN BookAgain = 'May Be' THEN 1 ELSE 0 END) AS Uncertain_Customers,  
    ROUND((SUM(CASE WHEN BookAgain = 'May Be' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Uncertainty_Rate  
FROM purpledata2024  
GROUP BY BookBy  
HAVING Total_Customers > 20  
ORDER BY Uncertainty_Rate DESC;  
