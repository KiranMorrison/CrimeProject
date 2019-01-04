/*
This creates a dimension for crime type, it categorises crime into those that are often
committed by youths, and those that aren't. It is hypothesised that the crimes around
schools will be committed by youths. There is also an index of crime severity, where low
numbers are used for less serious crimes.
*/
use CrimeProject
go

drop table DimCrimeType
select distinct
	isnull([Crime Type], 'Other crime') [Crime Type]
	,Case [Crime Type]
		when 'Anti-social behaviour' then 'Yes'
		when 'Drugs' then 'Yes'
		when 'Bicycle theft' then 'Yes'
		when 'Other theft' then 'Yes'
		when 'Possession of weapons' then 'Yes'
		when 'Shoplifting' then 'Yes'
		when 'Theft from the person' then 'Yes'
		when '' then 'NA'
		when 'Other crime' then 'NA'
		else 'No'
	end as [Is Youth Crime]
	,case [Crime type]
		when 'Anti-social behaviour' then '1'
		when 'Bicycle theft' then '2'
		when 'Burglary' then'3'
		when 'Criminal damage and arson' then '4'
		when 'Drugs' then '1'
		when 'Other crime' then 'NA'
		when 'Other theft' then '2'
		when 'Possession of weapons' then '4'
		when 'Public order' then '1'
		when 'Robbery' then '4'
		when 'Shoplifting' then '1'
		when 'Theft from the person' then '2'
		when 'Vehicle crime' then '2'
		when 'Violence and sexual offences' then '5'
		when '' then 'NA'
	end as [Crime Severity]								
into DimCrimeType										
from dbo.MasterData

alter table DimCrimeType
alter column [Crime Type] Varchar(100) NOT NULL

alter table DimCrimeType
add primary key ([Crime Type])
