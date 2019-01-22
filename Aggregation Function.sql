/*
Select A1, A2... <-- Aggregation functions over values in multiple rows: min, max, sum, avg, count
From R1, R2, 
where (condition)
Group By columns <-- Allows us to partition our relations into groups, so we can compute aggregated aggregate function over each group independently.
Having (condition) <-- Allows us to test

/* Computer the average GPA of the students in the database */

select avg(GPA) /* Aggregate function */
from Student;

/* Find the lowest GPA of students applying to CS */

select min(GPA)
from Student JOIN Apply using (sID)  /* equates ID to ensure its the same student */
where major = 'CS';

/* Find the average GPA of students applying to CS */

/* Find the lowest GPA of students applying to CS, while ensuring you don't count their GPA twice if they applied twice */



select avg(GPA)
from Student
where sID in (select sID from Apply where major = 'CS');

/* Subquery: Determine the unique sID's for students that applied for CS
Outer: Calculate the avg GPA for students who's sID are within those who applied for CS */ 


/* Find the number of colleges with a population greater than 15,000*/

select count(*) /* The count function returns the number of colleges that meet the condition */
from College
where enrollment > 15000;

/* Count number of students that applied to Cornell */

select count(*)
from Apply
where cName = 'Cornell';