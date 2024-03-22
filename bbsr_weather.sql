SELECT * FROM weather_analysis.bbsr;

-- min. temp and max. temp year wise-- 

SELECT 
    YEAR(date) as date_year, min(tmin), max(tmax)
FROM
    weather_analysis.bbsr
    group by date_year;
    
-- date when summer hits year wise    

SELECT 
    b2.min_date AS date, b1.tavg
FROM
    bbsr b1
        JOIN
    (SELECT 
        MIN(`date`) AS min_date
    FROM
        bbsr
    WHERE
        tavg > 30
    GROUP BY YEAR(`date`)) b2 ON b1.`date` = b2.min_date;
    
-- date when winter hits year wise

SELECT 
    b1.datee AS date, bbsr.tavg
FROM
    bbsr
        JOIN
    (SELECT 
        MIN(date) AS datee
    FROM
        bbsr
    WHERE
        tavg < 25 AND MONTH(date) > 5
    GROUP BY YEAR(date)) b1 ON b1.datee = bbsr.date;


-- highest rainfall recorded year wise

SELECT 
    year(date) as year,MAX(prec) as max_rainfall
FROM
    bbsr
GROUP BY YEAR(date);

-- average rainfall recorded year wise

SELECT 
    year(date), round(avg(prec),2)
FROM
    bbsr
GROUP BY YEAR(date);

-- top 3 highest rainfall dates year wise

select a.date, a.prec from
(select 
date, prec, dense_rank() over w as row_num
from 
bbsr 
window w as (partition by year(date) order by prec desc)) a where a.row_num < 4;

-- top 3 highest temp. year wise

select a.date,a.tmax from
(select 
date, tmax, dense_rank() over w as row_num
from 
bbsr 
window w as (partition by year(date) order by tmax desc)) a where a.row_num < 4;