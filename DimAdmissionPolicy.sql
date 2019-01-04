/*
This creates a dimension for [Admission Policy]. Ultimately it
is important to see whether a school is selective or not, so a
dimension has been created to link [Admission Policy] with a new
column, [Is Selective]
*/
use CrimeProject
go

select distinct
	[Admission Policy]
	,Case [Admission Policy]
		when 'Selective' then 'Yes'
		when 'Non Selective' then 'No'
		when 'Comprehensive' then 'No'
		else 'Unknown'
	end as [Is Selective]							
into DimAdmissionPolicy										
from dbo.CleanSchoolData

alter table DimAdmissionPolicy
alter column [Admission Policy] varchar(50) not null

alter table DimAdmissionPolicy
add primary key ([Admission Policy])
