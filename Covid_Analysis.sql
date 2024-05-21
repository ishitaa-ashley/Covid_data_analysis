--data from deaths table
-- to get total cases by each continent using new_cases field
select SUM(new_cases),continent 
from deaths
group by continent;

--to get total cases by each country using total_cases field(which is a running total)
select MAX(total_cases),location 
from deaths
group by continent;

--to get details only related to United States
select * from deaths
where location="United States";

-- to get data of multiple locations
select continent,location,SUM(new_cases)
from deaths
where location in ('United States','India','China','United Kingdom')
group by continent,location;

--to get total deaths by continent
select SUM(new_deaths) as Total_Deaths,continent 
from deaths
group by continent;

--top 5 countries based on total cases
select SUM(new_cases) as Total_Cases,location 
from deaths
group by location
order by Total_Cases desc
limit 5;

--using CTE to get min and max total cases by location(learning sample scenario)
WITH country as 
	(select location
	from deaths
	group by location),
    max_case as
	(select location,sum(new_cases) as Max_Cases
	from deaths
	where sum(new_cases)>10000),
	min_case as
	(select location,sum(new_cases) as Min_Cases
	from deaths
	where sum(new_cases)<10000)
select country.location as COUNTRY, max_case.Max_cases, min_case.Min_Cases
from country
full join max_case on country.location=max_case.location
full join min_case on country.location=min_case.location;
	

--get the vaccination percentage data against the total population of a country
select death.location as Country,SUM(vax.new_vaccinations) as Vaccinated,
MAX(vax.people_fully_vaccinated)/MAX(death.population)*100 as Vaccination_percentage
from death as death
join vaccination as vax
on death.location=vax.location
and death.date=vax.date
group by death.location
order by Vaccination_percentage desc;

--get total tests by each country and the positive rate
select location,SUM(new_tests),AVG(positive_rate)
from vaccination
group by location;

