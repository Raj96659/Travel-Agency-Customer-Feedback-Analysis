-- Question:  
-- How does the average customer experience rating vary across different booking sources,  
-- considering only sources with more than 10 customers?  

-- Creating a view to analyze customer experience by booking source  
-- Based on the 'BookBy' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Customer_Experience_By_Booking_Source AS  
SELECT  
    BookBy,  
    COUNT(*) AS Customer_Count,  
    ROUND(AVG(CASE WHEN OverallExperienceRate > 1 THEN CAST(OverallExperienceRate AS DECIMAL) END), 2) AS Avg_Experience,  
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,  
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN CAST(PunctualityRate AS DECIMAL) END), 2) AS Avg_Punctuality  
FROM purpledata2024  
GROUP BY BookBy  
HAVING Customer_Count > 10  
ORDER BY Avg_Experience DESC;  
