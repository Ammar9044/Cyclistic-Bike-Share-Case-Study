-- 1. Calculate average ride length
SELECT 
  ROUND(AVG(ride_length), 3) AS average_ride_length
FROM 
  cyclistic_data;

-- 2. Find the maximum ride length
SELECT 
  MAX(ride_length) AS max_ride_length
FROM 
  cyclistic_data;

-- 3. Identify the most frequent day for rides
SELECT 
  day_of_week, 
  COUNT(*) AS frequency
FROM 
  cyclistic_data
GROUP BY 
  day_of_week
ORDER BY 
  frequency DESC
LIMIT 1;

-- 4. Total rides by user type and day of the week
SELECT 
  member_casual, 
  day_of_week, 
  COUNT(*) AS total_rides
FROM 
  cyclistic_data
GROUP BY 
  member_casual, 
  day_of_week
ORDER BY 
  member_casual, 
  day_of_week;

-- 5. Percentage share of total rides by each user type
SELECT 
  member_casual,
  COUNT(*) AS total_rides,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cyclistic_data), 2) AS percentage_of_total
FROM 
  cyclistic_data
GROUP BY 
  member_casual;

-- 6. Top 3 starting stations used by casual riders
SELECT 
  start_station_name,
  COUNT(*) AS total_rides
FROM 
  cyclistic_data
WHERE 
  member_casual = 'casual'
GROUP BY 
  start_station_name
ORDER BY 
  total_rides DESC
LIMIT 3;

-- 7. Count of rideable types used by each user type
SELECT 
  member_casual,
  rideable_type,
  COUNT(*) AS total_rides
FROM 
  cyclistic_data
GROUP BY 
  member_casual, 
  rideable_type
ORDER BY 
  member_casual, 
  total_rides DESC;
