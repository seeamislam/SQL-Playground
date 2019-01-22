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


/* Now, let's delete all students who applied to 2 or more majors */

select sID, count(distinct major) /* Print the sID and the number of different majors applied to by that student) */
from Apply
group by sID /* This breaks the sID's into groups */
having count(distinct major) > 2; /* This counts the number of different majors there are per sID */