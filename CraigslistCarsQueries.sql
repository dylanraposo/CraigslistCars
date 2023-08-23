-- Get an overview of the data and to easily refer to
SELECT * FROM dbo.cars

-- See the types of cars in data
SELECT DISTINCT Make FROM dbo.cars

-- Find overall average cost of used vehicles nationwide 
SELECT AVG(Price)
FROM dbo.cars;

-- Find average cost of vehicles per state sorted least to greatest
SELECT AVG(Price) as "Average Price", State 
FROM dbo.cars
GROUP BY State
ORDER BY AVG(Price) ASC;

-- Now find impact of location (Region) on price
SELECT State, Region, AVG(Price) AS AveragePrice
FROM dbo.cars
GROUP BY State, Region
ORDER BY State, AVG(Price)

-- Number of listings per manufacturer sorted highest to lowest
SELECT COUNT(ID) as 'Number of listings', Make 
FROM dbo.cars
GROUP BY Make
ORDER BY COUNT(ID) DESC;

-- Do manual cars have higher mileage? What about price?
SELECT Transmission, AVG(CAST(Mileage AS BIGINT)) as 'Average Mileage', AVG(Price) as 'Average Price'
FROM dbo.cars
GROUP BY Transmission;

-- Whats the percentage of Manual to Automatic transmissions?
SELECT Transmission , COUNT(ID) * 100.0 / (SELECT COUNT(ID) FROM dbo.cars) as Percentage
FROM dbo.cars
GROUP BY Transmission

-- Impact of paint on price
SELECT Paint, AVG(Price) AS AveragePrice
FROM dbo.cars
GROUP BY Paint
ORDER BY AveragePrice DESC;

-- Now find which paint colors are most common
SELECT Paint, COUNT(ID) * 100.0 / (SELECT COUNT(ID) FROM dbo.cars) as Percentage
FROM dbo.cars
GROUP BY Paint
ORDER BY Percentage DESC;


-- Find the average price of the top 5 car manufacturers and their car types
WITH RankedMakes AS (
    SELECT Make, Type, COUNT(*) AS MakeCount, ROW_NUMBER() OVER (PARTITION BY Type ORDER BY COUNT(*) DESC) AS MakeRank
    FROM dbo.cars
    GROUP BY Type, Make
)
SELECT 
    cars.Type, cars.Make, AVG(cars.Price) AS AveragePrice
FROM dbo.cars
	JOIN RankedMakes ON cars.Type = RankedMakes.Type AND cars.Make = RankedMakes.Make
WHERE RankedMakes.MakeRank <= 5
GROUP BY cars.Type, cars.Make
ORDER BY cars.Type, AveragePrice DESC;


-- Top car models for those manufactured after the year 2000. 
WITH RankedModels AS (
    SELECT 
        Year, 
        Model, 
        COUNT(*) AS ModelCount,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY COUNT(*) DESC) AS ModelRank
    FROM dbo.cars
	WHERE Year >= 2000
    GROUP BY Year, Model
)

SELECT 
    cars.Year,
    cars.Model, 
	COUNT(ID) AS NumberofListings,
    AVG(cars.Price) AS AveragePrice, 
    AVG(cars.Mileage) AS AverageMileage
FROM dbo.cars
JOIN RankedModels ON cars.Year = RankedModels.Year AND cars.Model = RankedModels.Model
WHERE RankedModels.ModelRank < 2
GROUP BY cars.Year, cars.Model
ORDER BY NumberofListings DESC, cars.Year, cars.Model;




