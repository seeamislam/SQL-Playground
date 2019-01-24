/* Q1: Find the titles of all movies directed by Steven Spielberg. */

select title
from Movie
where director = 'Steven Spielberg';

/* Q2: Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. */

select distinct year
from Movie JOIN Rating using (mID)
where stars = 4 OR stars = 5
ORDER BY year ASC;


/* Q3: Find the titles of all movies that have no ratings. */

/* If a movie has no rating, then it will not exist inside the Ratings table */

select title
from Movie
where mID not in (select mID from Rating);

/* Q4: Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. */

/* We must make sure the rating ID is the same, to avoid mixing up reviewers */

select name
from Reviewer JOIN Rating using (rID) /* B/c rID is a common column in each */
where ratingDate is NULL;


/* Q5: Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. */

select name, title, stars, ratingDate
from Movie, Reviewer, Rating
where Movie.mID = Rating.mID AND Rating.rID = Reviewer.rID
ORDER BY name, title, stars;

/* Q6: For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. */

/* return name and title
make sure the reviewer's ID lines up each time with the review 
To see if he rated it again, you must compare it */

/* SELECT name, title
FROM movie, reviewer 
WHERE rID = (
  SELECT r1.rID 
  FROM rating AS r1 JOIN rating AS r2 
  ON r1.rID = r2.rID AND r1.mID = r2.mID 
  WHERE r1.ratingDate > r2.ratingDate AND r1.stars > r2.stars) 

AND mID = (SELECT r1.mID 
FROM rating AS r1 JOIN rating AS r2 
ON r1.rID = r2.rID AND r1.mID = r2.mID 
WHERE r1.ratingDate > r2.ratingDate AND r1.stars > r2.stars
); */

/* Q7: For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. */

select title, MAX(stars)
from (select * from Movie JOIN Rating using (mID))
GROUP BY mID
ORDER BY title;