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

SELECT
    m.resort_id,
    r.resort_name,
    m.member_no, 
    m.member_gname || ' ' || m.member_fname AS member_name,
    TO_CHAR(m.member_date_joined, 'DD-Mon-YYYY') AS date_joined,
    rec.member_no || ' ' || rec.member_gname || ' ' || rec.member_fname AS recommended_by_details,
    LPAD('$' || TO_CHAR(ROUND(SUM(mc.mc_total), 0)), 13, ' ') AS total_charges
FROM
    tsa.member m 
    JOIN tsa.resort r 
    ON m.resort_id = r.resort_id
    JOIN tsa.town t 
    ON r.town_id = t.town_id
    JOIN tsa.member rec 
    ON m.member_id_recby = rec.member_id
    JOIN tsa.member_charge mc 
    ON m.member_id = mc.member_id
WHERE
    NOT (t.town_name = 'Byron Bay' AND t.town_state = 'NSW')
GROUP BY
    m.resort_id,
    r.resort_name,
    m.member_no,
    m.member_gname,
    m.member_fname,
    m.member_date_joined,
    rec.member_no,
    rec.member_gname,
    rec.member_fname
HAVING
    SUM(mc.mc_total) < (
        SELECT
            AVG(SUM(inner_mc.mc_total))
        FROM
            tsa.member_charge inner_mc
            JOIN tsa.member inner_m ON inner_mc.member_id = inner_m.member_id
        WHERE
            inner_m.resort_id = m.resort_id
        GROUP BY
            inner_m.member_id
    )
ORDER BY
    m.resort_id,
    m.member_no;

/*2(f)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
geodistance(- 28.000767, 153.429642, - 28.135731, 153.486923)
FROM dual;

SELECT
    r.resort_id,
    r.resort_name,
    poi.poi_name,
    t.town_name AS poi_town,
    t.town_state AS poi_state,
    NVL(TO_CHAR(poi.poi_open_time, 'HH12:MIAM'), 'Not Applicable') AS poi_opening_time,
    ROUND(geodistance(t.town_lat, t.town_long, tr.town_lat, tr.town_long), 1) AS DISTANCE
FROM
    tsa.RESORT r
    JOIN tsa.TOWN tr
    ON r.town_id = tr.town_id
    JOIN tsa.POINT_OF_INTEREST poi
    ON poi.town_id = tr.town_id
    JOIN tsa.TOWN t
    ON poi.town_id = t.town_id
WHERE
    geodistance(t.town_lat, t.town_long, tr.town_lat, tr.town_long) <= 100
ORDER BY
    r.resort_name,
    geodistance(t.town_lat, t.town_long, tr.town_lat, tr.town_long);
