/* a Join clause is used to combine rows from two or more tables, based on a related column between them*/

/* Now, we can use the inner join, which is the default join.*/

select distinct sName, major 
from Student join Apply /* We know both the student and apply table have the same column for ID, so we can just used that. */
on Student.sID = Apply.sID;

/* This ultimately prints a new table with ONLY the common columns */

/* Find the name and GPA of students who come from high sschools with less than 1000 students and applied to major in CS at Stanford */

select distinct sName, GPA
from Student, Apply
where Student.sID = Apply.sID and
sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/* This can also be written as: */

select distinct sName, GPA
from Student join Apply /* We know student and Apply have the same columns for ID */
on Student.sID = Apply.sID 
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';


/* The next just finds a bunch of informationa bout a student application */

select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply, College, Student
where Apply.sID = Student.sID and Apply.cName = College.cName;

/* Now, let's do that using the join operator */

select Apply.sID, sName, GPA, Apply.cName, enrollment
from (Apply join College on Apply.cName = College.cName) join Student /* You must join Apply and College first (brackets), because college and student doesn't have any same column */
on Apply.sID = Student.sID; /* always change where to on */



/* -------------------------------------------------------------*/

select distinct sName, major
from Student join Apply
on Student.sID = Apply.sID;

/* We can use the natural join, which equates those values in the same column. */

select distinct sName, major
from Student natural join Apply ;
/* The common column is sID. The natural join automatically compares them, so you no longer need to verify if its the same ID */


/* Take the college example and change it to the best answer */

select distinct sName, GPA
from Student join Apply using (sID)
/* We know student and Apply have the same columns for ID. We can use the regular join clause, but instead add 'using (common column)'). This 
tells the query to automatically equate the respective values, so we don't have to use the natural join */
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';



/*-------------------------------------------------------------*/
/*Find pairs of students with the same GPA */

select  S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID < S2.sID;

/* To rewrite this, we know that the two students must have the same GPA */

select  S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 using (GPA) /* This automatically equates the two GPA's as a condition */
where S1.sID < S2.sID;


/*-------------------------------------------------------------*/

select sName, sID, cName, major
from Student join Apply using (sID);
/* Basic query to find name, college, and major that a student applied to, while comparing their IDs to avoid duplicates */

/* Now, we can use the outer join to include students who have not yet applied, but still exist in the database */

select sName, sID, cName, major
from Student left join Apply using (sID);

/* What does the left outer joint? It returns all records from the left table (student), as well as the matched records from the right table (College)
It will return null for the values that do not exist */

/* Use right instead of left for the opposite.
If you wish to return all records from both tables, use "full join" */


/* How can we rewrite this without the outer join clause? */

select sName, Student.sID, cName, major
from Student join Apply using (sID)

union

select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply) /* subquery returns all sID's in Apply

second query returns student name, id, null, null, if the sID from student does not exist in Apply */

/* Remember, the union is used to combine the result of two or more select statements. */