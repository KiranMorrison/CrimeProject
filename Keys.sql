use CrimeProject
go

/*
Adding keys - This query will be used to add foreign keys
to the fact tables
*/

--Foreign Key for DimDate
alter table [dbo].[CleanMasterData]
add constraint Date_fk
foreign key ([Date])
references DimDate([Date])
go

--Foreign Key for DimCrimeType
alter table [CleanMasterData]
add constraint CrimeType_fk
foreign key ([Crime Type])
references DimCrimeType([Crime Type])
go

--Primary Key for DimLSOA
alter table DimLSOA
alter column [LSOA Code] Varchar(50) NOT NULL

alter table [DimLSOA]
add primary key ([LSOA Code])

--Foreign Key for DimLSOA
alter table [CleanMasterData] with nocheck
add constraint LSOA_fk
foreign key ([LSOA Code])
references DimLSOA([LSOA Code])
go

--Foreign Key for DimAdmissionPolicy
alter table [CleanSchoolData]
add constraint AdmissionPolicy_fk
foreign key ([Admission Policy])
references DimAdmissionPolicy([Admission Policy])
go

--Foreign Key for DimPostcode
alter table [CleanSchoolData] with nocheck
add constraint PostCode_fk
foreign key ([Post Code])
references DimPostcode([Post Code])
go

--Link DimLSOA and DimPostcode
alter table [DimPostcode]
add constraint PostCodeLSOA_fk
foreign key ([LSOA Code])
references DimLSOA([LSOA Code])
go

--Foreign keys for NearestSchool3450
alter table [NearestSchool3450]
add constraint CrimeKey_fk
foreign key ([Crime Key])
references CleanMasterData([Crime Key])
go

alter table [NearestSchool3450] with nocheck
add constraint URN_fk
foreign key ([URN])
references CleanSchoolData([URN])
go