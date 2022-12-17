create database DATH_DDS
go
use DATH_DDS
GO
CREATE TABLE [dbo].[dim_Date] (
	[IDDate]		bigint IDENTITY(1, 1) PRIMARY KEY,
	FullDateTime	date NULL,
	Ngay			int NULL,
	Thang			int NULL,
	Quy				int NULL,
	Nam				int NULL
)

CREATE TABLE dim_PHU (
    PHU_ID				bigint IDENTITY(1,1) PRIMARY KEY,
	PHU_ID_NK			bigint,
	PHU_City_ID			bigint,--Historical
	PHU_City			nvarchar(255),
	PHU_Group_ID		bigint,
	PHU_GROUP			nvarchar(255),
    Reporting_PHU		nvarchar(255) NULL,
    Reporting_PHU_Address nvarchar(255) NULL,--Changing
    Reporting_PHU_Postal_Code nvarchar(255) NULL, --Changing
    Reporting_PHU_Website nvarchar(255) NULL, --Changing
    Reporting_PHU_Latitude float NULL,--Changing
    Reporting_PHU_Longitude float NULL,--Changing
	Create_day		date,
	Update_day		date,
	_Status				int
)

ALTER TABLE dim_PHU ADD CONSTRAINT FK_Phu_Status
FOREIGN KEY (_Status) REFERENCES _Status(Status_ID)

CREATE TABLE dim_Gender (
    Gender_ID		bigint IDENTITY(1,1) PRIMARY KEY,
	Gender_NK		bigint,
    Gender_Name		nvarchar(255) NULL,
	SourceID		int,
	Create_day		date,
	Update_day		date,
	_Status			int,
)

ALTER TABLE dim_Gender ADD CONSTRAINT FK_Gender_Status
FOREIGN KEY (_Status) REFERENCES _Status(Status_ID)

CREATE TABLE dim_Age (
    Age_ID			bigint IDENTITY(1,1) PRIMARY KEY,
	Age_NK			bigint,
    Age_Name		nvarchar(255) NULL,
	SourceID		int,
	Create_day		date,
	Update_day		date,
	_Status			int
)

ALTER TABLE dim_Age ADD CONSTRAINT FK_Age_Status
FOREIGN KEY (_Status) REFERENCES _Status(Status_ID)

CREATE TABLE dim_Case_Status (
    Case_Status_ID	bigint IDENTITY(1,1) PRIMARY KEY,
	Case_Status_NK	bigint,
    Case_Status_Name	nvarchar(255) NULL,
	Source_ID		int,
	Create_day		date,
	Update_day		date,
	_Status			int
)

ALTER TABLE dim_Case_Status ADD CONSTRAINT FK_Case_Status_Status
FOREIGN KEY (_Status) REFERENCES _Status(Status_ID)
ALTER TABLE dim_Case_Status ADD CONSTRAINT FK_Case_Status_Source
FOREIGN KEY (Source_ID) REFERENCES SourceID(Source_ID)

CREATE TABLE dim_Outcome (
    Outcome_ID	bigint IDENTITY(1,1) PRIMARY KEY,
	Outcome_NK	bigint,
    Outcome_Name	nvarchar(255) NULL,
	Source_ID		int,
	Create_day		date,
	Update_day		date,
	_Status			int
)
ALTER TABLE dim_Outcome ADD CONSTRAINT FK_Outcome_Status
FOREIGN KEY (_Status) REFERENCES _Status(Status_ID)
ALTER TABLE dim_Outcome ADD CONSTRAINT FK_Outcome_Source
FOREIGN KEY (Source_ID) REFERENCES SourceID(Source_ID)

