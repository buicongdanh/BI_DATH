CREATE DATABASE DATH_NDS
GO
USE DATH_NDS
GO 


USE MASTER
GO
DROP DATABASE DATH_NDS
GO
-- DROP TABLE --------------------------------------------------------------------------------
DROP TABLE COMPILED_COVID_19_CASE_DETAILS_CANADA_NDS
DROP TABLE CASES_REPORT_NDS
DROP TABLE VACCINES_BY_AGE_PHU_NDS
DROP TABLE ONGOING_OUTBREAKS_PHU_NDS
DROP TABLE PHU_GROUP_NDS

DROP TABLE EXPOSURE_NDS
DROP TABLE CASE_STATUS_NDS
DROP TABLE CASE_ACQUISITION_INFO_NDS
DROP TABLE OUTBREAKS_GROUP_NDS
DROP TABLE PHU_CITY_NDS

DROP TABLE PHU_NDS
DROP TABLE AGE_GROUP_NDS
DROP TABLE GENDER_NDS

-- CREATE DATABASE TABLE --------------------------------------------------------------------------------

-- Table: PHU_GROUP_NDS
-- Column: PHU_GROUP_ID, PHU_GROUP
CREATE TABLE PHU_GROUP_NDS (
    PHU_GROUP_ID bigint IDENTITY(1,1) PRIMARY KEY,
    PHU_GROUP nvarchar(300) NULL,
	PHU_City_ID bigint,
	Create_day date,
	Update_day date,
)

-- Table: PHU_City_NDS
-- Column: PHU_City_ID, PHU_City, PHU_Group_ID
CREATE TABLE PHU_City_NDS (
    PHU_City_ID		bigint IDENTITY(1,1) PRIMARY KEY,
    PHU_City		nvarchar(300) NULL,
	PHU_Region		nvarchar(300) NULL,	
	Create_day		date,
	Update_day		date,
    -- PHU_Group_ID bigint FOREIGN KEY REFERENCES PHU_GROUP(PHU_GROUP_ID)
)

-- Table: PHU_NDS
-- Column: PHU_ID, Reporting_PHU, Reporting_PHU_Address, PHU_City_ID, Reporting_PHU_Postal_Code, Reporting_PHU_Website, Reporting_PHU_Latitude, Reporting_PHU_Longitude
CREATE TABLE PHU_NDS (
    PHU_ID			bigint IDENTITY(1,1) PRIMARY KEY,
	PHU_ID_NK		bigint NULL,
    Reporting_PHU	nvarchar(300) NULL,
    Reporting_PHU_Address nvarchar(300) NULL,
    PHU_Group_ID		bigint,
    Reporting_PHU_Postal_Code nvarchar(300) NULL,
    Reporting_PHU_Website nvarchar(300) NULL,
    Reporting_PHU_Latitude float NULL,
    Reporting_PHU_Longitude float NULL,
	Create_day		date,
	Update_day		date,
	_Status			int
    -- PHU_City_ID bigint FOREIGN KEY REFERENCES PHU_City(PHU_City_ID)
)

-- Table: Vaccines_by_age_PHU_NDS
-- Column: Vaccines_by_age_PHU_ID, Date, PHU_ID, Age_Group_ID, At_least_one_dose_cumulative, Second_dose_cumulative, fully_vaccinated_cumulative, third_dose_cumulative
CREATE TABLE Vaccines_by_age_PHU_NDS (
    Vaccines_by_age_PHU_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Date			date NULL,
    PHU_ID			bigint,
    Age_Group_ID	bigint,
    At_least_one_dose_cumulative bigint,
    Second_dose_cumulative bigint,
    fully_vaccinated_cumulative bigint,
    third_dose_cumulative bigint,
	Create_day		date,
	Update_day		date,
	_Status			int
    -- PHU_ID bigint FOREIGN KEY REFERENCES PHU(PHU_ID),
    -- Age_Group_ID bigint FOREIGN KEY REFERENCES Age_Group(Age_Group_ID)
)

