--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-tsa-select.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    t.town_id,
    t.town_name,
    pt.poi_type_id,
    pt.poi_type_descr,
    COUNT(*) AS poi_count
FROM
         tsa.town t
    JOIN tsa.point_of_interest poi
    ON t.town_id = poi.town_id
    JOIN tsa.poi_type          pt
    ON poi.poi_type_id = pt.poi_type_id
WHERE
    t.town_id IN (
        SELECT
            town_id
        FROM
            tsa.point_of_interest
        GROUP BY
            town_id
        HAVING
            COUNT(DISTINCT poi_type_id) > 1
    )
GROUP BY
    t.town_id,
    t.town_name,
    pt.poi_type_id,
    pt.poi_type_descr
HAVING
    COUNT(*) > 1
ORDER BY
    t.town_id,
    pt.poi_type_descr;

/*2(b)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
    
SELECT
    m.member_id,
    m.member_gname
    || ' '
    || m.member_fname   AS member_name,
    m.resort_id,
    r.resort_name,
    COUNT(m2.member_id) AS number_of_recommendations
FROM
    tsa.member m
    LEFT OUTER JOIN tsa.member m2
    ON m.member_id = m2.member_id_recby
    JOIN tsa.resort r
    ON m.resort_id = r.resort_id
WHERE
    m2.member_id IS NOT NULL
GROUP BY
    m.member_id,
    m.member_gname,
    m.member_fname,
    m.resort_id,
    r.resort_name
ORDER BY
    m.resort_id,
    m.member_id;
    
/*2(c)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.poi_id,
    p.poi_name,
    CASE
        WHEN MAX(r.review_rating) IS NULL THEN
            'NR'
        ELSE
            to_char(MAX(r.review_rating))
    END AS max_rating,
    CASE
        WHEN MIN(r.review_rating) IS NULL THEN
            'NR'
        ELSE
            to_char(MIN(r.review_rating))
    END AS min_rating,
    CASE
        WHEN COUNT(r.review_rating) = 0 THEN
            'NR'
        ELSE
            to_char(round(AVG(r.review_rating),1))
    END AS avg_rating
FROM
    tsa.point_of_interest p
    LEFT OUTER JOIN tsa.review  r
    ON p.poi_id = r.poi_id
GROUP BY
    p.poi_id,
    p.poi_name
ORDER BY
    p.poi_id;

/*2(d)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    poi.poi_name,
    pt.poi_type_descr,
    t.town_name,
    'Lat: ' || TO_CHAR(t.town_lat) || 
    ' Long: ' || TO_CHAR(t.town_long) AS town_location,
    (SELECT COUNT(*) FROM tsa.REVIEW WHERE REVIEW.poi_id = poi.poi_id) AS reviews_completed,
    CASE
        WHEN (SELECT COUNT(*) FROM tsa.REVIEW WHERE tsa.REVIEW.poi_id = tsa.poi.poi_id) > 0 
        THEN
            TO_CHAR(
                ((SELECT COUNT(*) FROM tsa.REVIEW WHERE tsa.REVIEW.poi_id = tsa.poi.poi_id) 
                / (SELECT COUNT(*) FROM tsa.REVIEW) * 100), 'FM990.99'
            ) || ' %'
        ELSE
            'No reviews completed'
    END AS percent_of_reviews
FROM
        tsa.point_of_interest poi
    JOIN tsa.poi_type pt 
    ON poi.poi_type_id = pt.poi_type_id
    JOIN tsa.town t 
    ON poi.town_id = t.town_id
ORDER BY
    t.town_name,
    (SELECT COUNT(*) FROM tsa.REVIEW WHERE tsa.REVIEW.poi_id = tsa.poi.poi_id) DESC,
    poi.poi_name;

/*2(e)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer



/*2(f)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

