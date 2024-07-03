use corona_virus

select * from coronavirus

alter table coronavirus
alter column recovered int

----Q1. Write a code to check NULL values
select * from coronavirus
where province is null 
or country_region is null
or latitude is null
or longitude is null
or date is null
or confirmed is null
or Deaths is null 
or Recovered is null

---2. answer --ther is no null values present in this dataset



---3. check total number of rows
select count(*) 'Total_rows'from CoronaVirus

---4. Check what is start_date and end_date

select min(date) 'start_date', max(date) 'end date' from [CoronaVirus ]

--Q5. Number of month present in dataset 
select count(distinct concat(year(date),' ',month(date))) 'Total_month'  from [CoronaVirus ] 


select * from [CoronaVirus ]
---Q6. Find monthly average for confirmed, deaths, recovered

select datepart(year,date) 'year',
datepart(month,date)'month_count', DATENAME(month,date)'month_name',
avg(confirmed) 'Average_confirmed case',
avg(Deaths) 'Average_deaths case',
avg(Recovered)'Average_Recovered case' from [CoronaVirus ]
group by datepart(year,date) , datepart(month,date), DATENAME(month,date)
order by year ,month_count

--Q7. Find most frequent value for confirmed, deaths, recovered each month
with cte as (select
datepart(month,date)'month_count', DATENAME(month,date)'month_name',
confirmed,
Deaths,
Recovered, rank() over(partition by datepart(month,date),datename(month,date) order by count(*) desc) as rnk
from [CoronaVirus ]
group by datepart(year,date) , datepart(month,date), DATENAME(month,date),confirmed,
Deaths, Recovered)

select month_count,month_name,confirmed, Deaths,Recovered from cte
where rnk =1 

---Q8. Find minimum values for confirmed, deaths, recovered per year

select DATEPART(year,date), min(confirmed) 'minimum confirmed case',
min(deaths) 'minimum deaths case',
min(recovered) 'minimum recoverd case'from [CoronaVirus ]
group by DATEPART(year,date)

---- Q9. Find maximum values of confirmed, deaths, recovered per year
select DATEPART(year,date), max(confirmed) 'maximum confirmed case',
max(deaths) 'maximum deaths case',
max(recovered) 'maximum recoverd case'from [CoronaVirus ]
group by DATEPART(year,date)

----Q10. The total number of case of confirmed, deaths, recovered each month

select DATEPART(year,date) 'year',DATEPART(MONTH,date) 'month_count',DATENAME(MONTH,date) 'month_name',
sum(confirmed) 'Totla_confirmed_case',sum(deaths) 'Totla_deaths_case',sum(recovered) 'Totla_recovered_case'
from [CoronaVirus ]
group by DATEPART(year,date),DATEPART(MONTH,date),DATENAME(MONTH,date) 
order by year,month_count

---Q11. Check how corona virus spread out with respect to confirmed case
--- (Eg.: total confirmed cases, their average, variance & STDEV )

select sum(confirmed) 'total confirmed case',
avg(confirmed) 'avg confirmed case',
var(confirmed)'varians confirmed case',
stdev(confirmed) 'standared deviation confirmed case'
from [CoronaVirus ]

---Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

select sum(Deaths) 'total Deaths case',
avg(Deaths) 'avg Deaths case',
var(Deaths)'varians Deaths case',
stdev(Deaths) 'standared deviation Deaths case'
from [CoronaVirus ]


---Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

select sum(Recovered) 'total Recovered case',
avg(Recovered) 'avg Recovered case',
var(Recovered)'varians Recovered case',
stdev(Recovered) 'standared deviation Recovered case'
from [CoronaVirus ]



-- Q14. Find Country having highest number of the Confirmed case
select top 1 Country_Region 'counrty name',sum(Confirmed) 'highest confirmed case'
from [CoronaVirus ]
group by Country_Region
order by [highest confirmed case] desc


 ----Q15. Find Country having lowest number of the death case
 select top 4  Country_Region 'counrty name',sum(Deaths) 'lowest deaths case'
from [CoronaVirus ]
group by Country_Region
order by [lowest deaths case] asc

---- Q16. Find top 5 countries having highest recovered case
select  top 5 Country_Region 'counrty name',sum(Recovered) 'highest Recovered case'
from [CoronaVirus ]
group by Country_Region
order by [highest Recovered case] desc









