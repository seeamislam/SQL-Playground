/* There are two ways to insert data */

/* Let's add a new college to our database: */
insert into College values ('Carnegie Mellon', 'PA', 11500); /* Follow the create schema exactly */



/* Now we can update the record of the students who havent applied anywhere*/
select * 
from Student
where sID not in (select sID from Apply);

/* This identified the students who have not applied, now, let's update it so students who haven't applied yet will apply to Carngegie for CS, with no decision yet. */

insert into Apply
/* After the insert statement, whatever the follow code outputs, is going to be inputted into the new records */
select sID, 'Carnegie Melon', 'CS', NULL /* This is a format for a record in Apply, so you must follow it */ 
from Student
where sID not in (select sID from Apply); /* This ensures you select the right sID*/



/* Let's find students who applied to an EE major in other schools but were turned down, and then have them apply to Cargnie Mellon with an instant admission */

/*1) Find students who applied to EE but were rejected */

select * /* retrieve all their information */
from Student
where sID in (select sID from Apply where major = 'EE' AND decision = 'N');

/* 2) Now turn this into a query that constructs new records in the Apply relation */

Insert into Apply
select sID, 'Carnegie Melon', 'EE', 'Y'
from Student
where sID in (select sID from Apply where major = 'EE' AND decision = 'N');


/* Let's see which students applied to more than 2 different majors */

select sID, count(distinct major) /* Print the sID and the number of different majors applied to by that student) */
from Apply
group by sID /* This breaks the sID's into groups */
having count(distinct major) > 2; /* This counts the number of different majors there are per sID */

/* Now, let's delete all students who applied to 2 or more majors */

delete from Student
where sID in ( select sID
from Apply
group by sID /* This breaks the sID's into groups */
having count(distinct major) > 2); /* This counts the number of different majors there are per sID */



/* Accept applicants to Carnegie Melon with GPA < 3.6 but turn them into economic majors */

select * from Apply 
where cName = 'Carnegie Mellon' 
  and sID in (select sID from Student where GPA < 3.6);
  
/* SubQuery: select all sID of students who have a GPA lower than 3.6)
Outer: Select all students who applied to Carnegie Melon and have a GPA less than 3.6 */

update Apply
set decision = 'Y', major = 'Economics'
where cName = 'Carnegie Mellon' 
  and sID in (select sID from Student where GPA < 3.6);
  