-- Table: Outbreaks_Group_NDS
-- Column: Outbreaks_Group_ID, Outbreaks_Group
CREATE TABLE Outbreaks_Group_NDS (
    Outbreaks_Group_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Outbreaks_Group nvarchar(300) NULL,
	Create_day		date,
	Update_day		date,
)

-- Table: Ongoing_Outbreaks_PHU_NDS
-- Column: Ongoing_Outbreaks_PHU_ID, Date, PHU_ID, Outbreaks_Group_ID, Number_Ongoing_Outbreaks
CREATE TABLE Ongoing_Outbreaks_PHU_NDS (
    Ongoing_Outbreaks_PHU_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Date			date NULL,
    PHU_ID			bigint,
    Outbreaks_Group_ID bigint,
    Number_Ongoing_Outbreaks bigint,
	Create_day		date,
	Update_day		date,
	_Status			int
    -- PHU_ID bigint FOREIGN KEY REFERENCES PHU(PHU_ID),
    -- Outbreaks_Group_ID bigint FOREIGN KEY REFERENCES Outbreaks_Group(Outbreaks_Group_ID)
)

-- Table: Case_Acquisition_Info_NDS
-- Column: Case_Acquisition_Info_ID, Case_Acquisition_Info
CREATE TABLE Case_Acquisition_Info_NDS (
    Case_Acquisition_Info_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Case_Acquisition_Info nvarchar(300) NULL,
	SourceID		bigint,
	Create_day		date,
	Update_day		date
)

-- Table: Cases_Report_NDS
-- Column: Case_Report_ID, Outcome, Age_Group_ID, Gender_ID, PHU_ID, Specimen_Date, Case_Reported_Date, Test_Reported_Date, Case_Acquisition_Info_ID, Accurate_Episode_Date, Outbreak_Related
CREATE TABLE Cases_Report_NDS (
    Case_Report_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Outcome_ID			bigint,
    Age_Group_ID	bigint,
    Gender_ID		bigint,
    PHU_ID			bigint,  
    Specimen_Date	date,
    Case_Reported_Date date,
    Test_Reported_Date date,
    Case_Acquisition_Info_ID bigint,
    Accurate_Episode_Date date,
    Outbreak_Related nvarchar(300),
	Create_day		date,
	Update_day		date,
	_Status			int
    -- Age_Group_ID bigint FOREIGN KEY REFERENCES Age_Group(Age_Group_ID),
    -- Case_AcquisitionInfo_ID bigint FOREIGN KEY REFERENCES Case_Acquisition_Info(Case_Acquisition_Info_ID)
)
CREATE TABLE Outcome_NDS (
    Outcome_ID		bigint IDENTITY(1,1) PRIMARY KEY,
    Outcome			nvarchar(300) NULL,
	SourceID		bigint,
	Create_day		date,
	Update_day		date
)


-- Table: Exposure_NDS
-- Column: Exposure_ID, Exposure
CREATE TABLE Exposure_NDS (
    Exposure_ID		bigint IDENTITY(1,1) PRIMARY KEY,
    Exposure		nvarchar(300) NULL,
	SourceID		bigint,
	Create_day		date,
	Update_day		date
)

-- Table: Case_Status_NDS
-- Column: Case_Status_ID, Case_Status
CREATE TABLE Case_Status_NDS (
    Case_Status_ID	bigint IDENTITY(1,1) PRIMARY KEY,
    Case_Status		nvarchar(300) NULL,
	SourceID		bigint,
	Create_day		date,
	Update_day		date
)

-- Table: Age_Group_NDS
-- Column: Age_Group_ID, Age_Group, Source
CREATE TABLE Age_Group_NDS (
    Age_Group_ID	bigint IDENTITY(1,1) PRIMARY KEY,
    Age_Group		nvarchar(300) NULL,
	SourceID		bigint,
	Create_day		date,
	Update_day		date
)

