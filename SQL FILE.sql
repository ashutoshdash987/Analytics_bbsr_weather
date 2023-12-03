SELECT * FROM weather_analysis.bbsr;




SELECT 
    YEAR(date) as date_year, min(tmin), max(tmax)
FROM
    weather_analysis.bbsr
    group by date_year;
    
    
    
    
SELECT 
    b2.min_date AS max_temp, b1.tmax
FROM
    bbsr b1
        JOIN
    (SELECT 
        MIN(`date`) AS min_date
    FROM
        bbsr
    WHERE
        tmax > 35
    GROUP BY YEAR(`date`)) b2 ON b1.`date` = b2.min_date
