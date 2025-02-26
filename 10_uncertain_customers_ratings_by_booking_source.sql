-- Question:  
-- What are the average ratings given by uncertain customers ('May Be')  
-- for different booking sources, considering only sources with more than 10 uncertain customers?  

-- Creating a view to analyze ratings given by uncertain customers ('May Be')  
-- Based on the 'BookBy' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Uncertain_Customers_Rating_By_Booking_Source AS  
SELECT  
    BookBy,  
    COUNT(*) AS Uncertain_Customers,  -- Count of 'May Be' customers  
    ROUND(AVG(CASE WHEN OverallExperienceRate > 1 THEN CAST(OverallExperienceRate AS DECIMAL) END), 2) AS Avg_Rating,  
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN BusQualityRate END), 2) AS Avg_Bus_Quality,  
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN PunctualityRate END), 2) AS Avg_Punctuality,  
    ROUND(AVG(CASE WHEN StaffBehaviourRate > 1 THEN StaffBehaviourRate END), 2) AS Avg_Staff_Behavior,  
    ROUND(AVG(CASE WHEN FoodQualityRate > 1 THEN FoodQualityRate END), 2) AS Avg_Food_Quality,  
    ROUND(AVG(CASE WHEN HotelQualityRate > 1 THEN HotelQualityRate END), 2) AS Avg_Hotel_Quality,  
    ROUND(AVG(CASE WHEN TourManagerRate > 1 THEN TourManagerRate END), 2) AS Avg_Tour_Manager  
FROM purpledata2024  
WHERE BookAgain = 'May Be'  
GROUP BY BookBy  
HAVING Uncertain_Customers > 10  
ORDER BY Uncertain_Customers DESC;  -- Order by highest uncertain customers  
