 --What are the top five stories with the highest scores?

 SELECT title,score
 FROM hacker_news
 ORDER BY score DESC
 LIMIT 5;

 --Penny Arcade – Surface Pro 3 update,Hacking The Status Game,Postgres CLI with autocompletion and syntax highlighting,Stephen Fry hits out at ‘infantile’ culture of trigger words and safe spaces, and Reversal: Australian Govt picks ODF doc standard over Microsoft.

 --Recent studies have found that online forums tend to be dominated by a small percentage of their users (1-9-90 Rule). Is this true of Hacker News? Is a small percentage of Hacker News submitters taking the majority of the points?

--First, find the total score of all the stories.
SELECT SUM(score)
FROM hacker_news;;
--sum is 6366.0

--Next, we need to pinpoint the users who have accumulated a lot of points across their stories.

--Find the individual users who have gotten combined scores of more than 200, and their combined scores.

SELECT user, SUM(score)
FROM hacker_news
GROUP BY user
HAVING SUM(score) > 200;
-- USERS ARE amirkhella score:309, dmmalam score:304, metafunctor score: 282 , and vxNsr score:517.


--Then, we want to add these users’ scores together and divide by the total to get the percentage.
--So, is Hacker News dominated by these users?

SELECT (517 + 309 + 304 + 282) / 6366.0;
--22% of the score of the entire website are these four people, so yes!



--Oh no! While we are looking at the power users, some users are rickrolling — tricking readers into clicking on a link to a funny video and claiming that it links to information about coding.

--The url of the video is:

--https://www.youtube.com/watch?v=dQw4w9WgXcQ

--How many times has each offending user posted this link?

SELECT user,count(url) FROM hacker_news
GROUP BY 1
HAVING url LIKE  '%https://www.youtube.com/watch?v=dQw4w9WgXcQ%'
ORDER BY 2 DESC;

--sonnynomnom : 2
-- scorpiosister:1

--Hacker News stories are essentially links that take users to other websites.

--Which of these sites feed Hacker News the most:

--_GitHub, Medium, or New York Times?_

--First, we want to categorize each story based on their source.

SELECT CASE
  WHEN url LIKE '%github%' THEN 'GitHub'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'Other'
  END AS 'Source'
FROM hacker_news;


--Next, build on the previous query:

--Add a column for the number of stories from each URL using COUNT().

--Also, GROUP BY the CASE statement.

SELECT CASE
  WHEN url LIKE '%github%' THEN 'GitHub'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'Other'
  END AS 'Source',
COUNT(*)
FROM hacker_news
GROUP BY 1;
-- GitHub = 27
-- NYT = 13
--Medium = 12
-- Other = 3948


--Every submitter wants their story to get a high score so that the story makes it to the front page, but…

--What’s the best time of the day to post a story on Hacker News?


SELECT strftime('%H', timestamp) AS 'Hour of Day', ROUND(AVG(score)) AS 'Average Score',COUNT(*) AS 'Number of Stories'
FROM hacker_news
WHERE timestamp is NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

--Best times of day to post a story are:
-- 6:00 PM, 7:00 AM AND 7:00 PM as they collectively have the highest scores.
