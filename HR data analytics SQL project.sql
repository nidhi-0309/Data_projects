/*Each day, they are many people who begin their journey with a new job or leave the job for their personal circumstances. My focus and scope of the dataset is on workforce reduction in the company, which is a fictional dataset created by IBM data scientists to showcase or unveil the factors that lead to employee attrition. Employee Attrition is determining the turnover rate (i.e., percentage of employees leaving the organization voluntarily, involuntarily, role deletion or internal). Quitting may happen due to various factors such as more working hours, no recognition, low payment, work distance from home, work environment, management, better prospects etc. My idea/motto of My project is to visualize the data and provide meaningful insights, find out whether she/he is going to quit or not, if they are leaving, what are the reasons behind it. Based on findings, we can provide suggestions on how to reduce the employee attrition such that long term strategies in the company won't get affected, apart from that, recruiting new employees, hiring, training them is way costlier than not terminating someone.
The dataset has 35 attributes and 1470 employees with no missing information. Also, through high-level analysis, the dataset is unbalanced, as 84% of employees do not quit and 16% quit.*/
Use hr_data;
select * from emp_attrition;
SELECT COUNT(*) from emp_attrition;
/*Attrition Rate Analysis*/
#1 Write an SQL query to find the details of employees under attrition having 5+ years of experience between age group 27-35
SELECT COUNT(*) FROM emp_attrition 
WHERE TotalWorkingYears>=5 AND 
AGE BETWEEN 27 AND 35;

/*Salary Analysis*/
/* #2 Fetch the details of employees having maximum and minimum salary working in 
different departments who received less than 13% salary hike */

SELECT MIN(MonthlyIncome) AS MINSALARY,
MAX(MonthlyIncome) AS MAXSALARY,
Department FROM emp_attrition
WHERE PercentSalaryHike<13
GROUP BY Department
ORDER BY MINSALARY ASC;

/* Salary and Tenure Analysis */
/*3# Calculate the average monthly income of all the employees who worked more than 3 years whose
education background is medical */

SELECT AVG(MonthlyIncome) as AvgmonthInc, EducationField 
from emp_attrition
WHERE TotalWorkingYears > 3 AND 
EducationField = "Medical";

/*Demographic Analysis*/
/* 4# Identify the total number of male and female employees under attrition whose marital status is
married and haven't received promotion in last 2 years */
SELECT Gender,COUNT(EmployeeNumber), 
MaritalStatus, YearsSinceLastPromotion
FROM emp_attrition
WHERE Attrition="Yes" AND MaritalStatus = "Married" AND
YearsSinceLastPromotion=2
group by Gender;

/*Performance Analysis*/
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

/*Demoraphic Analysis */
select Department from emp_attrition
group by Department; /*or*/
select DISTINCT Department from emp_attrition;

/*Organizational Work culture analysis */ 
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

/*Demographic factors affecting the work Analysis*/
/* #9 Employees marital status and their Relationship satisfaction rating */
select MaritalStatus, min(RelationshipSatisfaction),max(RelationshipSatisfaction)
from emp_attrition
group by MaritalStatus;

/*Demographic Analysis*/
/* #10 Employees educational background and their job role with min performance rating */
select EducationField,JobRole,
MIN(PerformanceRating)
from emp_attrition
group by EducationField,JobRole;

/* Training and Development Analysis */
/* #11 Employees under attrition who has maximum training time and experience in the company */
select EmployeeNumber, 
MAX(TrainingTimesLastYear),
YearsAtCompany
from emp_attrition where Attrition = "Yes"
group by YearsAtCompany;

/*Findings
1. Age group: Employees who worked for 5 to 8 years would like to switch for better income and higher position and most of them are around 27.
2. Gender: Female with lower salaries or satisfaction tend to leave quickly.
3. Work-life balance/marital status: Attrition count for single, male seems to be high when compared with married and divorced.
4. Monthly income : It is less likely to leave if the income is more. Apart from that, hikes also play prominent role.
5. Education : Employees who did Bachelors has high chance to leave due to their further career progress in terms of studies or better job opportunities.
6. Department : Research & Development shows high attrition count for age group between 27 and 29. Though, average income is high for sales, they tend to leave more. 
7. Overtime :  most of the employees who worked overtime are seen to be left the organization. But it's 54% of employees are overtime which is almost balanced with who don't work overtime. This might not be the reason to leave the company.
8. Work Environment: There is high chance of leaving for employees who have no recognitions, appreciations, more work pressure, manager behavior etc.*/


/*Conclusion
Overall, firstly, hikes, perks and recognitions play vital role for an employee to either continue or quit the job. 
Secondly, late 30s tend to either pursue higher education or switch the companies in order to earn well and settle rich. 
Thirdly, toxic environment also leads to employee attrition. These are three main factors that impact company turnover rate and profits.
It's not the overtime, moreover, employee thinks if she/he is underused.
 However, to reduce it, based on our research and analysis of dataset, we have mentioned few implementations in previous section.
*/
