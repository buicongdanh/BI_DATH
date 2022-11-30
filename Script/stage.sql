CREATE DATABASE DATH_STAGE
GO
USE DATH_STAGE
GO 

-- Drop Tables

DROP TABLE Cases_Report_csv
DROP TABLE Compiled_COVID_19_Case_Details_Canada_csv
DROP TABLE ongoing_outbreaks_phu_csv
DROP TABLE Public_health_unit_xlsx
DROP TABLE Public_Health_Units_GROUP_xlsx
DROP TABLE vaccines_by_age_phu_csv
DROP TABLE vaccines_by_age_phu_xlsx

-- Table: Cases_Report_csv
-- Columns: Outcome, Age, Gender, Reporting_PHU, SpecimenDate, CaseReported_Date, PHUCity, TestReported_Date, CaseAcquisition_info, AccurateEpisode_Dt, PHU_Address, PHU_Website, OutbreakRelated, PHU_Latitude, PHU_Longitude, PHU_Postal_Code

CREATE TABLE Cases_Report_csv (
    Outcome varchar(MAX),
    Age varchar(MAX),
    Gender varchar(MAX),
    Reporting_PHU varchar(MAX),
    SpecimenDate date,
    CaseReported_Date date,
    PHUCity varchar(MAX),
    TestReported_Date date,
    CaseAcquisition_info varchar(MAX),
    AccurateEpisode_Dt date,
    PHU_Address varchar(MAX),
    PHU_Website varchar(MAX),
    OutbreakRelated varchar(MAX),
    PHU_Latitude float,
    PHU_Longitude float,
    PHU_Postal_Code varchar(MAX),

)
GO
-- Table: Compiled_COVID-19_Case_Details_Canada_csv
-- Columns: ObjectId, row_id, date_reported, health_region, age_group, gender, exposure, case_status, province

CREATE TABLE Compiled_COVID_19_Case_Details_Canada_csv (
    ObjectId bigint,
    row_id bigint,
    date_reported datetimeoffset,
    health_region varchar(MAX),
    age_group varchar(MAX),
    gender varchar(MAX),
    exposure varchar(MAX),
    case_status varchar(MAX),
    province varchar(MAX),

)
GO
-- Table: ongoing_outbreaks_phu_csv
-- Columns: date, phu_num, outbreak_group, number_ongoing_outbreaks

CREATE TABLE ongoing_outbreaks_phu_csv (
    date date,
    phu_num bigint,
    outbreak_group varchar(MAX),
    number_ongoing_outbreaks bigint,

)
GO
-- Table: Public_health_unit_xlsx
-- Columns: PHU_ID, Reporting_PHU, Reporting_PHU_Address, Reporting_PHU_City, Reporting_PHU_Postal_Code, Reporting_PHU_Website, Reporting_PHU_Latitude, Reporting_PHU_Longitude

CREATE TABLE Public_health_unit_xlsx (
    PHU_ID bigint,
    Reporting_PHU varchar(MAX),
    Reporting_PHU_Address varchar(MAX),
    Reporting_PHU_City varchar(MAX),
    Reporting_PHU_Postal_Code varchar(MAX),
    Reporting_PHU_Website varchar(MAX),
    Reporting_PHU_Latitude float,
    Reporting_PHU_Longitude float,

)
GO
-- Table: Public_Health_Units_GROUP_xlsx
-- Columns: PHU_Group, PHU_City, PHU_region

CREATE TABLE Public_Health_Units_GROUP_xlsx (
    PHU_Group varchar(MAX),
    PHU_City varchar(MAX),
    PHU_region varchar(MAX),

)
GO
-- Table: vaccines_by_age_phu_csv
-- Columns: Date, PHU_ID, Agegroup, At_least_one_dose_cumulative, Second_dose_cumulative, fully_vaccinated_cumulative, third_dose_cumulative

CREATE TABLE vaccines_by_age_phu_csv (
    Date date,
    PHU_ID bigint,
    Agegroup varchar(MAX),
    At_least_one_dose_cumulative bigint,
    Second_dose_cumulative bigint,
    fully_vaccinated_cumulative bigint,
    third_dose_cumulative bigint,

)
GO
-- Table: vaccines_by_age_phu_xlsx
-- Columns: Date, PHU_ID, Agegroup, At_least_one_dose_cumulative, Second_dose_cumulative, fully_vaccinated_cumulative, third_dose_cumulative

CREATE TABLE vaccines_by_age_phu_xlsx (
    Date date,
    PHU_ID bigint,
    Agegroup varchar(MAX),
    At_least_one_dose_cumulative bigint,
    Second_dose_cumulative bigint,
    fully_vaccinated_cumulative bigint,
    third_dose_cumulative bigint,

)
GO

-- Truncate Tables

TRUNCATE TABLE Cases_Report_csv
TRUNCATE TABLE Compiled_COVID_19_Case_Details_Canada_csv
TRUNCATE TABLE ongoing_outbreaks_phu_csv
TRUNCATE TABLE Public_health_unit_xlsx
TRUNCATE TABLE Public_Health_Units_GROUP_xlsx
TRUNCATE TABLE vaccines_by_age_phu_csv
TRUNCATE TABLE vaccines_by_age_phu_xlsx

SELECT * FROM Cases_Report_csv
SELECT * FROM Compiled_COVID_19_Case_Details_Canada_csv
SELECT * FROM ongoing_outbreaks_phu_csv
SELECT * FROM Public_health_unit_xlsx
SELECT * FROM Public_Health_Units_GROUP_xlsx
SELECT * FROM vaccines_by_age_phu_csv
SELECT * FROM vaccines_by_age_phu_xlsx
