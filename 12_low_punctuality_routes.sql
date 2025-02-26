-- Question:  
-- Which routes have the lowest average punctuality ratings, and how many customers traveled on these routes?  

-- Creating a view to analyze routes with low punctuality ratings  
-- Filtering out "Not Specified" ratings and only including routes with more than 10 customers  

CREATE VIEW CRA_Low_Punctuality_Routes AS  
SELECT  
    RouteName,  
    ROUND(AVG(PunctualityRate), 2) AS Avg_Punctuality,  -- Average punctuality rating per route  
    COUNT(*) AS Total_Customer  -- Total number of customers who traveled on each route  
FROM purpledata2024  
WHERE PunctualityRate > 1  -- Excluding "Not Specified" ratings  
GROUP BY RouteName  
HAVING Total_Customer > 10  -- Considering only routes with more than 10 customers  
ORDER BY Avg_Punctuality ASC;  -- Sorting by lowest punctuality rating first  
