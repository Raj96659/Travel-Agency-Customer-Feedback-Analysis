-- Question:  
-- What are the most common customer issues reported by travelers with an overall experience rating of 3 or lower?  

-- Creating a view to analyze the top customer issues based on feedback  
-- Only considering customers who rated their overall experience as 3 or lower  

CREATE VIEW CRA_Top_Customer_Issues AS  
SELECT  
    NaturOfIssue,  -- Type of issue reported  
    COUNT(*) AS Issue_Count,  -- Number of times the issue was reported  
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM purpledata2024), 2) AS Percentage  -- Issue percentage relative to total customers  
FROM purpledata2024  
WHERE OverallExperienceRate <= 3  -- Filtering for low overall experience ratings  
GROUP BY NaturOfIssue  
ORDER BY Issue_Count DESC;  -- Sorting by most frequently reported issues  
