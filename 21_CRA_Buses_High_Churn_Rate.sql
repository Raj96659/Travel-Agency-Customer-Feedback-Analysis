-- Question:
-- Create a view to identify the top 10 buses with the highest churn rate, along with key experience metrics.

-- Description:
-- This view calculates the churn rate for each bus based on customers who responded "No" to booking again. It also provides average ratings for:

   -- Overall Experience
   -- Bus Quality
   -- Punctuality
   -- Staff Behaviour
   -- Food Quality
   -- Hotel Quality
   -- Tour Manager

--To maintain data quality, only buses with more than 5 customers are considered. The buses are ranked in descending order of churn rate, with the top 10 worst performers listed.


CREATE VIEW 19_CRA_Buses_High_Churn_Rate AS
SELECT 
    BusNo,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) AS Will_Not_Book_Again,
    ROUND((SUM(CASE WHEN BookAgain = 'No' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Churn_Rate,
    ROUND(AVG(CASE WHEN OverallExperienceRate > 1 THEN CAST(OverallExperienceRate AS DECIMAL) END), 2) AS Avg_Experience,
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN CAST(PunctualityRate AS DECIMAL) END), 2) AS Avg_Punctuality,
    ROUND(AVG(CASE WHEN StaffBehaviourRate > 1 THEN CAST(StaffBehaviourRate AS DECIMAL) END), 2) AS Avg_StaffBehaviour,
    ROUND(AVG(CASE WHEN FoodQualityRate > 1 THEN CAST(FoodQualityRate AS DECIMAL) END), 2) AS Avg_FoodQuality,
    ROUND(AVG(CASE WHEN HotelQualityRate > 1 THEN CAST(HotelQualityRate AS DECIMAL) END), 2) AS Avg_HotelQuality,
    ROUND(AVG(CASE WHEN TourManagerRate > 1 THEN CAST(TourManagerRate AS DECIMAL) END), 2) AS Avg_TourManager
FROM purpledata2024
GROUP BY BusNo
HAVING Total_Customers > 5
ORDER BY Churn_Rate DESC
LIMIT 10; -- Get top 10 buses with highest churn
