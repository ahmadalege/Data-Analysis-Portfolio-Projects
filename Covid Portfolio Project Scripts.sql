SELECT "location", date, total_cases, new_cases, total_deaths, population 
FROM death
ORDER BY 1,2 ;

--Looking at Total Cases vs Total Deaths
--Percentage of dying if you contract covid in your country

SELECT "location", date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM death
WHERE "location" = 'Nigeria'
ORDER BY "location", date ;


--Looking at Total Cases vs Population
--percentage of populaion that got covid

SELECT "location", date, total_cases, population, (total_cases/population)*100 AS InfectedPopulationPercentage
FROM death
WHERE "location" = 'Nigeria'
ORDER BY "location", date ;

--Country with the highest infection rate 
SELECT "location", population, MAX(total_cases) AS HighestInfection, MAX((total_cases/population))*100 AS InfectedPopulationPercentage  
FROM death 
GROUP BY "location", population
ORDER BY InfectedPopulationPercentage DESC ;

--Continent with highest death rate

SELECT continent, MAX(total_deaths) AS HighestDeath
FROM death
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY HighestDeath DESC ;


--Country with highest death rate

SELECT "location", MAX(total_deaths) AS HighestDeath
FROM death
WHERE continent IS NOT NULL
GROUP BY "location"
ORDER BY HighestDeath DESC ;


-- GLOBAL NUMBERS 
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (sum(new_deaths)/sum(new_cases))*100 AS DeathPercentage
FROM death
WHERE continent IS NOT NULL ;

--looking at total populations vs vaccinations

--USE CTE 

WITH PopvsVac (Continent, "Location", Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT d.continent, "d"."location", d.date, d.population, v.new_vaccinations, sum(v.new_vaccinations::INT) OVER(PARTITION BY "d"."location" ORDER BY "d"."location", d.date) AS RollingPeopleVaccinated
FROM death d 
JOIN vaccinations v
ON "d"."location" = "v"."location"
AND d.date = v.date
WHERE d.continent IS NOT NULL 
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac ;


CREATE VIEW PercentPopulationVaccinated AS 
SELECT d.continent, "d"."location", d.date, d.population, v.new_vaccinations, sum(v.new_vaccinations::INT) OVER(PARTITION BY "d"."location" ORDER BY "d"."location", d.date) AS RollingPeopleVaccinated
FROM death d 
JOIN vaccinations v
ON "d"."location" = "v"."location"
AND d.date = v.date
WHERE d.continent IS NOT NULL 

SELECT * FROM PercentPopulationVaccinated 