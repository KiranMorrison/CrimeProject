/*
Takes 1 Hour to run
*/

use crimeproject
go

;with cte
as
(
select
	N.[URN]
	,1000*count(*)/L.[Avg Total Population] as [Crimes per 1000]
	,C.[Crime Type]
	,C.[LSOA code]
from NearestSchool3450 N
join CleanMasterData C
	on N.[Crime Key] = C.[Crime Key]
join DimLSOA L
	on L.[LSOA Code] = C.[LSOA code]
group by [URN], N.[Crime type], C.[LSOA code], L.[Avg Total Population]
)

select
	[URN]
	,[Crime Type]
	,avg([Crimes per 1000]) [Avg Crimes per 1000]
into DimCrimeBySchool
from cte
group by [URN], [Crime Type]
