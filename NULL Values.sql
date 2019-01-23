/* Any value in  column can take a NULL value, meaning it is undefined or unknown */

insert into Student values )432, 'Kevin', null, 1500);
insert into Student values (321, 'Lori', null, 2500); /* They both have a NULL GPA , which is shown in the data */

/*Find students with GPA greater than 3.5 */

select sID, sName
from Student
where GPA > 3.5; 

/* Kevin and Lori aren't here b/c they are NULL */

select sID, sName
from Student
where GPA > 3.5 OR GPA <=3.5 or GPA is NULL;

/* Now, all values are included */



select sID, sName, GPA, sizeHS
from Student
where GPA > 3.5 or sizeHS < 1600 or sizeHS >= 1600;

/* Kevin is selected despite not having a GPA, but because he meets the high school requirement */


/* Null and aggregate functions */

select count(distinct GPA) /* count is an aggregate function that counts the number (quantity) */
from Student
where GPA is not NULL;