-- Table: Gender_NDS
-- Column: Gender_ID, Gender, Source
CREATE TABLE Gender_NDS (
    Gender_ID		bigint IDENTITY(1,1) PRIMARY KEY,
    Gender			nvarchar(300) NULL,
	SourceID		bigint,
	Create_day		date,
	Update_day		date,
)

CREATE TABLE Province_NDS (
	Province_ID		bigint IDENTITY(1,1) PRIMARY KEY,
	Province_Name	nvarchar(300),
	Create_day		date,
	Update_day		date,
	_Status			int
)

-- Table: Compiled_COVID_19_Case_Details_Canada_NDS
CREATE TABLE Compiled_COVID_19_Case_Details_Canada_NDS (
    Compiled_ID		bigint IDENTITY(1,1) PRIMARY KEY,
    Date_Reported	date,
    PHU_ID			bigint,
    Age_Group_ID	bigint,
    Gender_ID		bigint,
    Exposure_ID		bigint,
    Case_Status_ID	bigint,
    Province_ID		bigint,
	Create_day		date,
	Update_day		date,
	_Status			int
    -- PHU_ID bigint FOREIGN KEY REFERENCES PHU(PHU_ID),
    -- Age_Group_ID bigint FOREIGN KEY REFERENCES Age_Group(Age_Group_ID),
    -- Gender_ID bigint FOREIGN KEY REFERENCES Gender(Gender_ID),
)

CREATE TABLE DataSource(
	SourceID		bigint IDENTITY(1,1) PRIMARY KEY,
	SourceName		nvarchar(300)
)
/*
1 - Case_Report
2 - Compiled_COVID_19_Case_Details_Canada
3 - vaccines_by_age_phu
*/

drop table COMPILED_COVID_19_CASE_DETAILS_CANADA_NDS
-- SELECT --------------------------------------------------------------------------------
SELECT * FROM PHU_CITY_NDS
SELECT * FROM PHU_GROUP_NDS
SELECT * FROM PHU_NDS
SELECT * FROM PHU_CITY_NDS
SELECT * FROM VACCINES_BY_AGE_PHU_NDS
SELECT * FROM OUTBREAKS_GROUP_NDS
SELECT * FROM ONGOING_OUTBREAKS_PHU_NDS
SELECT * FROM CASE_ACQUISITION_INFO_NDS
SELECT * FROM CASES_REPORT_NDS
SELECT * FROM EXPOSURE_NDS
SELECT * FROM CASE_STATUS_NDS
SELECT * FROM AGE_GROUP_NDS
SELECT * FROM GENDER_NDS
SELECT * FROM COMPILED_COVID_19_CASE_DETAILS_CANADA_NDS

