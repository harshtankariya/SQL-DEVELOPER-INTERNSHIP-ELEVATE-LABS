--1.Top 10 Countries by Total Vaccinations (Latest Date)
SELECT 
    country,
    MAX(date) AS latest_date,
    MAX(total_vaccinations) AS total_vaccinations
FROM tracking_r
GROUP BY country
ORDER BY total_vaccinations DESC
LIMIT 10;

--2. Daily New Cases Trend for a Country with 7-Day Moving Average
SELECT 
    country,
    date,
    new_cases,
    ROUND(AVG(new_cases) OVER (PARTITION BY country ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS avg_7d_cases
FROM cases_deaths
WHERE country = 'India'
ORDER BY date;


--3. Stringency Index Trend for All Countries (Weekly Average)
SELECT 
    country,
    YEARWEEK(date) AS year_week,
    ROUND(AVG(stringency_index), 2) AS avg_stringency
FROM country_income_classification
GROUP BY country, YEARWEEK(date)
ORDER BY country, year_week;

--4. Death Rate Per Country (Total Deaths / Total Cases)
SELECT 
    cd.country,
    MAX(cd.total_deaths) AS total_deaths,
    MAX(cd.total_cases) AS total_cases,
    ROUND(MAX(cd.total_deaths)*100.0 / NULLIF(MAX(cd.total_cases), 0), 2) AS death_rate_percentage
FROM cases_deaths cd
GROUP BY cd.country
ORDER BY death_rate_percentage DESC;

--5. Vaccination and Death Correlation View
SELECT 
    tr.country,
    tr.date,
    tr.people_fully_vaccinated_per_hundred,
    cd.new_deaths_per_million
FROM tracking_r tr
JOIN cases_deaths cd ON tr.country = cd.country AND tr.date = cd.date
WHERE tr.people_fully_vaccinated_per_hundred IS NOT NULL
ORDER BY tr.country, tr.date;

--6. Government Policy Summary for High-Income Countries
SELECT 
    cic.country,
    AVG(cic.stringency_index) AS avg_stringency_index,
    AVG(cic.containment_health_index) AS avg_containment_index
FROM country_income_classification cic
JOIN compact c ON cic.country = c.country
WHERE c.income_group = 'High income'
GROUP BY cic.country
ORDER BY avg_stringency_index DESC;

--7. Top 5 Countries with Highest Share of Boosters
SELECT 
    country,
    MAX(share_of_boosters) AS max_booster_share
FROM tracking_r
GROUP BY country
ORDER BY max_booster_share DESC
LIMIT 5;

-- 8. R Value Daily Trend with Confidence Intervals
SELECT 
    country,
    date,
    r,
    ci_95_l, ci_95_u
FROM oxcgrt_policy
WHERE country = 'India'
ORDER BY date;
-- 9. Vaccine Rollout Over 6, 9, 12 Months per 100 People
SELECT 
    country,
    MAX(rolling_vaccinations_6m_per_hundred) AS vacc_6m,
    MAX(rolling_vaccinations_9m_per_hundred) AS vacc_9m,
    MAX(rolling_vaccinations_12m_per_hundred) AS vacc_12m
FROM tracking_r
GROUP BY country
ORDER BY vacc_12m DESC;

--VIEW Creation for Exporting Results
--View 1: Vaccination Summary
CREATE VIEW view_vaccination_summary AS
SELECT 
    country,
    MAX(total_vaccinations) AS total_vaccinations,
    MAX(people_vaccinated) AS people_vaccinated,
    MAX(people_fully_vaccinated) AS fully_vaccinated
FROM tracking_r
GROUP BY country;

--View 2: Stringency Index Trends by Week
CREATE VIEW view_weekly_stringency AS
SELECT 
    country,
    YEARWEEK(date) AS week,
    AVG(stringency_index) AS avg_index
FROM country_income_classification
GROUP BY country, YEARWEEK(date);

-- View 3: Death Rates Per Country
CREATE VIEW view_death_rate AS
SELECT 
    cd.country,
    MAX(cd.total_deaths) AS total_deaths,
    MAX(cd.total_cases) AS total_cases,
    ROUND(MAX(cd.total_deaths)*100.0 / NULLIF(MAX(cd.total_cases), 0), 2) AS death_rate_percentage
FROM cases_deaths cd
GROUP BY cd.country;