CREATE TABLE  [dbo].[Fact_Case] (	
  --Dim
	[IDDate]		bigint NOT NULL,
	[PHU_ID]		bigint NOT NULL,
	[Age_ID]		bigint NOT NULL,
	[Gender_ID]		bigint NOT NULL,
	[Outcome_ID]	bigint NOT NULL,
	[Case_Status_ID] bigint NOT NULL,
	[SourceID]		int NOT NULL,
  --Measure
	[ToTalCase] bigint NULL,
	primary key (IDDate, PHU_ID, Age_ID, Gender_ID, Case_Status_ID, Outcome_ID)
)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_Date
FOREIGN KEY (IDDate) REFERENCES dim_Date(IDDate)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_Phu
FOREIGN KEY (PHU_ID) REFERENCES dim_Phu(Phu_ID)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_Age
FOREIGN KEY (Age_ID) REFERENCES dim_Age(Age_ID)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_Gender
FOREIGN KEY (Gender_ID) REFERENCES dim_Gender(Gender_ID)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_CaseStatus
FOREIGN KEY (Case_Status_ID) REFERENCES dim_Case_Status(Case_Status_ID)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_Outcome
FOREIGN KEY (Outcome_ID) REFERENCES dim_Outcome(Outcome_ID)

ALTER TABLE [Fact_Case] ADD CONSTRAINT FK_Case_Source
FOREIGN KEY (SourceID) REFERENCES SourceID(Source_ID)

CREATE TABLE [dbo].[Fact_Vacinated](
  --Dim
	[IDDate]		bigint NOT NULL,
	[PHU_ID]		bigint NOT NULL,
	[Age_ID]		bigint NOT NULL,
  --Measure
	OneDoseCumulative	bigint null,
	SecondDoseCumulative bigint null,
	FullyVaccinated		bigint null,
	ThirdDoseCumulative	bigint null,
	primary key (IDDate, PHU_ID, Age_ID)
)

ALTER TABLE [Fact_Vacinated] ADD CONSTRAINT FK_Vacinated_Date
FOREIGN KEY (IDDate) REFERENCES dim_Date(IDDate)

ALTER TABLE [Fact_Vacinated] ADD CONSTRAINT FK_Vacinated_Phu
FOREIGN KEY (PHU_ID) REFERENCES dim_PHU(PHU_ID)

ALTER TABLE [Fact_Vacinated] ADD CONSTRAINT FK_Vacinated_Age
FOREIGN KEY (Age_ID) REFERENCES dim_Age(Age_ID)

select phu_id from [Fact_Vacinated]
WHERE phu_id NOT IN
(SELECT phu_id from dim_phu)

Create table SourceID (
	Source_ID	int IDENTITY(1,1) PRIMARY KEY,
	SourceName	nvarchar(255)
)
/*
1 - Case_Report
2 - Compiled_COVID_19_Case_Details_Canada
3 - vaccines_by_age_phu
*/
Create table _Status (
	Status_ID		int IDENTITY(1,1) PRIMARY KEY,
	Status_Name		nvarchar(255)
)

--Them khoa ngoai neu can
ALTER TABLE PHU_City ADD FOREIGN KEY (PHU_Group_ID) REFERENCES PHU_Group(PHU_Group_ID)

-- PHU_NDS(PHU_City_ID) REFERENCES PHU_City_NDS(PHU_City_ID)
ALTER TABLE PHU ADD FOREIGN KEY (PHU_City_ID) REFERENCES PHU_City(PHU_City_ID)
truncate table dim_Date
--FILL dim_date data
use DATH_DDS
go
create proc add_date
--alter proc add_date
As
begin
	declare @req_start_date Datetime,
			@req_end_date Datetime
	SET @req_start_date='2018-01-01'
	SET @req_end_date='2023-12-31'
	;WITH X AS 
    (
        SELECT @req_start_date AS VAL
        UNION ALL
        SELECT DATEADD(DD,1,VAL) FROM X
        WHERE VAL < @req_end_date
    )
	INSERT INTO dim_date(Ngay,Thang,Quy,Nam,FullDateTime)
	SELECT datepart(day,VAL),datepart(month,VAL),DATEPART(quarter,val),datepart(year,VAL),VAL
	FROM X
	OPTION(MAXRECURSION 0)
END

use DATH_DDS
exec add_date
