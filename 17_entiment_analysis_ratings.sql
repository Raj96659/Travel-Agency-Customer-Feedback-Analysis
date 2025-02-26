-- Question:  
-- How do customer sentiments (positive, neutral, negative) correlate with different experience ratings?  

-- Creating a view for sentiment analysis based on customer remarks and ratings  
-- Categorizing feedback into Positive, Neutral, and Negative sentiments  

CREATE VIEW CRA_Sentiment_Analysis_on_Rating AS  
SELECT  
    Sentiment_Category,  -- Positive, Neutral, or Negative  
    COUNT(*) AS Feedback_Count,  -- Total feedback count per sentiment  
    ROUND(AVG(NULLIF(BusQualityRate, 1)), 2) AS Avg_BusQuality,  -- Avg bus quality excluding 'Not Specified'  
    ROUND(AVG(NULLIF(PunctualityRate, 1)), 2) AS Avg_Punctuality,  -- Avg punctuality rating  
    ROUND(AVG(NULLIF(OverallExperienceRate, 1)), 2) AS Avg_OverallExperience,  -- Avg overall experience rating  
    ROUND(AVG(NULLIF(FoodQualityRate, 1)), 2) AS Avg_FoodQuality,  -- Avg food quality rating  
    ROUND(AVG(NULLIF(HotelQualityRate, 1)), 2) AS Avg_HotelQuality  -- Avg hotel quality rating  
FROM (  
    SELECT  
        -- Sentiment categorization based on Remarks  
        CASE  
            WHEN LOWER(TRIM(Remarks)) LIKE '%excellent%'   
              OR LOWER(TRIM(Remarks)) LIKE '%good%'   
              OR LOWER(TRIM(Remarks)) LIKE '%satisfied%'   
              OR LOWER(TRIM(Remarks)) LIKE '%great%'  
              OR LOWER(TRIM(Remarks)) LIKE '%amazing%'  
              THEN 'Positive'  

            WHEN LOWER(TRIM(Remarks)) LIKE '%bad%'   
              OR LOWER(TRIM(Remarks)) LIKE '%poor%'   
              OR LOWER(TRIM(Remarks)) LIKE '%disappointed%'  
              OR LOWER(TRIM(Remarks)) LIKE '%worst%'  
              OR LOWER(TRIM(Remarks)) LIKE '%terrible%'  
              THEN 'Negative'  

            ELSE 'Neutral'  
        END AS Sentiment_Category,  
        BusQualityRate,  
        PunctualityRate,  
        OverallExperienceRate,  
        FoodQualityRate,  
        HotelQualityRate  
    FROM purpledata2024  
    WHERE   
        -- Include records where Remarks exist OR at least one rating is meaningful (>1)  
        COALESCE(TRIM(Remarks), '') <> ''    
        OR (BusQualityRate > 1 OR PunctualityRate > 1    
            OR OverallExperienceRate > 1 OR FoodQualityRate > 1    
            OR HotelQualityRate > 1)  
) AS Subquery  
GROUP BY Sentiment_Category  
ORDER BY Feedback_Count DESC;  
