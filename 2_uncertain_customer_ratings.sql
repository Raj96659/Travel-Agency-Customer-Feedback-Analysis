-- Question:  
-- What are the average ratings for bus quality, punctuality, staff behavior,  
-- food quality, hotel quality, and tour manager service among customers  
-- who are uncertain about booking again (‘May Be’)?  

-- Creating a view to analyze ratings given by uncertain customers  
-- Based on the 'BookAgain' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Uncertain_Customer_Ratings AS  
SELECT  
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,  
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN CAST(PunctualityRate AS DECIMAL) END), 2) AS Avg_Punctuality,  
    ROUND(AVG(CASE WHEN StaffBehaviourRate > 1 THEN CAST(StaffBehaviourRate AS DECIMAL) END), 2) AS Avg_Staff_Behavior,  
    ROUND(AVG(CASE WHEN FoodQualityRate > 1 THEN CAST(FoodQualityRate AS DECIMAL) END), 2) AS Avg_FoodQuality,  
    ROUND(AVG(CASE WHEN HotelQualityRate > 1 THEN CAST(HotelQualityRate AS DECIMAL) END), 2) AS Avg_HotelQuality,  
    ROUND(AVG(CASE WHEN TourManagerRate > 1 THEN CAST(TourManagerRate AS DECIMAL) END), 2) AS Avg_TourManager  
FROM purpledata2024  
WHERE BookAgain = 'May Be';  
