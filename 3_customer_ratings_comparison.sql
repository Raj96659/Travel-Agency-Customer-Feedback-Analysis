-- Question:  
-- What are the average ratings for bus quality, punctuality, staff behavior,  
-- food quality, hotel quality, and tour manager service for customers who  
-- are either willing to book again (‘Yes’) or uncertain (‘May Be’)?  
-- How do these ratings differ between the two groups?  

-- Creating a grouped analysis of customer ratings based on 'BookAgain' status  

SELECT  
    BookAgain,  
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,  
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN CAST(PunctualityRate AS DECIMAL) END), 2) AS Avg_Punctuality,  
    ROUND(AVG(CASE WHEN StaffBehaviourRate > 1 THEN CAST(StaffBehaviourRate AS DECIMAL) END), 2) AS Avg_Staff_Behavior,  
    ROUND(AVG(CASE WHEN FoodQualityRate > 1 THEN CAST(FoodQualityRate AS DECIMAL) END), 2) AS Avg_FoodQuality,  
    ROUND(AVG(CASE WHEN HotelQualityRate > 1 THEN CAST(HotelQualityRate AS DECIMAL) END), 2) AS Avg_HotelQuality,  
    ROUND(AVG(CASE WHEN TourManagerRate > 1 THEN CAST(TourManagerRate AS DECIMAL) END), 2) AS Avg_TourManager  
FROM purpledata2024  
WHERE BookAgain IN ('Yes', 'May Be')  
GROUP BY BookAgain;  
