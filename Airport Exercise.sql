/*
Airports Exercise 

Data source: https://ourairports.com/data/
Data dictionary: https://ourairports.com/help/data-dictionary.html

In this exercise we analyse the countries, airports and airports_frequencies table
These have  matching columns: 
* airports.ident matches airport_frequencies.airport_ident
* countries.code matches airports.iso_country
*/

-- Show 10 sample rows of the airports table
SELECT 	TOP 10 * FROM 	countries c;

-- Show 10 sample rows of the airports table
SELECT 	TOP 10 * FROM 	airports a;

-- Show 10 sample rows of the airports_frequencies table
SELECT 	TOP 10 * FROM airport_frequencies af;

-- These are the more interesting columns of the airports table  that we use in this exercise
SELECT TOP 10
	a.ident
	, a.iata_code
	, a.name
	, a.[type]
	, a.latitude_deg
	, a.longitude_deg
	, a.elevation_ft
	, a.iso_country
FROM airports a;

-- How many airports are in the airports table?
SELECT count(*) FROM 	airports a;
-- How many frequencies are in the airport_frequencies table?
SELECT count(*) FROM 	airport_frequencies a;
-- How many airports of each type?
SELECT [type], count(id) as NumberofAirports
FROM 	airports a
GROUP by TYPE
order by NumberofAirports desc
-- Is the airport.ident column unique? i.e. there are no duplicate values
Select a.ident, COUNT(*) NumberofAirports
FROM airports as a 
GROUP BY a.ident
HAVING COUNT(*) >1
ORDER BY NumberofAirports desc
/*
Do a data quality check on the airports_frequencies table
Are there any orphan rows (frequencies without a matching airports)?
You can do this is several ways: LEFT JOIN, NOT IN, NOT EXISTS,...
*/
-- left join approach

SELECT count(*)
FROM airport_frequencies af
LEFT JOIN airports a ON af.airport_ident = a.ident
WHERE a.ident IS NULL;
-- NOT EXISTS approach	

SELECT count(*)
FROM airport_frequencies af
WHERE NOT EXISTS (
    SELECT 1
    FROM airports a
    WHERE af.airport_ident = a.ident
);
-- NOT IN approach	

SELECT count(*)
FROM airport_frequencies af
WHERE af.airport_ident NOT IN (
    SELECT a.ident
    FROM airports a
);
/*
1. List airports.  Show the following columns: ident, iata_code, name, latitude_deg, longitude_deg 
2. Filter to those airports
  (a) of large_airports type 
  (b) in the United Kingdom or France (iso_country  GB, FR) 
  [advanced - in Europe i.e., country.continent = 'EU']
  (c) that have a latitude between 49 and 54 degrees
3. Order from the most northern airports to most southern airports
*/
SELECT 
    a.ident,
    a.iata_code,
    a.name,
    a.latitude_deg,
    a.longitude_deg
FROM airports a
WHERE a.[type] = 'large_airport'
AND a.iso_country IN ('GB', 'FR')
AND a.latitude_deg BETWEEN 49 AND 54
ORDER BY a.latitude_deg DESC;

/*
List the iso_country of the 5 countries with the most airports 
List in order of number of airports (highest first)
*/


/*
How many airports are in those 5 countries (with the most airports)?
Use three different approaches: temp table, CTE, subquery
*/

-- Write the temp table approach below here


-- Write the CTE approach below here

-- Write the subquery approach below here

/*
List those large airports (if any) without a frequency 
*/


/*
List airports (if any) that have missing (NULL) values for *both* latitude or longitude.
*/

/*
List airports (if any) that have missing (NULL) values for *either* latitude or longitude  but not both.
This may indicate some sort of data quality issue.
*/
