Use hr_data;
select * from emp_attrition;
SELECT COUNT(*) from emp_attrition;

#1 Write an SQL query to find the details of employees under attrition having 5+ years of experience between age group 27-35
SELECT COUNT(*) FROM emp_attrition 
WHERE TotalWorkingYears>=5 AND 
AGE BETWEEN 27 AND 35;

/* #2 Fetch the details of employees having maximum and minimum salary working in 
different departments who received less than 13% salary hike */

SELECT MIN(MonthlyIncome) AS MINSALARY,
MAX(MonthlyIncome) AS MAXSALARY,
Department FROM emp_attrition
WHERE PercentSalaryHike<13
GROUP BY Department
ORDER BY MINSALARY ASC;

/*3# Calculate the average monthly income of all the employees who worked more than 3 years whose
education background is medical */

SELECT AVG(MonthlyIncome) as AvgmonthInc, EducationField 
from emp_attrition
WHERE TotalWorkingYears > 3 AND 
EducationField = "Medical";

/* 4# Identify the total number of male and female employees under attrition whose marital status is
married and haven't received promotion in last 2 years */
SELECT Gender,COUNT(EmployeeNumber), 
MaritalStatus, YearsSinceLastPromotion
FROM emp_attrition
WHERE Attrition="Yes" AND MaritalStatus = "Married" AND
YearsSinceLastPromotion=2
group by Gender;

/* #5 Employees with maximum performance rating but no promotion for 4 years and above */
SELECT *
FROM emp_attrition
WHERE PerformanceRating= (select MAX(PerformanceRating) from emp_attrition) AND 
YearsSinceLastPromotion >=4;

/*#6 Who has the maximum and minimum percentage of Salary hike */
Select EmployeeNumber,Department,YearsAtCompany,PerformanceRating,YearsInCurrentRole,
min(PercentSalaryHike),
max(PercentSalaryHike) 
from emp_attrition
group by YearsAtCompany,PerformanceRating,YearsInCurrentRole
order by min(PercentSalaryHike) asc,max(PercentSalaryHike) desc ;

select Department from emp_attrition
group by Department; /*or*/
select DISTINCT Department from emp_attrition;

/* #7 Employees working overtime but given minimum salary hike and are more than 5 years with company */
select * from emp_attrition
where overtime = "Yes" 
and PercentSalaryHike = (select min(PercentSalaryHike) from emp_attrition)
and YearsAtCompany >5;

/* #8 Employees did not work overtime but given maximum salary hike and are less than 5 years with company */

select * from emp_attrition
where OverTime="No" 
and YearsAtCompany <5
and PercentSalaryHike = (select max(PercentSalaryHike)
from emp_attrition);

/* #9 Employees marital status and their Relationship satisfaction rating */
select MaritalStatus, min(RelationshipSatisfaction),max(RelationshipSatisfaction)
from emp_attrition
group by MaritalStatus;

/* #10 Employees educational background and their job role with min performance rating */
select EducationField,JobRole,
MIN(PerformanceRating)
from emp_attrition
group by EducationField,JobRole;

/* #11 Employees under attrition who has maximum training time and experience in the company */
select EmployeeNumber, 
MAX(TrainingTimesLastYear),
YearsAtCompany
from emp_attrition where Attrition = "Yes"
group by YearsAtCompany;





