/*Q1: Find the names of all reviewers who rated Gone with the Wind.  */

/* We must return the name of the reviewers, but this table does not have the movie name. */
/* The reviewers table is connected to ratings through rID, when we join them, the rID's will join and all other columns will join.
Then, we can join this with the movie table, where the mID will join, as well as the titles */

select distinct name
from (Reviewer JOIN Rating using (rID)) JOIN Movie using (mID)
where title = 'Gone with the Wind';


/* Q2: For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. 
*/

/* Must return the reviewer name, title, and number of stars */
/* We must equate the reviewer name (Reviewer -rID) and the director name (movies - mID)*/
/* We can join the Reviewer and Rating, which will combine the rID, and the stars, then we can join it with movies*/

select name, title, stars
from (Rating left JOIN Reviewer using (rID)) JOIN Movie using (mID)
where name = director;

/* Q3: Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)  */

/* Must return both the name and title in one column */
/* We can combine two select statements so its printed together */

select name
from Reviewer
UNION
select title
from Movie
ORDER BY NAME ASC;