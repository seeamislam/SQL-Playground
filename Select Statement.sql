/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/

/**************************************************************
Find the ID, names, and GPA of students with GPA > 3.6
**************************************************************/

select sID, sName /* Select which columns (attributes you want to select)*/
from Student /* Select the table you want it from */
where GPA > 3.6;


/**************************************************************
  Find the names of student and the major they applied for
**************************************************************/

select sName, major /* Collect two attributes */
from Student, Apply/* From two different tables */
where Student.sID = Apply.sID; /* checking where the student ID in the first table matches the student ID in the third table, so we can determine their name and the program they applied to


Output: Prints a new chart with the data that we used SELECT (student name and the program(s) they applied to

SName     Major
Amy       CS       /* We have duplicates because the student applied to multiple different schools, for the same major 
Amy       EE
Amy       CS
Amy       EE
...
Bob       Biology

*/

/*** Same query with Distinct, note difference from algebra ***/

select distinct sName, major /* Now, we can use the DISTINCT feature to eliminate the duplicates */
from Student, Apply
where Student.sID = Apply.sID;

/* Output: 

SName     Major     /* Now it eliminates all duplicates 
Amy       CS
Amy       EE
...
Bob       Biology





/**************************************************************
  Names and GPAs of students with sizeHS < 1000 applying to
  CS at Stanford, and the application decision
**************************************************************/

select sname, GPA, decision /* We want their name, GPA, and their college decision */
from Student, Apply /* The information we need is inside these two tables */

where Student.sID = Apply.sID and /* Must make sure the ID's in both table align again, to make sure we have the correct student (there could be two of the same name)*/
and sizeHS < 1000 and major = 'CS' and cname = 'Stanford'; /* We only want the data for students with a HS greater than 1000, and are majoring in CS, and applied to Stanford

Output:

sName    GPA    Decision
Helen    3.7    Y
Irene    3.9    N

/**************************************************************
  All large campuses with CS applicants
**************************************************************/

select cName /* Note: This won't work because the name c.Name is ambiguous, as it belongs to both college and apply tables
from College, Apply
where College.cName = Apply.cName
  and enrollment > 20000 and major = 'CS';

/*** Fix error ***/

select distinct College.cName /* Make it distinct or we can have duplicates of each college. */
from College, Apply
where College.cName = Apply.cName
  and enrollment > 20000 and major = 'CS';

/**************************************************************
  Application information
**************************************************************/

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;

/* This gives us the student id, name, gpa, the colleges they applied to, and their enrollment sizes



/*** Sort by decreasing GPA ***/

/* really, SQL just produces them in a random order, but we can actually sort it */

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc; /* This is how we can sort it in descending GPA */



/*** Then by increasing enrollment ***/

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc, enrollment; 

/* By adding the enrollment, after it sorts GPA by descending, if two GPA's are the same, then it will look at the enrollment sizes next to decide which to print */

/**************************************************************
  Applicants to bio majors
**************************************************************/

/* The like operator allows us to do string matching on attribute values */

select sID, major /* We want to print the studentID and majors */
from Apply
where major like '%bio%'; /* We want to print only those students who have a major that includes the string "bio" *./

Output: 

sID    Major
234    biology
345    bioengineering

/*** Same query with Select * ***/

select * /* by using a * in the select, we can just get all the attributes at once */
from Apply
where major like '%bio%';

/**************************************************************
  Select * cross-product
**************************************************************/

select *
from Student, College; /* This prints ALL the attributes from both the students table and college table */

/**************************************************************
  Add scaled GPA based on sizeHS
  Also note missing Where clause
**************************************************************/

select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) /* We can create a new attribute in the table which does (GPA*(SizeHS/1000.0)) */
from Student;

/* Output:

sID    sName   GPA   sizeHS   GPA*(sizeHS/1000.0)
123    Amy     3.9   1000     3.9
...
...
...

/*** Rename result attribute ***/ 

select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as scaledGPA /* We can change the name of the new attribute */
from Student;

/* output 
sID    sName   GPA   sizeHS   scaledGPA
123    Amy     3.9   1000     3.9
...
...
...