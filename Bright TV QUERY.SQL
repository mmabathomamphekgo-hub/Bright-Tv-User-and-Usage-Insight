select * from `workspace`.`default`.`viewership_bright_tv_dataset` limit 10;

SELECT
  TO_DATE(RecordDate2) AS date_col,
  DATE_FORMAT(TO_TIMESTAMP(RecordDate2), 'HH:mm:ss') AS time_col
FROM `workspace`.`default`.`viewership_bright_tv_dataset`;

SELECT
  -- Keep only one UserID column (choose UserID0 as the main one)
  UserID0 AS UserID,

  -- Keep other useful columns
  Channel2,
  RecordDate2,
  `Duration 2`,

  -- Convert RecordDate2 into proper DATETIME in South Africa Standard Time
  FROM_UTC_TIMESTAMP(RecordDate2, "Africa/Johannesburg") AS RecordDate_SAST

FROM
  `workspace`.`default`.`viewership_bright_tv_dataset`

-- Remove duplicates based on UserID and RecordDate2
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY UserID0, RecordDate2
  ORDER BY RecordDate2 DESC
) = 1;

SELECT
  UserID0 AS UserID,
  Channel2,
  RecordDate2,
  `Duration 2`,

  -- Full SAST datetime
  FROM_UTC_TIMESTAMP(RecordDate2, "Africa/Johannesburg") AS RecordDate_SAST,

  -- Separate SAST date
  TO_DATE(FROM_UTC_TIMESTAMP(RecordDate2, "Africa/Johannesburg")) AS RecordDate_SAST_Date,

  -- Separate SAST time
  DATE_FORMAT(FROM_UTC_TIMESTAMP(RecordDate2, "Africa/Johannesburg"), 'HH:mm:ss') AS RecordDate_SAST_Time

FROM `workspace`.`default`.`viewership_bright_tv_dataset`

QUALIFY ROW_NUMBER() OVER (
  PARTITION BY UserID0, RecordDate2
  ORDER BY RecordDate2 DESC
) = 1;
