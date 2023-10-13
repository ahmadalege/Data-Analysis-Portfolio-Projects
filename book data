--Top 50 highest rated fantasy books
select "md"."Title", "md"."Score", "md"."Ratings" 
from metadata md 
JOIN genres g 
on "md"."Title" = "g"."Title"
where "Genre" like '%Fantasy%'
order by "Score" DESC limit 50;

--scores by genre

SELECT  "g"."Genre", "md"."Score"
from metadata md 
JOIN genres g 
on "md"."Title" = "g"."Title"
group by "g"."Genre", "md"."Score"
ORDER by "md"."Score" DESC limit 10;

--Ratings by genre

SELECT "g"."Genre", "md"."Ratings"
from metadata md 
JOIN genres g 
on "md"."Title" = "g"."Title"
group by "g"."Genre", "md"."Ratings"
order by "md"."Ratings" desc limit 10
