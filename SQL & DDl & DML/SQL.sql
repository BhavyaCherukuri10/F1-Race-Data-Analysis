--Which country hosted most number of races from past 10 years. 
--Q1
SELECT circuits.country, COUNT(*) AS num_races
FROM races
JOIN circuits ON races.circuitId = circuits.circuitId
WHERE r_date >= NOW() - INTERVAL '10 years'
GROUP BY circuits.country
ORDER BY num_races DESC
LIMIT 1;




--Which circuit has highest number of races from 2012.
--Q2
SELECT circuits.name, COUNT(*) AS num_races
FROM races
JOIN circuits ON races.circuitId = circuits.circuitId
WHERE r_date >= '2012-01-01'
GROUP BY circuits.name
ORDER BY num_races DESC
LIMIT 1;

--In which country the (mercedes, ferrari, honda or Others) constructor has most number of wins in year 2022
--Q3
SELECT circuits.country, COUNT(*) AS num_wins
FROM races
JOIN constructorstandings ON races.raceId = constructorstandings.raceId
JOIN constructors ON constructorstandings.constructorsId = constructors.constructorId
JOIN circuits ON races.circuitId = circuits.circuitId
WHERE constructors.name = 'Mercedes' AND races.year = 2022
GROUP BY circuits.country
ORDER BY num_wins DESC
LIMIT 1;

-- Which constructor has most number of qualifyings in past 5 years
--Q4
SELECT constructors.name, COUNT(*) AS num_qualifyings
FROM qualifying
JOIN constructors ON qualifying.constructorId = constructors.constructorId
JOIN races ON qualifying.raceId = races.raceId
WHERE races.year >= DATE_PART('YEAR', NOW()) - 5
GROUP BY constructors.name
ORDER BY num_qualifyings DESC
LIMIT 1;

--How many times each driver won races and with which constructor he won it with.
--Q5
SELECT drivers.surname, constructors.name AS constructor, COUNT(*) AS num_wins
FROM results
JOIN drivers ON results.driverid = drivers.driverid
JOIN constructors ON results.constructorid = constructors.constructorid
WHERE results.position = 1
GROUP BY drivers.surname, constructors.name
ORDER BY drivers.surname ASC, num_wins DESC;

--How many unique drivers does  (any company) has presented in past 10 years. 
--How many unique drivers has ferrari produced in the last 10 years
--Q6
SELECT COUNT(DISTINCT drivers.driverid) AS num_unique_drivers, constructors.name AS Constructor_name
FROM results
JOIN drivers ON results.driverid = drivers.driverid
JOIN constructors ON results.constructorid = constructors.constructorid
WHERE constructors.name = 'Ferrari' AND results.raceid IN (
    SELECT raceid
    FROM races
    WHERE year >= extract(year FROM current_date) - 10
)
group by constructors.name;



--Which driver has least points and what is his position in the race?
--Q7
SELECT driverId, position, points
FROM driver_standings
WHERE position = (SELECT MIN(position) FROM driver_standings)
ORDER BY points ASC
LIMIT 1;


--what is the fastest pitstop made in past ten years and who made it.
--Q8
SELECT *
FROM pitstops
WHERE duration = (SELECT MIN(duration) FROM pitstops WHERE duration IS NOT NULL)
LIMIT 1;

--Which constructor has the best pitstop timing average in a.
--Q9
SELECT c.name as constructor_name, avg(p.duration) as avg_pitstop_duration
FROM constructors c
INNER JOIN results r ON r.constructorid = c.constructorid
INNER JOIN pitstops p ON p.raceid = r.raceid AND p.driverid = r.driverid
GROUP BY c.name
ORDER BY avg_pitstop_duration ASC
limit 20;


--who won the most number of titles in ##### race.(the name of a tournment or race)
--In the Bahrain Grand Prix Race
--Q10
SELECT drivers.forename, drivers.surname, COUNT(*) as num_wins
FROM drivers
JOIN results ON drivers.driverId = results.driverId
JOIN races ON races.raceId = results.raceId
WHERE races.name = 'Bahrain Grand Prix' AND results.position = 1
GROUP BY drivers.driverId
ORDER BY num_wins DESC
LIMIT 1;

--Which driver number has highest wins in the past 10 years
--Q11
SELECT results.number, COUNT(*) as wins
FROM results
JOIN drivers ON results.driverid = drivers.driverid
JOIN races ON results.raceid = races.raceid
WHERE races.year >= EXTRACT(YEAR FROM NOW()) - 10
GROUP BY results.number
ORDER BY wins DESC
LIMIT 1;
