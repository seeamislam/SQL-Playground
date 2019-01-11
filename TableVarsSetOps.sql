/**************************************************************
  TABLE VARIABLES AND SET OPERATORS
  Works for SQLite, Postgres
  MySQL doesn't support Intersect or Except
**************************************************************/


/* Set Operators: Union, Intersect, Except */

/**************************************************************
  Application information
**************************************************************/

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;

/*** Introduce table variables ***/

select S.sID, S.sName, S.GPA, A.cName, C.enrollment
from Student S, College C, Apply A /* We can set table variables, S, C, A, and use those variable names instead of their original */
where A.sID = S.sID and A.cName = C.cName; /* Replace old table names with their new variables */

/**************************************************************
  Pairs of students with same GPA
**************************************************************/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA /* print these in the chart */
from Student S1, Student S2 /* Table variables are handy when we need two instances (versions) of the same table <-- Here, we now have 2 versions of the student table. */
where S1.GPA = S2.GPA; /* Find where students have the same GPA in each table

Output: 

sID    sName    GPA     sID1    sName1    GPA1
123    Amy      3.9     123     Amy       3.9
123    Amy      3.9     456     Doris     3.9
...

As you can see, the first row matches Amy with herself, since they do have the GPA technically. The second row is correct. 



/*** Get rid of self-pairings ***/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID <> S2.sID; /* add a condition to make sure the sID of the two students are different, so they cannot match. 

However, now we have Amy mixed with Doris
and then Doris mixed with Amy

/*** Get rid of reverse-pairings ***/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S3.GPA
from Student S1, Student S2 /* Declare your table variables for Student table*/
where S1.GPA = S2.GPA and S1.sID < S2.sID /* Ensures that smaller sID student is listed first

/**************************************************************
  List of college names and student names
**************************************************************/

select cName from College /*prints cName from college */
union
select sName from Student; /*prints sName from Student */


/*** Add 'As name' to both sides ***/

select cName as name from College /* making this "as name" changes the table header to name */
union /* NOTE: The union sorts the list and eliminates all duplicates */
select sName as name from Student;

/*Output:
Amy
Berkeley
Bob
Cornell
... 

/*** Change to Union All ***/

select cName as name from College
union all /* If you add "all", it does not sort it and it does not remove the duplicate.
select sName as name from Student;

/*** Notice not sorted any more (SQLite), add order by cName ***/

select cName as name from College
union all
select sName as name from Student
order by name; /* This is a manual thing to make it organized alphabetically */

/**************************************************************
  IDs of students who applied to both CS and EE
**************************************************************/

select sID from Apply where major = 'CS' /* find the sID of students that applied to CS */
intersect
select sID from Apply where major = 'EE'; /* find the sID of students that applied to EE */

/*Output

sID
123
345

B/c we used the intersect operator, we look for the iD that satisfied both conditions

/**************************************************************
  IDs of students who applied to both CS and EE
  Some systems don't support intersect, so we use two instances of the Apply table (assign table variables)
**************************************************************/

select A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major = 'EE';

/*** Why so many duplicates? Look at Apply table ***/
/*** Add Distinct ***/

select distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major = 'EE';

/**************************************************************
  IDs of students who applied to CS but not EE
**************************************************************/

select sID from Apply where major = 'CS' 
except
select sID from Apply where major = 'EE';

/**************************************************************
  IDs of students who applied to CS but not EE
  Some systems don't support except
**************************************************************/

select A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major <> 'EE';

/*** Add Distinct ***/

select distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major <> 'EE';

/*** Can't do it with constructs we have so far ***/
