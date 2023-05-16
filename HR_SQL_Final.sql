-- CREATE database HR;
-- USE HR;
-- SELECT * FROM hr_1;
-- SELECT * FROM hr_2;
 
### ---------join hr_1 and hr_2 database ------------
CREATE TABLE HR AS 
SELECT*FROM hr_1  JOIN hr_2  ON hr_1.EmployeeNumber = hr_2.`Employee ID`;
SELECT * FROM HR;

### ----------- Q1 Average Attrition rate for all Departments -----------

CREATE TABLE `Attrition Ratio` AS
SELECT Department, CONCAT(FORMAT((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), '%')as Attrition 
FROM hr
GROUP BY Department order by attrition DESC;



### ------------- Q2.Average Hourly rate of Male Research Scientist  -----------
CREATE TABLE `Average Hourly rate of Male Research Scientist` as
SELECT JobRole,Gender,concat('$',format(AVG(HourlyRate),2)) AS "Average Hourly Rate" 
FROM hr
WHERE GENDER= 'MALE' AND JOBROLE='Research Scientist'
GROUP BY JOBROLE ;

### ----------- Q3.Attrition rate Vs Monthly income stats-----------
CREATE TABLE `Attrition rate Vs Monthly income stats` as
SELECT 
      CONCAT(FLOOR(monthlyincome/4000) * 4000 , '-', FLOOR(monthlyincome/4000)*4000+3999) as "incomebin",
	   CONCAT(FORMAT((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), '%') AS "Attrition Ratio",
	   SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as "Attrition count"
FROM hr
GROUP BY incomebin order by FLOOR(monthlyincome/4000) ASC;

### ------------- Q4.Average working years for each Department ------
CREATE TABLE `Average working Years for Each Department` as
SELECT department, FORMAT(avg(totalworkingyears),2) AS "Avg Total Working Years"
FROM hr
GROUP BY department ORDER BY "Avg Total Working Years"  DESC;

### -------------- Q5.Job Role Vs Work life balance -----------------
CREATE TABLE `JOB ROLE VS WORK LIFE BALANCE` as

SELECT JobRole,
    CONCAT(FORMAT(SUM(CASE WHEN WorkLifeBalance = '1' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2), '%') AS '1',
    CONCAT(FORMAT(SUM(CASE WHEN WorkLifeBalance = '2' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2), '%') AS '2',
    CONCAT(FORMAT(SUM(CASE WHEN WorkLifeBalance = '3' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2), '%') AS '3',
    CONCAT(FORMAT(SUM(CASE WHEN WorkLifeBalance = '4' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2), '%') AS '4'
FROM hr
GROUP BY  JobRole;

### ----------------- Q6.Attrition rate Vs Year since last promotion relation -------------
CREATE TABLE `ATTRITION RATE VS YEAR SINCE LAST PROMOTION RELATION` as
SELECT
  CONCAT((FLOOR((YearsSinceLastPromotion-1) / 5) * 5 + 1), '-', (FLOOR((YearsSinceLastPromotion-1) / 5) * 5 + 5)) AS YearsSinceLastPromotion,
  CONCAT(FORMAT((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), '%') AS "Attrition Ratio"
FROM hr
GROUP BY FLOOR((YearsSinceLastPromotion-1) / 5)
ORDER BY FLOOR((YearsSinceLastPromotion-1) / 5) ASC;


### -------- Q7.Average of JobSatisfaction, EnvironmentSatisfaction,RelationshipSatisfaction, WorkLifeBalance -----
CREATE TABLE `SATISFACTION LEVEL` as
SELECT 
	 FORMAT(avg(jobsatisfaction),2) AS "Avg of JobSatisfaction",
	 FORMAT(avg(environmentsatisfaction),2) AS "Avg of EnvironmentSatisfaction",
     FORMAT(avg(RelationshipSatisfaction),2) AS " Avg of RelationshipSatisfaction",
     FORMAT(avg(WorkLifeBalance),2) AS " Avg of WorkLifeBalance"
FROM hr;

## --------- Q9 Jobinvolvement vs distance from home--------##
CREATE TABLE `JOBINVOLVEMENT VS DISTANCE FROM HOME VS OVER TIME` as
SELECT JobInvolvement, 
       format(AVG(CASE WHEN OverTime = 'Yes' THEN DistanceFromHome END),2) AS 'OverTime_Yes',
       format(AVG(CASE WHEN OverTime  = 'No' THEN DistanceFromHome END),2) AS 'OverTime_No'
FROM hr
GROUP BY JobInvolvement ORDER by JobInvolvement;




### -------- Q8.----------###

CREATE TABLE `SUNBURST` as
 SELECT 
      CASE 
           WHEN age BETWEEN 18 AND 24 THEN "18-24"
			WHEN AGE BETWEEN 25 AND 34 THEN "25-34"
            WHEN AGE BETWEEN 35 AND 44 THEN "35-44"
            ELSE "45 Above" END AS Age_Group,
Education, FORMAT(AVG(Percentsalaryhike),2) AS " Avg og Percentsalaryhike"
FROM  hr
WHERE Attrition = "yes"
GROUP BY Age_group , Education ORDER BY Age_group;


