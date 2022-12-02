create database DDS
go
use DDS
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sp_insertNgayThangQuyNam]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[sp_insertNgayThangNam]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[NgayTrongThang]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[NgayTrongThang]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[QuyTrongNam]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[QuyTrongNam]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Date]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[Date]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[PHU]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[PHU]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[PHU_GROUP]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[PHU_GROUP]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[PHU_City]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[PHU_City]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Geography]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[Geography]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Gender]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[Gender]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Age]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[Age]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Case_Status]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[Case_Status]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Exposure]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[Exposure]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FactCase]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE [dbo].[FactCase]
GO
CREATE TABLE [dbo].[ThangTrongNam] (
  [IDThang] int IDENTITY(1, 1) NOT NULL,
  [Thang] int NULL,
  [Nam] int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table NgayTrongThang : 
--

CREATE TABLE [dbo].[NgayTrongThang] (
  [IDNgay] int IDENTITY(1, 1) NOT NULL,
  [IDThang] int NULL,
  [Ngay] int NULL
)
ON [PRIMARY]
GO

CREATE TABLE [dbo].[ThangTrongQuy] (
  [IDThang] int IDENTITY(1, 1) NOT NULL,
  [IDQuy] int NULL,
  [Thang] int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table NgayTrongThang : 
--

CREATE TABLE [dbo].[QuyTrongNam] (
  [IDQuy] int IDENTITY(1, 1) NOT NULL,
  [Quy] int NULL,
  [Nam] int NULL
)
ON [PRIMARY]
GO
CREATE TABLE [dbo].[Date] (
  [IDDate] int IDENTITY(1, 1) NOT NULL,
  [IDNgay] int NULL,
  [IDQuy] int NULL,
  [IDThang] int NULL,
  [Nam] int NULL
)
ON [PRIMARY]
GO



CREATE TABLE PHU (
    PHU_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Reporting_PHU varchar(MAX) NULL,
    Reporting_PHU_Address varchar(MAX) NULL,
    PHU_City_ID bigint,
    Reporting_PHU_Postal_Code varchar(MAX) NULL,
    Reporting_PHU_Website varchar(MAX) NULL,
    Reporting_PHU_Latitude float NULL,
    Reporting_PHU_Longitude float NULL,
    Source int,
    -- PHU_City_ID bigint FOREIGN KEY REFERENCES PHU_City(PHU_City_ID)
)
CREATE TABLE PHU_GROUP (
    PHU_GROUP_ID bigint IDENTITY(1,1) PRIMARY KEY,
    PHU_GROUP varchar(MAX) NULL,
    Source int,
)
CREATE TABLE PHU_City (
    PHU_City_ID bigint IDENTITY(1,1) PRIMARY KEY,
    PHU_City varchar(MAX) NULL,
    PHU_Group_ID bigint,
    Source int,
)
CREATE TABLE [dbo].[Geography] (
  [IDGeography] bigint IDENTITY(1, 1) NOT NULL,
  [PHU_ID] bigint NULL,
  [Reporting_PHU] varchar(MAX) NULL,
  [PHU_City_ID] bigint NULL,
  [PHU_City] varchar(MAX) NULL,
  [PHU_Group_ID] bigint NULL,
  [PHU_GROUP] varchar(MAX) NULL
)
ON [PRIMARY]
GO

CREATE TABLE Gender (
    Gender_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Gender varchar(MAX) NULL,
)

CREATE TABLE Age (
    Age_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Age varchar(MAX) NULL,
    Source int,
)

CREATE TABLE Case_Status (
    Case_Status_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Case_Status varchar(MAX) NULL,
    Source int,
)

CREATE TABLE Exposure (
    Exposure_ID bigint IDENTITY(1,1) PRIMARY KEY,
    Exposure varchar(MAX) NULL,
    Source int,
)

CREATE TABLE  [dbo].[FactCase] (
  [IDDate] int NOT NULL,
  [PHU_ID] bigint NOT NULL,
  [Age_ID] bigint NOT NULL,
   [Gender_ID] bigint NOT NULL,
  [Case_Status_ID] bigint NOT NULL,
  [ToTalCase] int NULL,
  primary key (IDDate,PHU_ID,Age_ID,Gender_ID,Case_Status_ID)
 
)

--Them khoa ngoai neu can
ALTER TABLE PHU_City ADD FOREIGN KEY (PHU_Group_ID) REFERENCES PHU_Group(PHU_Group_ID)

-- PHU_NDS(PHU_City_ID) REFERENCES PHU_City_NDS(PHU_City_ID)
ALTER TABLE PHU ADD FOREIGN KEY (PHU_City_ID) REFERENCES PHU_City(PHU_City_ID)


create proc [dbo].sp_insertNgayThangQuyNam
as
begin
	declare @lset datetime
	select @lset =NgayCapNhat from METADATA.DBO.DDS where TenBang='Ngay'
	declare @counter datetime
	set @counter = @lset
	declare @thang int
	set @thang = Month(@counter)
	declare @idthang int
	declare @quy int
	declare @idquy int 
	if (@thang = 1|2|3)
	begin
		set @quy=1
	end
	if (@thang = 4|5|6)
	begin
		set @quy=2
	end
	if (@thang = 7|8|9)
	begin
		set @quy=3
	end
	if (@thang = 10|11|12)
	begin
		set @quy=4
	end
	if (@thang = Month(getdate()) or year(@counter)=year(getdate()))
	begin
		while @counter < getdate()
		begin
				select @idthang=IDThang from ThangTrongQuy where Thang=@thang and IDQuy=(Select IDQuy from QuyTrongNam where Nam=year(@counter))
				insert into NgayTrongThang(IDThang,Ngay) values(@idthang,day(@counter))
				set @counter = DATEADD(day,1,@counter)
		end
	end
	else
	begin
		while @counter < getdate()
		begin
			set @thang = Month(@counter)

			insert into QuyTrongNam(Quy,Nam) values(@quy,year(@counter))
			select @idquy=IDQuy from QuyTrongNam where Quy=@quy
			insert into ThangTrongQuy(Thang,IDQuy) values(@thang, @idquy)
			while (Month(@counter) = @thang and @counter < getdate()) --insert ngày cho tháng
			begin
				select @idthang=IDThang from ThangTrongQuy where Thang=@thang and IDQuy=(Select IDQuy from QuyTrongNam where Nam=year(@counter))
				insert into NgayTrongThang(IDThang,Ngay) values(@idthang,day(@counter))
				set @counter = DATEADD(day,1,@counter)
			end
			
		end
	end
end
GO