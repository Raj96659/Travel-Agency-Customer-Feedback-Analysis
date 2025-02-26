-- Question:  
-- What is the customer retention risk by booking method, and which sources have the lowest repeat booking percentage?  

-- Creating a view to analyze retention risk based on booking sources  
-- This identifies which sources have the highest and lowest repeat customer percentages  

CREATE VIEW CRA_BKBY_Retention_Risk AS  
SELECT  
    BookBy,  -- Booking source/method  
    COUNT(PNRNO) AS Total_Bookings,  -- Total bookings from this source  
    SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) AS Repeat_Customers,  -- Customers who booked again  
    (SUM(CASE WHEN BookAgain = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(PNRNO)) AS Repeat_Percentage  -- Repeat booking percentage  
FROM purpledata2024  
GROUP BY BookBy  
HAVING COUNT(PNRNO) >= 10  -- Exclude methods with fewer than 10 bookings for better insights  
ORDER BY Repeat_Percentage ASC;  -- Sort by lowest repeat percentage (highest retention risk)  
