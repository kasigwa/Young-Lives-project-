use YL_Project
----- 

ALTER TABLE [dbo].[INDIA]
ADD constraint PK_servey_ID primary key(servey_ID)

SELECT TOP 5*FROM[dbo].[ETHIOPIA]
SELECT TOP 5*FROM[dbo].[Peru]

----Cohorts Identification,characteristic and location in EHIOPIA and Peru round 1 to 5 --------
---- this table describe the general situaton of the child about where does the child lives,
---- his religion, the child sex...------

CREATE VIEW CHILD AS

  SELECT [childID],[Round],[Cohorts],
			DATEPART(YY,[Dateintv])as Year,[chldsex],
			[LivingArea],[region],[chlethnic],
			[ChldAge],[chldloc]
   FROM [dbo].[Ethiopia]
   WHERE[Round] = 4
  

CREATE VIEW CHILD_p AS
SELECT  [childID],[Round],[Cohorts],
			DATEPART(YY,[Dateintv])as Year,[chldsex],
			[LivingArea],[region],[chlethnic],
			[ChldAge],[chldloc]
FROM [dbo].[Peru]
WHERE [chldAge] is not null AND [Round]=4
------- This table will describe the Child --- 

CREATE VIEW  CHLD AS

SELECT concat('Et',[childID])as CHLD_id,[Round],[Cohorts],
			Year,[chldsex],
			[LivingArea],[region],[chlethnic],
			[ChldAge],[chldloc]
FROM [dbo].[CHILD_e]
UNION 
SELECT concat('Per',[childID])as CHLD_id,[Round]
			,[Cohorts],Year,[chldsex],
			[LivingArea],[region],[chlethnic],
			[ChldAge],[chldloc]
FROM[dbo].[CHILD_p]

----- Let count the size of sample 2386 how many young feamles and males cohorts


SELECT count(*)AS [Total number of Cohorts for both Ethiopia and Peru]
FROM[dbo].[CHLD]



---- from our sample we can say that there was a total of 2386 cohorts
-----where 753 older cohorts and 1633 younger cohorts.
SELECT[Cohorts],count(*)as [Nmbr between cohorts]
FROM[dbo].[CHLD] 
WHERE [cohorts] IS NOT null
group by [Cohorts]

--- let us group them by year--

SELECT[Cohorts],year,count(*)as Cohorts
FROM[dbo].[CHLD] 
WHERE [cohorts] IS NOT NULL 
and year is not null
group by [Cohorts],year
order by year ASC

----- Number of cohort per yer
SELECT year,[Round],count(*)as [nmbrOfcohorts/rnd]
FROM[dbo].[CHLD] 
WHERE year = '2016'
and [Round]is not null
group by year,[Round]
order by year ASC
 

--ETHIOPIA
----- Young Lives wealth index and sub-indices------

CREATE VIEW 
 SELECT[childID],[Round],[Cohorts],DATEPART(YY,[Dateintv])as Year,
				[LivingArea],[Wealth],[ownhouse],
				[houseqlty],[hhsize],[toiletq_new],[elecq_new],
				[Consumdurab],[accestoservic]
 FROM[dbo].[ETHIOPIA]
 WHERE[Wealth] is not null and [Round] =4
		
--PERU
SELECT[childID],[Round],DATEPART(YY,[Dateintv])as Year,
				[Cohorts],[LivingArea],[Wealth],[ownhouse],
				[houseqlty],[hhsize],[toiletq_new],[elecq_new],
				[Consumdurab],[accestoservic]
FROM[dbo].[Peru]
WHERE[Wealth] is not null and[Round] = 4
		
------Children’s contributions -----

SELECT DISTINCT[childID],[Round],[Cohorts],
				DATEPART(YY,[Dateintv])as Year,
				[LivingArea],[Wealth],[ChldAge],
				[hwork],[chldsex],[hstudy]
FROM [dbo].[Ethiopia]
WHERE [hwork]>2 and [ChldAge] >2
---- Child Heath and wellgeing 

SELECT [childID],[chldsex],[chldAge],
		DATEPART(YY,[Dateintv])as Year,
		[LivingArea],[chheight],[chweight],
		[chhprob],[chdisability]
FROM[dbo].[Peru]
SELECT [childID],[chldsex],[chldAge],[chdisability],count(*)as Nmbrofdsble,
[chldenrol]
FROM[dbo].[Peru]
where [chdisability]='yes'
group by[childID],[chldsex],[ChldAge],[chdisability],[chldenrol]
order by [ChldAge]asc




SELECT	[childID],[Cohorts],[LivingArea],[chlanguage],
		[chlethnic],[chldreligion],[dadeduc],
		[momeduc],[Wealth],[ownhouse]
FROM [dbo].[ETHIOPIA]

SELECT [childID],[Cohorts],[chldsex],[ChldAge],
		DATEPART(YY,[Dateintv])as Year
		,[pre_primary],
[Schltype],[chldenrol],[levlread],[levlwrit]
FROM [dbo].[Ethiopia]
WHERE [ChldAge]BETWEEN 1 AND 10

SELECT DISTINCT[childID],[Round],
			   [Cohorts],[chldsex],[chldAge],
	            DATEPART(YY,[Dateintv])as Year 
FROM[dbo].[ETHIOPIA]
WHERE[Round] = '4'
ORDER BY[chldAge] DESC