-- 1 
SELECT 
    COUNT(items) AS 'quantity'
FROM
    (SELECT 
        reviews.r_id AS 'items'
    FROM
        reviews UNION ALL SELECT 
        news.n_id AS 'items'
    FROM
        news) AS unionTable;
            
-- 2            
SELECT 
    nc_name, COUNT(news.n_id)
FROM
    news
        LEFT JOIN
    news_categories ON news.n_category = news_categories.nc_id
GROUP BY nc_name;
    
-- 3  
SELECT 
    rc_name, COUNT(r_id)
FROM
    reviews
        RIGHT JOIN
    reviews_categories ON reviews.r_category = reviews_categories.rc_id
GROUP BY rc_name;

-- 4 
SELECT rc_name AS 'name', MAX(r_dt) AS 'last_date' from reviews join reviews_categories on  reviews.r_category = reviews_categories.rc_id
GROUP BY rc_name
UNION ALL
SELECT nc_name AS 'name', MAX(n_dt) AS 'last_date' from news join news_categories on  news.n_category = news_categories.nc_id
GROUP BY nc_name;

-- 5 
select p_name, bannersPages.b_id, b_url
from pages right join 
	(select p_id, banners.b_id, b_url from m2m_banners_pages left join banners using (b_id)) AS bannersPages
using (p_id)
where p_parent is null;

-- 6 
select distinct p_name 
from pages right join m2m_banners_pages using (p_id);

-- 7
select p_name from pages left join m2m_banners_pages using (p_id) where b_id is null;

-- 8
select distinct b_id, b_url from
banners right join m2m_banners_pages using (b_id);


-- 9
select distinct b_id, b_url from
banners left join m2m_banners_pages using (b_id) where p_id is null;


-- 10
select b_id, b_url, b_click/b_show*100 as rate
from banners having rate >= 80;

-- 11
select distinct p_name from
m2m_banners_pages join pages using(p_id) 
join banners using(b_id)
where b_text is not null;

-- 12
select distinct p_name from
m2m_banners_pages join pages using(p_id) 
join banners using(b_id)
where b_pic is not null;


-- 13
select n_header as header, n_dt from news where YEAR(n_dt) = '2011'
union all
select r_header as header, r_dt from reviews where YEAR(r_dt) = '2011';


-- 14
select nc_name from news_categories left join news 
on news_categories.nc_id = news.n_category
where n_id is null
UNION ALL
select rc_name from reviews_categories left join reviews 
on reviews_categories.rc_id = reviews.r_category
where r_id is null;


-- 15
select n_header, n_dt from news left join news_categories
on news_categories.nc_id = news.n_category
where nc_name='Логистика' AND year(n_dt)='2012';


-- 16
select year(n_dt) as year, count(n_id) from news group by year;


-- 17
select b_url, b_id from banners 
where b_url in (select b_url from banners group by b_url having count(b_url)>=2);


-- 18
select p_name, b_id, b_url from pages join m2m_banners_pages using (p_id) join banners using(b_id)
where p_parent=1;


-- 19
select b_id, b_url, b_click/b_show as rate from banners
where b_pic is not null
order by rate desc;


-- 20
select header, minpdate as 'date' from 
((select n_header as header, n_dt as minpdate from news order by n_dt asc limit 1) union
(select r_header as header, r_dt as minpdate from reviews order by r_dt asc limit 1)) as minpdates
order by minpdate asc limit 1;


-- 21
select b_url, b_id from banners 
where b_url in (select b_url from banners group by b_url having count(*) = 1);


-- 22
select p_name, count(b_id) as banners_count from pages
left join m2m_banners_pages using (p_id)
group by p_name
order by banners_count desc, p_name asc;


-- 23
(select n_header as header, n_dt as minpdate from news order by n_dt desc limit 1) union
(select r_header as header, r_dt as minpdate from reviews order by r_dt desc limit 1);


-- 24
select b_id, b_url, b_text from banners
where length(b_text) > 0 and locate(b_text, b_url) > 0;


-- 25
select p_name from 
pages right join m2m_banners_pages using (p_id) left join banners using (b_id)
order by  b_click/b_show desc limit 1;


-- 26
select AVG(b_click/b_show) from banners where b_show >0;


-- 27
select AVG(b_click/b_show) from banners where b_pic is null;


-- 28
select count(b_id) as 'COUNT' from
pages right join m2m_banners_pages using (p_id) left join banners using (b_id)
where p_parent is null;


-- 29
select b_id, count(p_id) as 'COUNT' from
banners right join m2m_banners_pages using(b_id)
group by b_id
order by 'COUNT' desc limit 1;


-- 30
select p_name, count(b_id) as 'COUNT' from
pages right join m2m_banners_pages using (p_id)
group by p_name
order by 'COUNT' desc limit 1;