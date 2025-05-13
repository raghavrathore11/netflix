use netflix;


create table netflix_1(
show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
    );
    
select* from netflix_1;
    
                -- 1 Count the number of Movies vs TV Shows
    
select type,count(*) as num
from netflix_1
group by type;
    
  
               --  2. List all movies released in a specific year (e.g., 2020)

select * from netflix_1
where type = "Movie" and release_year = "2020";
   
   
   
              -- 3. Find the top 5 countries with the most content on Netflix
   
use netflix;
select * from netflix_1;
   
   
             -- 4. Identify the longest movie
   
select  *,     CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS numeric_part 
from netflix_1
where type="Movie" 
ORDER BY numeric_part DESC
limit 1;
 
 
           -- 5. Find content added in the last 1 years
 
SET SQL_SAFE_UPDATES = 0;
UPDATE netflix_1
SET date_added = DATE_FORMAT(STR_TO_DATE(date_added, '%d/%m/%Y'), '%Y-%m-%d');

SET @max_date = (SELECT MAX(date_added) FROM netflix_1);

with t1 as(
SELECT *
FROM netflix_1
WHERE date_added BETWEEN (@max_date - INTERVAL 1 YEAR) AND @max_date)
select* from t1;


 
           -- 6. Find all the movies/TV shows by director 'Toshiya Shinohara'!
select * 
from netflix_1
where director like 'Toshiya Shinohara';
 

 
          -- 7. List all TV shows with more than 5 seasons
 
select *,substring_index(duration, ' ',1) as num_of_season from netflix_1
where type ="TV Show"
having num_of_season>5;
 
 
 
               -- 8. Count the number of content items in each genre

select * , length(listed_in)-length(replace(listed_in,',',''))+1 as num_of_genre
from netflix_1;

create table nums(
num int);


insert into nums
(num)
values
(1),(2),(3),(4),(5);

select * from nums;

with t1 as
(select * , substring_index(show_id,'s',-1) as id from netflix_1
order by id)
select * from t1 
join nums
on length(t1.listed_in)-length(replace(t1.listed_in,',',''))+1>=nums.num;


                 -- 9. List all movies that are documentaries

SELECT * FROM netflix_1
WHERE listed_in LIKE 'Documentaries';



 





 
 
 
 
 

 
 
 
 
 
 
 
    
    
    

    