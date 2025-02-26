-- Question:  
-- How do the average ratings for bus quality, punctuality, staff behavior,  
-- food quality, hotel quality, and tour manager service compare between  
-- customers who would book again (‘Yes’) and those who decided not to (‘No’)?  

-- Creating a view to compare customer ratings between rebooking and churned customers  
-- Based on the 'BookAgain' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Rebook_vs_Churned_Ratings AS  
SELECT  
    BookAgain,  
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,  
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN CAST(PunctualityRate AS DECIMAL) END), 2) AS Avg_Punctuality,  
    ROUND(AVG(CASE WHEN StaffBehaviourRate > 1 THEN CAST(StaffBehaviourRate AS DECIMAL) END), 2) AS Avg_Staff_Behavior,  
    ROUND(AVG(CASE WHEN FoodQualityRate > 1 THEN CAST(FoodQualityRate AS DECIMAL) END), 2) AS Avg_FoodQuality,  
    ROUND(AVG(CASE WHEN HotelQualityRate > 1 THEN CAST(HotelQualityRate AS DECIMAL) END), 2) AS Avg_HotelQuality,  
    ROUND(AVG(CASE WHEN TourManagerRate > 1 THEN CAST(TourManagerRate AS DECIMAL) END), 2) AS Avg_TourManager  
FROM purpledata2024  
WHERE BookAgain IN ('Yes', 'No')  
GROUP BY BookAgain;  
