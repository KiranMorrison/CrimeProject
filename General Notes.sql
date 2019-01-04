/*
1) Data is taken from a directory (with subdirectories) and
put in to one CSV in Alteryx.
2) This CSV is imported into SQL table [OriginalMasterData].
3) [OriginalMasterData] is duplicated as [MasterData].
4) [MasterData] is altered and cleaned to remove unusable data
	and superfluous columns.
5) The resulting data is rearranged and placed in table
	[CleanMasterData].
6) Dimensions created for Date and Crime Type
7) Keys added
8) Insert LSOA population data for 2015-2017 from excel, find
	average and create DimLSOA
9) Add keys for DimLSOA
10) English School Data and English Secondary School data are
	imported into tables [AllSchoolInfo] and [OriginalSecondaryData]
	respectively.
11) The two are joined on a unique identifier (URN) and columns
	selected. The resulting table is cleaned and placed in to
	[CleanSchoolData].
12) Create DimAdmissionPolicy and DimPostcode
13) Add keys
14) Alteryx used to find the number of crimes within 3.4 miles of each school
15) Data imported to SQL and grouped by school and crime type to give, for each
	school, the number of crimes of each type committed within 3.4 miles per 1000
	people in the affected LSOAs. The grouped table is called DimCrimeBySchool.
16) Grouping the CleanMasterData table in a similar way can give, for each LSOA,
	the number of crimes per 1000 people for each crime type. This has been inserted
	into DimCrimeByLSOA.
*/