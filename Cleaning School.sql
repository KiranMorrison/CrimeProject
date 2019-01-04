use CrimeProject
go

/*
The table [dbo].[AllSchoolInfo] contains information for
every school in England. However the scope of this project
only requires a list of the secondary schools in the UK.
That list can be found in [dbo].[OriginalSecondaryData].
Inner joining the two on the column URN, a unique identifier
for all schools, leaves us with a list of secondary schools
only with all the necessary info (e.g. postcode) contained in
the first table
*/

select
	*
from [AllSchoolInfo] a
join [OriginalSecondaryData] o
on a.URN = o.URN

/*
There's a lot of unwanted columns here, so we can select from
this join just a few select columns to move forward with. The
selected columns have been added in to a table named
[dbo].[CleanSchoolData]
*/

drop table CleanSchoolData
select
	a.URN
	,a.SCHNAME as [School]
	,a.Street as [Street]
	,a.TOWN as [Town]
	,a.POSTCODE as [Post Code]
	,a.GENDER as [Gender Selectivity]
	,case a.ADMPOL
		when '' then 'Unknown'
		when 'Non selective' then 'Non Selective'
		else [ADMPOL]
	end as [Admission Policy]
	,o.TPUP as [Number of Students]
	,o.ATT8SCR as [Attainment 8 Score]
into [CleanSchoolData]
from [AllSchoolInfo] a
join [OriginalSecondaryData] o
on a.URN = o.URN
where a.POSTCODE != ''
		and o.TPUP != ''

alter table CleanSchoolData
alter column [URN] int not null

alter table CleanSchoolData
add primary key ([URN])


