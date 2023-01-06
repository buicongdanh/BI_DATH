USE DATH_DDS
GO

DROP VIEW IF EXISTS dbo.vCaseDetail
GO
CREATE VIEW vCaseDetail
AS
	SELECT 
		ROW_NUMBER() OVER (ORDER BY c.PHU_ID, c.IDDate, c.Age_ID, c.Gender_ID, c.Outcome_ID, c.Case_Status_ID) AS ID
		, p.Reporting_PHU
		, p.PHU_City
		, p.PHU_GROUP
		, d.FullDateTime
		, d.Thang
		, d.Quy
		, d.Nam
		, g.Gender_Name
		, o.Outcome_Name
		, a.Age_Name
		, cs.Case_Status_Name
		, c.ToTalCase
	FROM Fact_Case c
		JOIN dim_Phu p ON p.PHU_ID = c.PHU_ID
		JOIN dim_Date d ON d.IDDate = c.IDDate
		JOIN dim_Gender g ON g.Gender_ID = c.Gender_ID
		JOIN dim_Outcome o ON o.Outcome_ID = c.Outcome_ID
		JOIN dim_Age a ON a.Age_ID = c.Age_ID
		JOIN dim_Case_Status cs ON cs.Case_Status_ID = c.Case_Status_ID
GO

DROP VIEW IF EXISTS dbo.vVacinated
GO
CREATE VIEW vVacinated
AS
	SELECT 
		ROW_NUMBER() OVER (ORDER BY c.PHU_ID, c.IDDate, c.Age_ID) AS ID
		, p.Reporting_PHU
		, p.PHU_City
		, p.PHU_GROUP
		, d.FullDateTime
		, d.Thang
		, d.Quy
		, d.Nam
		, a.Age_Name
		, c.OneDoseCumulative
		, c.SecondDoseCumulative
		, c.FullyVaccinated
		, c.ThirdDoseCumulative
	FROM Fact_Vacinated c
		JOIN dim_Phu p ON p.PHU_ID = c.PHU_ID
		JOIN dim_Date d ON d.IDDate = c.IDDate
		JOIN dim_Age a ON a.Age_ID = c.Age_ID
GO

DROP TABLE Mining_CaseDetail 
DROP TABLE Mining_Vacinated

SELECT * INTO Mining_CaseDetail FROM vCaseDetail
GO
SELECT * INTO Mining_Vacinated FROM vVacinated
GO
