/*
 * Tally Tables Exercise

 * The temporary table, #PatientAdmission, has values for dates between the 1st and 8th January inclusive
 * But not all dates are present
 */

DROP TABLE IF EXISTS #PatientAdmission;
CREATE TABLE #PatientAdmission (AdmittedDate DATE, NumAdmissions INT);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-01', 5)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-02', 6)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-03', 4)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-05', 2)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-08', 2)
SELECT * FROM #PatientAdmission

/*
 * Exercise: create a resultset that has a row for all dates in that period 
 * of 8 days with NumAdmissions set to 0 for missing dates. 
 You may wish to use the SQL statements below to set the start and end dates
 */

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);

-- write your answer here

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @NumDays INT;
SELECT
    @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT
    @EndDate = DATEFROMPARTS(2024, 1, 8);
SELECT
    @NumDays = DATEDIFF(DAY, @StartDate, @EndDate) +1;
WITH
    contigDateRange
    (
        N
        ,AdmittedDate
    )
    AS
    (
        SELECT
            t.N
,DATEADD(DAY,t.n -1,@StartDate)
        FROM
            tally t
        WHERE t.n <=@NumDays
    )
SELECT
    cdr.AdmittedDate
    ,COALESCE(PA.NumAdmissions,0) AS NumAdmissions

FROM
    contigDateRange cdr LEFT JOIN #PatientAdmission PA ON cdr.AdmittedDate = PA.AdmittedDate

ORDER BY cdr.AdmittedDate

/*
 * Exercise: list the dates that have no patient admissions
*/

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);

-- write your answer here

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @NumDays INT;
SELECT
    @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT
    @EndDate = DATEFROMPARTS(2024, 1, 8);
SELECT
    @NumDays = DATEDIFF(DAY, @StartDate, @EndDate) +1;
WITH
    contigDateRange
    (
        N
        ,AdmittedDate
    )
    AS
    (
        SELECT
            t.N
,DATEADD(DAY,t.n -1,@StartDate)
        FROM
            tally t
        WHERE t.n <=@NumDays
    )
SELECT
    cdr.AdmittedDate
    --,COALESCE(PA.NumAdmissions,0) AS NumAdmissions

FROM
    contigDateRange cdr LEFT JOIN #PatientAdmission PA ON cdr.AdmittedDate = PA.AdmittedDate
    where pa.NumAdmissions is NULL

ORDER BY cdr.AdmittedDate