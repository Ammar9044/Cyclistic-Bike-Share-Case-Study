-- Step 1: Create table
Create Table `cyclistic_data` (
  `ï»¿ride_id` Text,
  `rideable_type` Text,
  `started_at` Text,
  `ended_at` Text,
  `start_station_name` Text,
  `start_station_id` Text,
  `end_station_name` Text,
  `end_station_id` Text,
  `start_lat` Text,
  `start_lng` Text,
  `end_lat` Text,
  `end_lng` Text,
  `member_casual` Text,
  `ride_lenght` Text,
  `day_of_week` Text
) Engine=InnoDB Default Charset=utf8mb4 Collate=utf8mb4_0900_ai_ci;

-- Step 2: Convert date columns to DATETIME
Update cyclistic_data
Set started_at = Str_To_Date(started_at, '%m/%d/%Y %H:%i'),
    ended_at = Str_To_Date(ended_at, '%m/%d/%Y %H:%i');

Alter Table cyclistic_data
Modify Column started_at Datetime;

Alter Table cyclistic_data
Modify Column ended_at Datetime;

-- Step 3: Clean and convert lat/lng columns to DOUBLE
Update cyclistic_data
Set 
  start_lat = Nullif(Trim(start_lat), ''),
  start_lng = Nullif(Trim(start_lng), ''),
  end_lat = Nullif(Trim(end_lat), ''),
  end_lng = Nullif(Trim(end_lng), '');

Alter Table cyclistic_data
Modify Column start_lat Double,
Modify Column start_lng Double,
Modify Column end_lat Double,
Modify Column end_lng Double;

-- Step 4: Clean and convert ride_lenght to TIME
Update cyclistic_data
Set ride_lenght = Null
Where ride_lenght Not Regexp '^[0-9]{1,2}:[0-9]{2}(:[0-9]{2})?$';

Alter Table cyclistic_data
Modify Column ride_lenght Time;

-- Step 5: Convert day_of_week to INT
Alter Table cyclistic_data
Modify Column day_of_week Int;

-- Step 6: Rename column and set primary key
Alter Table cyclistic_data
Change Column `ï»¿ride_id` ride_id Varchar(50);

-- Changing Column name 
Alter Table cyclistic_data
Change Column `ride_lenght` ride_length time;

Alter Table cyclistic_data
Add Primary Key (ride_id);

-- Step 7: Final text column type conversions
Alter Table cyclistic_data
Modify Column rideable_type Varchar(50),
Modify Column start_station_name Text,
Modify Column start_station_id Varchar(50),
Modify Column end_station_name Text,
Modify Column end_station_id Varchar(50),
Modify Column member_casual Varchar(50);

-- Step 8: Remove invalid scientific notation ride_id
Delete From cyclistic_data
Where ride_id = '7.81E+15';

-- Step 9:  Check for duplicate ride_ids
Select ride_id, Count(*) 
From cyclistic_data
Group By ride_id
Having Count(*) > 1;


-- Optional: Creating index on commonly queried columns
Create Index idx_member_type On cyclistic_data(member_casual);
Create Index idx_day_of_week On cyclistic_data(day_of_week);
