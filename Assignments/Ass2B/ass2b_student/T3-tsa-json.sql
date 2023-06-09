--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-tsa-json.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

/* Comments for your marker:




*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    JSON_OBJECT (   '_id' VALUE t.town_id,
                    'name' VALUE t.town_name || ', ' || t.town_state,
                    'location' VALUE JSON_OBJECT (
                    'latitude' VALUE t.town_lat,
                    'longitude' VALUE t.town_long
                ),
                'avg_temperature' VALUE JSON_OBJECT (
                    'summer' VALUE t.town_avg_summer_temp,
                    'winter' VALUE t.town_avg_winter_temp
                ),
                'no_of_resorts' VALUE COUNT(r.resort_id),
                'resorts' VALUE JSON_ARRAYAGG (
                    JSON_OBJECT (
                    'id' VALUE r.resort_id,
                    'name' VALUE r.resort_name,
                    'address' VALUE r.resort_street_address,
                    'phone' VALUE r.resort_phone,
                    'year_built' VALUE EXTRACT(YEAR FROM r.resort_yr_built_purch
                ),
                'company_name' VALUE c.company_name
                )
                )
                ) || ','
FROM
    tsa.TOWN t
    LEFT JOIN tsa.RESORT r 
    ON t.town_id = r.town_id
    LEFT JOIN tsa.COMPANY c 
    ON r.company_abn = c.company_abn
GROUP BY
    t.town_id,
    t.town_name,
    t.town_state,
    t.town_lat,
    t.town_long,
    t.town_avg_summer_temp,
    t.town_avg_winter_temp
ORDER BY
    t.town_id;
