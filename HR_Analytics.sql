--Total Employees
SELECT COUNT(*) AS total_employees FROM hr_analytics;

--Attrition Count
SELECT COUNT(*) AS attrition_count
FROM hr_analytics
WHERE Attrition = 'Yes';

--Attrition Rate
SELECT 
ROUND(
    COUNT(CASE WHEN Attrition='Yes' THEN 1 END) * 100.0 / COUNT(*),
    2
) AS attrition_rate
FROM hr_analytics;

--Average Salary
SELECT ROUND(AVG(MonthlyIncome),2) AS avg_salary
FROM hr_analytics;

--Average Experience
SELECT ROUND(AVG(YearsAtCompany),2) AS avg_experience
FROM hr_analytics;

--Attrition by Department
SELECT 
Department,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY Department
ORDER BY attrition DESC;

--Attrition by Job Role
SELECT 
JobRole,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY JobRole
ORDER BY attrition DESC;

--Attrition by Gender
SELECT 
Gender,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY Gender;

--Salary vs Attrition
SELECT 
Attrition,
ROUND(AVG(MonthlyIncome),2) AS avg_salary
FROM hr_analytics
GROUP BY Attrition;

--Top 10 Highest Paid Employees
SELECT EmpID, MonthlyIncome
FROM hr_analytics
ORDER BY MonthlyIncome DESC
LIMIT 10;

--Overtime Impact
SELECT 
OverTime,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY OverTime;

--Work-Life Balance
SELECT 
WorkLifeBalance,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;

--Years at Company
SELECT 
YearsAtCompany,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;

--Total Working Years
SELECT 
TotalWorkingYears,
COUNT(*) AS total,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition
FROM hr_analytics
GROUP BY TotalWorkingYears
ORDER BY TotalWorkingYears;

--High Risk Employees
SELECT *
FROM hr_analytics
WHERE OverTime='Yes'
AND MonthlyIncome < (SELECT AVG(MonthlyIncome) FROM hr_analytics);

--Employees Likely to Leave
SELECT *
FROM hr_analytics
WHERE JobSatisfaction <= 2
AND WorkLifeBalance <= 2
AND OverTime='Yes';

--Department Attrition Rate
SELECT 
Department,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),
2
) AS attrition_rate
FROM hr_analytics
GROUP BY Department
ORDER BY attrition_rate DESC;

--POWER BI VIEW
CREATE VIEW hr_dashboard AS
SELECT 
EmpID,
Department,
JobRole,
Gender,
OverTime,
Attrition,
MonthlyIncome,
YearsAtCompany,
WorkLifeBalance
FROM hr_analytics;