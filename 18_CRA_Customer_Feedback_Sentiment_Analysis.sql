CREATE VIEW 18_CRA_Customer_Feedback_Sentiment_Analysis AS
WITH SentimentAnalysis AS (
    SELECT 
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
        HotelQualityRate,
        BookAgain
    FROM purpledata2024
    WHERE 
        COALESCE(TRIM(Remarks), '') <> ''  
        OR (BusQualityRate > 1 OR PunctualityRate > 1 
            OR OverallExperienceRate > 1 OR FoodQualityRate > 1 
            OR HotelQualityRate > 1)
)

SELECT 
    Sentiment_Category,
    COUNT(*) AS Feedback_Count,
    ROUND(AVG(NULLIF(PunctualityRate, 1)), 2) AS Avg_Punctuality,  
    ROUND(AVG(NULLIF(OverallExperienceRate, 1)), 2) AS Avg_OverallExperience,
    -- Breakdown of "Book Again" behavior
    COUNT(CASE WHEN BookAgain = 'Yes' THEN 1 END) AS BookAgain_Yes_Count,
    COUNT(CASE WHEN BookAgain = 'No' THEN 1 END) AS BookAgain_No_Count,
    COUNT(CASE WHEN BookAgain = 'May Be' THEN 1 END) AS BookAgain_Maybe_Count
    
FROM SentimentAnalysis
GROUP BY Sentiment_Category
ORDER BY Feedback_Count DESC;
