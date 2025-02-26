-- Question:
-- Create a view to identify the 10 buses with the lowest overall experience ratings, along with their bus quality, punctuality, and staff behavior ratings. 
-- The analysis excludes "Not Specified" ratings (values ≤ 1) and considers only buses with more than 10 customers.

-- Description:
-- This view calculates the average overall experience rating for each bus, along with other key service quality parameters such as bus quality, punctuality, and staff behavior. 
-- The buses are ranked in ascending order of average overall experience to identify the worst-performing ones.


CREATE VIEW 17_CRA_Buses_with_poor_overallexp AS 
SELECT 
    BusNo,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN OverallExperienceRate > 1 THEN CAST(OverallExperienceRate AS DECIMAL) END), 2) AS Avg_Experience,
    ROUND(AVG(CASE WHEN BusQualityRate > 1 THEN CAST(BusQualityRate AS DECIMAL) END), 2) AS Avg_Bus_Quality,
    ROUND(AVG(CASE WHEN PunctualityRate > 1 THEN CAST(PunctualityRate AS DECIMAL) END), 2) AS Avg_Punctuality,
    ROUND(AVG(CASE WHEN StaffBehaviourRate > 1 THEN CAST(StaffBehaviourRate AS DECIMAL) END), 2) AS Avg_StaffBehaviour
FROM purpledata2024
GROUP BY BusNo
HAVING Total_Customers > 10
ORDER BY Avg_Experience ASC
LIMIT 10; -- Get the 10 worst-rated buses
