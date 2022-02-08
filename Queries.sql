#Select the “institution_name”, “city”, and “state_name” for the 10 institutions with the most “office_count_domestic”.
SELECT institution_name, city, state_name, SUM(office_count_domestic) AS dom_office_tot
FROM `bigquery-public-data.fdic_banks.institutions` 
GROUP BY institution_name, city, state_name
ORDER BY dom_office_tot DESC
LIMIT 10;

#Select number of hospitals (“hospital_name”) in each zip code (“zip_code”) from the “hospital_general_info” table. 
SELECT zip_code, COUNT(hospital_name) as hospital_num 
FROM `bigquery-public-data.cms_medicare.hospital_general_info` 
GROUP BY zip_code 
ORDER BY hospital_num DESC; 

#Select the number of hospitals and population for the 5 zip codes with the greatest populations. 
SELECT cen.zipcode, cen.population, COUNT(cms.hospital_name) AS totalHosp 
FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010` cen 
JOIN `bigquery-public-data.cms_medicare.hospital_general_info` cms 
ON cms.zip_code = cen.zipcode 
GROUP BY zipcode, population 
ORDER BY population DESC 
LIMIT 5; 

#Select the number of hospitals, population, and number of bank branches (“branch_fdic_uninum”) for the 20 zip codes with the greatest populations. 
SELECT cen.zipcode, cen.population, COUNT(DISTINCT(cms.hospital_name)) AS hospNum, COUNT(fdic.branch_fdic_uninum) AS bankNum 
FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010` cen  
JOIN `bigquery-public-data.cms_medicare.hospital_general_info` cms 
ON cen.zipcode = cms.zip_code 
JOIN `bigquery-public-data.fdic_banks.locations` fdic 
ON cms.zip_code = fdic.zip_code 
GROUP BY cen.zipcode, cen.population 
ORDER BY cen.population DESC  
LIMIT 20; 

#Write a SQL statement to find the distinct NBA MVPs that have a first name that starts with “M”.
SELECT DISTINCT(Player) 
FROM nba_data.nba_mvps 
WHERE Player LIKE "M%";

#Write a SQL statement that shows the Year, Finals MVP, and MVP for each year from 1990 to 2020.
SELECT ft.Year, ft.Finals_MVP, mv.Player AS MVP 
FROM nba_data.nba_finals_teams ft
JOIN nba_data.nba_mvps mv
ON ft.Year = mv.Season
WHERE Year BETWEEN 1990 AND 2020 
ORDER BY Year ASC;

#Write a SQL statement to find the Team and Name of the 3 NBA MVP’s on Teams with the most Losses (“L”).
SELECT mvp.Tm, mvp.Player, ts.L AS Lost 
FROM nba_data.nba_mvps mvp
JOIN nba_data.nba_team_stats ts
ON mvp.Tm = ts.Team AND mvp.Season = ts.Year 
ORDER BY Lost DESC
LIMIT 3;





