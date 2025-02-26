-- Question:  
-- What is the total number of bookings made through each booking source,  
-- and which source has the highest number of bookings?  

-- Creating a view to analyze total bookings by source  
-- Based on the 'BookBy' column in the 'purpledata2024' dataset  

CREATE VIEW CRA_Total_Bookings_By_Source AS  
SELECT  
    BookBy,  
    COUNT(*) AS Total_Bookings  
FROM purpledata2024  
GROUP BY BookBy  
ORDER BY Total_Bookings DESC;  
