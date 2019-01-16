/* Q1: Find the titles of all movies directed by Steven Spielberg. */

select title
from Movie
where director = 'Steven Spielberg';

/* Q2: Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. */

select distinct year
from Movie join Rating 
on Movie.mID = Rating.mID 
/* First, we must make sure we are talking about the same movie, so we can use their IDs to verify (as they're common in both tables)*/
where stars >= 4
ORDER BY year ASC; /*Sort in ascending order */

/* Q3: Find the titles of all movies that have no ratings. */

/* We need the titles and ratings
As we can see, if the movie has no rating, then its mID does not exist inside the ratings table 
Therefore, we must check for which titles does there not exist an mID inside the Ratings tabke*/

select title
from Movie
where mID NOT IN (select mID from Rating);

/* Q4: Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. */

/* We need the names of the reviewers if they left the date = NULL 
We must also ensure the person rating is the right person*/

select name
from Reviewer JOIN Rating using (rID) /* Equate rID's to make sure its the same person */
where ratingDate IS NULL; /* Check NULL */


/* Q5: Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. */

select distinct name, title, stars, ratingDate
from (Movie join Rating using (mID)) join Reviewer using (rID)
ORDER BY NAME, TITLE, STARS;

/* Q6: For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. 
 */