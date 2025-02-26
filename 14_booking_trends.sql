-- Question:  
-- What are the booking trends by day of the week, and how many repeat customers book on each day?  

-- Creating a view to analyze booking trends based on the day of the week  
-- This also highlights how many customers book again (repeat customers)  

CREATE VIEW CRA_Booking_Trends AS  
SELECT  
    DayName,  -- Day of the week when the booking occurred  
    COUNT(*) AS Total_Trips,  -- Total number of trips booked on that day  
    SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) AS Repeat_Customers  -- Count of repeat customers  
FROM purpledata2024  
GROUP BY DayName  
ORDER BY Total_Trips DESC;  -- Sorting by the highest number of bookings  
