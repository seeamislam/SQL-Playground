/* Create a program that generates a scaled GPA of a student and check if the GPA has been changed by more than 1 */

select sName, sID, GPA, GPA*(sizeHS/1000) as ScaledGPA /* changes column name to Scaled GPA */
from Student
where GPA*(sizeHS/1000) - GPA > 1.0 or  GPA - GPA*(sizeHS/1000) > 1.0;

/* This is poor form because we must rewrite the computation multiple times. */

select sName, sID, GPA, GPA*(sizeHS/1000) as ScaledGPA /* changes column name to Scaled GPA */
from Student
where abs(GPA*(sizeHS/1000) - GPA > 1.0);

/* But, what if we want to use something like a variable for the calculation, so you only need to do it once? */

select *
from (select sName, sID, GPA, GPA*(sizeHS/1000) as ScaledGPA from Student) G /* Use the old select clause as a subquery in the from clause */
where abs(G.scaledGPA - GPA > 1.0);

/* Subquery: Generates a table of names, ids, gpas, and scaled GPAs. It stores this to a new table named G.
Outer: We select all contents from the new table of G, and use G.scaledGPA to use that column's contents */


/* -----------------------------------------------------------------------------*/

/* Find colleges and pair those colleges with students with the highest GPA among their applicants */

select distinct College.cName, state, GPA 
from College, Apply, Student
where College.cName = Apply.cName and Apply.sID = Student.sID
and GPA >= all (select GPA from Student, Apply where Student.sID = Apply.sID and Apply.cName = College.cName);

/* Sub-Query: find the GPAs of students, (the where clause ensures they're not duplicates)*/
/* Outer: Find the college name, state, and GPA, where the GPA is the greater than all other GPAs */