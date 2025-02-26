-- Question:  
-- How does punctuality rating impact the percentage of repeat customers who choose to book again?  

-- Creating a view to analyze the relationship between punctuality ratings and repeat bookings  
-- Based on the 'PunctualityRate' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Punctuality_Repeat_Customers AS  
SELECT  
    PunctualityRate,  
    COUNT(*) AS Total_Trips,  -- Total number of trips for each punctuality rating  
    SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) AS Repeat_Customers,  -- Count of customers who will book again  
    ROUND(100.0 * SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Repeat_Booking_Percentage  -- Percentage of repeat customers  
FROM purpledata2024  
-- WHERE PunctualityRate > 1 -- Uncomment to exclude "Not Specified" ratings if needed  
GROUP BY PunctualityRate  
ORDER BY PunctualityRate DESC;  -- Sorting by highest punctuality rating  
