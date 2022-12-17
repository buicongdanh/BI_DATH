USE DATH_DDS
GO

ALTER TABLE dim_Date
ADD PRIMARY KEY (IDDate)
GO

-- Status: Status_ID

-- dim_Gender: Gender_ID
-- dim_PHU: PHU_ID
-- dim_Date: IDDate
-- dim_Case_Status: Case_Status_ID
-- dim_Age: Age_ID

-- Fact_Case: IDDate, PHU_ID, Age_ID, Gender_ID, Outcome_ID, Case_Status_ID

-- FK_FactCase_1: Fact_Case(IDDate) --> dim_Date(IDDate)
ALTER TABLE Fact_Case
ADD CONSTRAINT FK_FactCase_1
FOREIGN KEY (IDDate) REFERENCES dim_Date(IDDate)
GO
-- FK_FactCase_2: Fact_Case(PHU_ID) --> dim_PHU(PHU_ID)
ALTER TABLE Fact_Case
ADD CONSTRAINT FK_FactCase_2
FOREIGN KEY (PHU_ID) REFERENCES dim_PHU(PHU_ID)
GO
-- FK_FactCase_3: Fact_Case(Age_ID) --> dim_Age(Age_ID)
ALTER TABLE Fact_Case
ADD CONSTRAINT FK_FactCase_3
FOREIGN KEY (Age_ID) REFERENCES dim_Age(Age_ID)
GO
-- FK_FactCase_4: Fact_Case(Gender_ID) --> dim_Gender(Gender_ID)
ALTER TABLE Fact_Case
ADD CONSTRAINT FK_FactCase_4
FOREIGN KEY (Gender_ID) REFERENCES dim_Gender(Gender_ID)
GO
-- FK_FactCase_5: Fact_Case(Outcome_ID) --> dim_Outcome(Gender_ID)
ALTER TABLE Fact_Case
ADD CONSTRAINT FK_FactCase_5
FOREIGN KEY (Outcome_ID) REFERENCES dim_Outcome(Outcome_ID)
GO
-- FK_FactCase_6: Fact_Case(Case_Status_ID) --> dim_Case_Status(Case_Status_ID)
ALTER TABLE Fact_Case
ADD CONSTRAINT FK_FactCase_6
FOREIGN KEY (Case_Status_ID) REFERENCES dim_Case_Status(Case_Status_ID)
GO
--

-- Fact_ Vacinated: IDDate, PHU_ID, Age_ID

-- FK_FactVaccinated_1: Fact_Vacinated(IDDate) --> dim_Date(IDDate)
ALTER TABLE Fact_Vacinated
ADD CONSTRAINT FK_FactVaccinated_1
FOREIGN KEY (IDDate) REFERENCES dim_Date(IDDate)
GO
-- FK_FactVaccinated_2: Fact_Vacinated(PHU_ID) --> dim_PHU(PHU_ID)
ALTER TABLE Fact_Vacinated
ADD CONSTRAINT FK_FactVaccinated_2
FOREIGN KEY (PHU_ID) REFERENCES dim_PHU(PHU_ID)
GO
-- FK_FactVaccinated_3: Fact_Vacinated(Age_ID) --> dim_Age(Age_ID)
ALTER TABLE Fact_Vacinated
ADD CONSTRAINT FK_FactVaccinated_3
FOREIGN KEY (Age_ID) REFERENCES dim_Age(Age_ID)