use CrimeProject
go

/*
To create a dimension for LSOA, population averages for the past three
years have been calculated for each LSOA. These include the population
of the LSOA and also the KS4 population (16-18 year olds).
*/
if object_id ('[dbo].[DimLSOA]') is not null
begin
	drop table DimLSOA  
end 

;with cte3
as
(
select
	[Contents] as [LSOA Code]
	,[f3] as [LSOA Name]
	,[F4] as [Total Population]
	,[F21]+[F22]+[F23] as [KS4 Population]
from LSOAPop2015
where [f3] is not null --ignores cumulative populations for regions
UNION ALL
select
	[Contents] as [LSOA Code]
	,[f3] as [LSOA Name]
	,[F4] as [Total Population]
	,[F21]+[F22]+[F23] as [KS4 Population]
from LSOAPop2016
where [f3] is not null
UNION ALL
select
	[Contents] as [LSOA Code]
	,[f3] as [LSOA Name]
	,[F4] as [Total Population]
	,[F21]+[F22]+[F23] as [KS4 Population]
from LSOAPop2017
where [f3] is not null
)
,cte
as
(
select
	[LSOA Code]
	,[Police Force]
	,count(*) as CrimeA
from CleanMasterData
group by [LSOA Code], [Police force]
)
,cte2
as
(
select
	[LSOA Code]
	,MAX([CrimeA]) as CrimeB
from cte
group by [LSOA Code]
)
select
	C.[LSOA Code]
	,C.[LSOA Name]
	,A.[Police Force]
	,cast(avg([Total Population])as decimal) as [Avg Total Population]
	,cast(avg([KS4 Population])as decimal) as [Avg KS4 Population]
into DimLSOA
from cte3 C
left join cte2 B
	on C.[LSOA Code] = B.[LSOA Code]
left join cte A
	on A.CrimeA = B.CrimeB and A.[LSOA code] = B.[LSOA code]
group by C.[LSOA Code], [LSOA Name], A.[Police Force]
