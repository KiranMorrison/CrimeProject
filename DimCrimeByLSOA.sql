use CrimeProject
go

drop table DimCrimeByLSOA
go

with cte
as
(
select
	C.[Crime type]
	,C.[LSOA code] [LSOA]
	,count(*) [Number of Crimes]
	,1000*count(*)/[Avg Total Population] [Crimes per 1000]
from CleanMasterData C
join DimLSOA L
	on C.[LSOA code] = L.[LSOA Code]
where [crime type] != ''
group by C.[crime type], C.[LSOA code], L.[Avg Total Population]
)

select
	[LSOA]
	,[Crime Type]
	,avg([crimes per 1000]) [Avg Crimes Per 1000]
into DimCrimeByLSOA
from cte
group by [crime type], [LSOA]