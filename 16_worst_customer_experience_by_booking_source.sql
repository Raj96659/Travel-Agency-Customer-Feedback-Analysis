-- Question:  
-- Which booking source has the worst customer experience based on average ratings?  

-- Creating a view to analyze booking sources with the lowest customer experience ratings  
-- This helps identify the worst-performing sources in terms of overall satisfaction  

CREATE VIEW CRA_BKBY_Worst_Customer_Exp AS  
SELECT  
    BookBy,  -- Booking source/method  
    COUNT(*) AS Customer_Count,  -- Total number of customers per source  
    ROUND(AVG(CASE WHEN OverallExperienceRate > 1 THEN OverallExperienceRate END), 2) AS Avg_Experience,  -- Avg overall experience  
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN PunctualityRate END), 2) AS Avg_Punctuality,  -- Avg punctuality  
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,  -- Avg bus quality  
    ROUND(AVG(CASE WHEN FoodQualityRate > 1 THEN CAST(FoodQualityRate AS DECIMAL) END), 2) AS Avg_FoodQuality,  -- Avg food quality  
    ROUND(AVG(CASE WHEN HotelQualityRate > 1 THEN CAST(HotelQualityRate AS DECIMAL) END), 2) AS Avg_HotelQuality,  -- Avg hotel quality  
    ROUND(AVG(CASE WHEN TourManagerRate > 1 THEN CAST(TourManagerRate AS DECIMAL) END), 2) AS Avg_TourManager  -- Avg tour manager rating  
FROM purpledata2024  
GROUP BY BookBy  
HAVING COUNT(*) >= 10  -- Exclude sources with fewer than 10 bookings for better accuracy  
ORDER BY Avg_Experience ASC;  -- Sort by lowest customer experience rating  
