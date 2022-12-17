CREATE DATABASE DATH_STAGE
GO
USE DATH_STAGE
GO 

GO
USE MASTER
DROP DATABASE DATH_STAGE

-- Drop Tables

DROP TABLE Cases_Report
DROP TABLE Compiled_COVID_19_Case_Details_Canada
DROP TABLE ongoing_outbreaks_phu
DROP TABLE Public_health_unit
DROP TABLE Public_Health_Units_GROUP
DROP TABLE vaccines_by_age_phu

-- Table: Cases_Report_csv
-- Columns: Outcome, Age, Gender, Reporting_PHU, SpecimenDate, CaseReported_Date, PHUCity, TestReported_Date, CaseAcquisition_info, AccurateEpisode_Dt, PHU_Address, PHU_Website, OutbreakRelated, PHU_Latitude, PHU_Longitude, PHU_Postal_Code

CREATE TABLE Cases_Report (
    Outcome				nvarchar(255),
    Age					nvarchar(255),
    Gender				nvarchar(255),
    Reporting_PHU		nvarchar(255),
    SpecimenDate		date,
    CaseReported_Date	date,
    PHUCity				nvarchar(255),
    TestReported_Date	date,
    CaseAcquisition_info nvarchar(255),
    AccurateEpisode_Dt	date,
    PHU_Address			nvarchar(255),
    PHU_Website			nvarchar(255),
    OutbreakRelated		nvarchar(255),
    PHU_Latitude		float,
    PHU_Longitude		float,
    PHU_Postal_Code		nvarchar(255),
	Create_day			date,
	Update_day			date,
	Status				int
)
GO
-- Table: Compiled_COVID-19_Case_Details_Canada_csv
-- Columns: ObjectId, row_id, date_reported, health_region, age_group, gender, exposure, case_status, province
CREATE TABLE Compiled_COVID_19_Case_Details_Canada (
    ObjectId			bigint,
    row_id				bigint,
    date_reported		date,
    health_region		nvarchar(255),
    age_group			nvarchar(255),
    gender				nvarchar(255),
    exposure			nvarchar(255),
    case_status			nvarchar(255),
    province			nvarchar(255),
	Create_day			date,
	Update_day			date,
	Status				int
)
GO
-- Table: ongoing_outbreaks_phu_csv
-- Columns: date, phu_num, outbreak_group, number_ongoing_outbreaks

CREATE TABLE ongoing_outbreaks_phu (
    date				date,
    phu_num				bigint,
    outbreak_group		nvarchar(255),
    number_ongoing_outbreaks bigint,
	Create_day			date,
	Update_day			date,
	Status				int
)
GO
-- Table: Public_health_unit_xlsx
-- Columns: PHU_ID, Reporting_PHU, Reporting_PHU_Address, Reporting_PHU_City, Reporting_PHU_Postal_Code, Reporting_PHU_Website, Reporting_PHU_Latitude, Reporting_PHU_Longitude

CREATE TABLE Public_health_unit (
    PHU_ID						bigint,
    Reporting_PHU				nvarchar(255),
    Reporting_PHU_Address		nvarchar(255),
    Reporting_PHU_City			nvarchar(255),
    Reporting_PHU_Postal_Code	nvarchar(255),
    Reporting_PHU_Website		nvarchar(255),
    Reporting_PHU_Latitude		float,
    Reporting_PHU_Longitude		float,
	Create_day					date,
	Update_day					date,
	Status						int
)
GO
-- Table: Public_Health_Units_GROUP_xlsx
-- Columns: PHU_Group, PHU_City, PHU_region
CREATE TABLE Public_Health_Units_GROUP (
    PHU_Group					nvarchar(255),
    PHU_City					nvarchar(255),
    PHU_region					nvarchar(255),
	Create_day					date,
	Update_day					date,
	Status						int
)
GO
-- Table: vaccines_by_age_phu_csv
-- Columns: Date, PHU_ID, Agegroup, At_least_one_dose_cumulative, Second_dose_cumulative, fully_vaccinated_cumulative, third_dose_cumulative

CREATE TABLE vaccines_by_age_phu (
    Date						date,
    PHU_ID						bigint,
    Agegroup					nvarchar(255),
    At_least_one_dose_cumulative bigint,
    Second_dose_cumulative		bigint,
    fully_vaccinated_cumulative bigint,
    third_dose_cumulative		bigint,
	Create_day					date,
	Update_day					date,
	Status						int
)
GO
-- Table: vaccines_by_age_phu_xlsx
-- Columns: Date, PHU_ID, Agegroup, At_least_one_dose_cumulative, Second_dose_cumulative, fully_vaccinated_cumulative, third_dose_cumulative

SELECT * FROM Cases_Report
SELECT * FROM Compiled_COVID_19_Case_Details_Canada
SELECT * FROM ongoing_outbreaks_phu
SELECT * FROM Public_health_unit
SELECT * FROM Public_Health_Units_GROUP	
SELECT * FROM vaccines_by_age_phu

select cr.*, phu.phu_id
from cases_report cr left join Public_health_unit phu on (phu.reporting_phu = cr.reporting_phu)
where phu_id is null

select distinct phugr.phu_region
from Public_Health_Units_GROUP phugr
where phugr.phu_region not in (select distinct phu.reporting_phu from  Public_health_unit phu )

select distinct phu.reporting_phu from  Public_health_unit phu
where phu.reporting_phu not in (select distinct phugr.phu_region from  Public_Health_Units_GROUP phugr )

SELECT distinct health_region as reporting_phu_in_cases_report FROM Compiled_COVID_19_Case_Details_Canada
where health_region not in (select distinct phu.reporting_phu from  Public_health_unit phu )

SELECT distinct reporting_phu FROM Public_health_unit
where reporting_phu not in (SELECT distinct health_region  FROM Compiled_COVID_19_Case_Details_Canada )

update Compiled_COVID_19_Case_Details_Canada
set health_region = 'Lambton Public Health Unit' 
where health_region = 'Lambton Public Health'
