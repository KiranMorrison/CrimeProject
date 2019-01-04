use CrimeProject
go

/*
The [Crime ID] column is inconsistent, and not viable as an identity column.
for this reason the code below was used to create a new Primary Key by which
one can identify any single row in the data set. Given the viability of the
[Crime ID] column, this has been dropped.
*/

alter table dbo.MasterData
add [Crime Key] int primary key identity(1,1)

alter table dbo.MasterData
drop column [Crime ID]

/*
The code below identifies that there is not a single instance of [Reported by]
being different from [Falls within]. For this reason the [Falls within] column
has been deleted, as coded below.
*/

select top 50
	*
from MasterData
where [Reported by] != [Falls within]

alter table dbo.MasterData
drop column [Falls within]

/*
It's also clear at this stage that [Last outcome category] and [Context] do not
provide useful insight for the aims of the project. For this reason they have
also been dropped, as seen below
*/

alter table dbo.MasterData
drop column [Last outcome category], [Context]

/*
The analysis to follow will rely heavily on location of the crime, so data without
longitude and latitude values is useless and should be deleted.
*/

delete from dbo.MasterData
	where [Longitude] = '' or
		  [Latitude] = ''

/*
Just 7 rows have no crime type attached, these should be deleted now as they won't
be useful later.
*/

delete from dbo.MasterData
	where [Crime type] = ''

/*
The resulting data set is well cleaned. However, [Month] should be recast as a date,
and it would be nice if [Crime Key] was the first column to appear in the table.
*/

drop table [CleanMasterData]
SELECT
	[Crime Key]
	,cast(Concat([Month],'-01') as date) [Date]
    ,[Reported by] as [Police force]
    ,[Longitude]
    ,[Latitude]
    ,[Location]
    ,[LSOA code] as [LSOA code]
    ,[LSOA name] as [LSOA name]
    ,[Crime type]
INTO [dbo].[CleanMasterData]
FROM [dbo].[MasterData]

alter table [CleanMasterData]
add primary key ([Crime Key])
