/* Using a nested where statement

In some cases, it may make sense to use the join clause (AND) to make a query, but there is really another way to optimize it. 
You can use ANY and ALL, which enables you to compare a single value, such as a column, to one of more results returned by the subquery 
Ex: A running max to identify the maximum value in a column */

select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS');

/* The nested query finds the ID of all students who applied to college for CS */
/* The outer query finds the ID and name of the students who did apply to CS */


select sName
from Student
where sID in (select sID from Apply where major = 'CS');

/*SubQuery: Find the student id of students who applied to CS */
/* Outer: Find the name of students of those studentIDs */

/*We can rewrite this using the join clause (and) too*/

select distinct sName /* Use distinct to eliminate the duplicates */
from Student, Apply
where major = 'CS' and Student.sID = Apply.sID;


select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
and sID not in (select sID from Apply where major = 'EE');

/* Subqueries:
1) Find the student ID of students who majored in CS
2) Find the student IDs of students who applied to EE, and exclude them (even if they applied to CS)

Outer: 
Find the name of each student. */



/* The exist clause checks if AT LEAST ONE row is returned within the subquery (does it exist? or does it not exist?) 
Returns true whenever the subquery returns one or more values. Returns false otherwise */


select cName, state
from College C1 /*Create a duplicate instance of the college table */
where exists (select * from College C2 where C2.state = C1.state and C1.cName <> C2.cName);
              /* Subquery is asking: Is there any value in college 2 where the state is the same and the name is not the same? */

/* Uses exist to check if the subquery is empty or not, rather than what the values are --> Answer is yes*/
/*The subquery selects all colleges in C2 (duplicate of colleges) which are in the same state as one in C1 (another instance of Colleges), where the names are not the same */


/* Find the college with the largest enrollment, but don't use the MAX operator. */
select cName
from College C1
where not exists (select * from College C2 where C1.enrollment < C2.enrollment); /* We want to use two instances of the college tables since we're comparing through it */

/* not exists returns TRUE if no rows/values are returned */
/* Select all the colleges from the C2 instance where the enrollment is the greatest. */



/* --------------------------------------------------------- */

/* The all operator tells us if there is a relationship with ALL values */

select sName, GPA
from Student
where GPA >= all (select GPA from Student);

/* Subquery: Select the GPA's of all students 
Outer: Check if the GPA is greater than or equal to ALL values in the subquery, which is true. */
/* This will print the name and GPA of all students who's GPA's are greater than of equal to those in the subquery */

/* Another way to find the highest GPA: */

select sName
from Student S1
where GPA >= all (select GPA from Student S2 where S2.sID <> S1.sID);
/* Subquery: Find all GPA's of students from S2 who's IDs are NOT the same */
/* Outer: Find the name of all students who's GPA is greater than that of the inner query */


/* Find the college with the greatest enrollment: (max enrollment) */

select cName
from College C1
where enrollment >= all (select enrollment from College C2 where C1.cName <> C2.cName);

/* Subquery: Find the enrollment of all colleges */
/* Outer: Find the name of all colleges where the enrollment is greater than or equal to the enrollment array in the subquery. */


/* --------------------------------------------------------- */

/* The condition ANY must satisfy ANY condition of the set */

/* Find the college who's enrollment is not less than or equal to any other college (aka its the biggest)*/

select cName
from College C1
where not enrollment <= any (select enrollment from College C2 where C2.cName <> C1.cName;)

/* Subquery: Find the enrollments of all colleges
Outer: Find the name of the colleges where the enrollment is NOT less than or equal to ANY of the colleges in the subquery) */

