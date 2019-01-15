drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

create table College(cName text, state text, enrollment int); /* Creating tables, whereas the schema is where we fill it with values */
create table Student(sID int, sName text, GPA real, sizeHS int);
create table Apply(sID int, cName text, major text, decision text);

/* create table tableName(columnName type, columnName, type); */