select
from phu_nds phu join PHU_CITY_NDS phuc on (phu.phu_city_id = phuc.
-- ADD FOREIGN KEY --------------------------------------------------------------------------------
--Chua chinh khoa ngoai
-- PHU_City_NDS(PHU_Group_ID) REFERENCES PHU_Group_NDS(PHU_Group_ID)
ALTER TABLE PHU_City_NDS ADD FOREIGN KEY (PHU_Group_ID) REFERENCES PHU_Group_NDS(PHU_Group_ID)

-- PHU_NDS(PHU_City_ID) REFERENCES PHU_City_NDS(PHU_City_ID)
ALTER TABLE PHU_NDS ADD FOREIGN KEY (PHU_City_ID) REFERENCES PHU_City_NDS(PHU_City_ID)

-- Ongoing_Outbreaks_PHU_NDS(OutBreak_Group_ID) REFERENCES Outbreaks_Group_NDS(Outbreaks_Group_ID)
ALTER TABLE Ongoing_Outbreaks_PHU_NDS ADD FOREIGN KEY (Outbreaks_Group_ID) REFERENCES Outbreaks_Group_NDS(Outbreaks_Group_ID)
-- Ongoing_Outbreaks_PHU_NDS(PHU_ID) REFERENCES PHU_NDS(PHU_ID)
ALTER TABLE Ongoing_Outbreaks_PHU_NDS ADD FOREIGN KEY (PHU_ID) REFERENCES PHU_NDS(PHU_ID)

-- Vaccines_by_age_PHU_NDS(Age_Group_ID) REFERENCES Age_Group_NDS(Age_Group_ID)
ALTER TABLE Vaccines_by_age_PHU_NDS ADD FOREIGN KEY (Age_Group_ID) REFERENCES Age_Group_NDS(Age_Group_ID)
-- Vaccines_by_age_PHU_NDS(PHU_ID) REFERENCES PHU_NDS(PHU_ID)
ALTER TABLE Vaccines_by_age_PHU_NDS ADD FOREIGN KEY (PHU_ID) REFERENCES PHU_NDS(PHU_ID)

-- Cases_Report_NDS(Age_Group_ID) REFERENCES Age_Group_NDS(Age_Group_ID)
ALTER TABLE Cases_Report_NDS ADD FOREIGN KEY (Age_Group_ID) REFERENCES Age_Group_NDS(Age_Group_ID)
-- Cases_Report_NDS(Gender_ID) REFERENCES Gender_NDS(Gender_ID)
ALTER TABLE Cases_Report_NDS ADD FOREIGN KEY (Gender_ID) REFERENCES Gender_NDS(Gender_ID)
-- Cases_Report_NDS(Case_Acquisition_Info_ID) REFERENCES Case_Acquisition_Info_NDS(Case_Acquisition_Info_ID)
ALTER TABLE Cases_Report_NDS ADD FOREIGN KEY (Case_Acquisition_Info_ID) REFERENCES Case_Acquisition_Info_NDS(Case_Acquisition_Info_ID)
-- Cases_Report_NDS(PHU_ID) REFERENCES PHU_NDS(PHU_ID)
ALTER TABLE Cases_Report_NDS ADD FOREIGN KEY (PHU_ID) REFERENCES PHU_NDS(PHU_ID)

-- Compiled_COVID_19_Case_Details_Canada_NDS(Exposure_ID) REFERENCES Exposure_NDS(Exposure_ID)
ALTER TABLE Compiled_COVID_19_Case_Details_Canada_NDS ADD FOREIGN KEY (Exposure_ID) REFERENCES Exposure_NDS(Exposure_ID)
-- Compiled_COVID_19_Case_Details_Canada_NDS(Case_Status_ID) REFERENCES Case_Status_NDS(Case_Status_ID)
ALTER TABLE Compiled_COVID_19_Case_Details_Canada_NDS ADD FOREIGN KEY (Case_Status_ID) REFERENCES Case_Status_NDS(Case_Status_ID)
-- Compiled_COVID_19_Case_Details_Canada_NDS(Age_Group_ID) REFERENCES Age_Group_NDS(Age_Group_ID)
ALTER TABLE Compiled_COVID_19_Case_Details_Canada_NDS ADD FOREIGN KEY (Age_Group_ID) REFERENCES Age_Group_NDS(Age_Group_ID)
-- Compiled_COVID_19_Case_Details_Canada_NDS(Gender_ID) REFERENCES Gender_NDS(Gender_ID)
ALTER TABLE Compiled_COVID_19_Case_Details_Canada_NDS ADD FOREIGN KEY (Gender_ID) REFERENCES Gender_NDS(Gender_ID)
-- Compiled_COVID_19_Case_Details_Canada_NDS(PHU_ID) REFERENCES PHU_NDS(PHU_ID)
ALTER TABLE Compiled_COVID_19_Case_Details_Canada_NDS ADD FOREIGN KEY (PHU_ID) REFERENCES PHU_NDS(PHU_ID)