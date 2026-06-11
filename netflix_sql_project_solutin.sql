select * from netflix;

-- 15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows

select type, count(*) as total_content
from netflix
group by type;


--2. Find the most common rating for movies and TV shows
select type, rating
from
(select type,count(*), rating,
Rank() over(partition by type order by count(*)desc) as ranking
from netflix
group by 1,3) as t1 where ranking = 1;

--3. List all movies released in a specific year (e.g., 2020)
select * from netflix
where type = 'Movie' and  release_year = 2020


--4. Find the top 5 countries with the most content on Netflix
select count(show_id) as total_content, type,
 unnest(string_to_array(country, ',')) as new_country
from netflix
group by 2, 3
order by 1 desc
limit 5;

--5. Identify the longest movie
select *
from netflix
where type = 'Movie'
and duration = (select max(duration) from netflix)

--6. Find content added in the last 5 years
select *, 
TO_DATE(DATE_ADDED, 'YY-Month-DD')
from netflix
where date_added >= 
SELECT current_date - interval '5 years'


--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select *
from netflix
where director ilike '%Rajiv Chilaka%'

--8. List all TV shows with more than 5 seasons
select *
from netflix
where type ='TV Show' and split_part(duration,' ',1)::numeric >5 ;

--9. Count the number of content items in each genre
select count(
show_id)AS Total_Content,
unnest(string_to_array(listed_in, ',')) AS GENRE
from netflix
GROUP BY 2;

--10.Find each year and the average numbers of content release in India on netflix.
--return top 5 year with highest avg content release!
select EXTRACT (YEAR FROM) to_date (date_added,'Month DD, YYYY' ) AS year,
count (*) as yearly content,round( count(*)::numeric/(select count (*) from netflix
where country = 'India')::numeric * 100,2) as avg_content_per_year
from netflix
where country = 'India'
group by 1


--11. List all movies that are documentaries
select * from netflix
where
listed_in ilike '%documentaries%'

--12. Find all content without a director
select *
from netflix
where director is null

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix
where casts ilike '%Salman Khan%' and 
release_year > extract (year from current_date) - 10

--14. Find the top 10 actors who have appeared in the highest number of movies 
--produced in India.
select  unnest(string_to_array(casts,',')) as actors, count (*) as total_content
from netflix
where country ilike '%india%'
group by 1
order by 2 desc

--15.Categorize the content based on the presence of the keywords 'kill' and
--'violence' in the description field. Label content containing these keywords as
--'Bad' and all other content as 'Good'. Count how many items fall into each category.

select * ,
case 
when 
description ilike '%kills%' or  
description ilike '%violent%' then 'Bad_content' 
else 'Good Content'
end category
from netflix
where description ilike '%kills%' or description ilike '%violent%'

