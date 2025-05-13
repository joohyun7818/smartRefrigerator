use projweb1;
show tables;

-- 레시피 필요 재료 테이블
drop table if exists recipe;
drop table if exists ingredients;
drop table if exists myFridge;
create table recipe (
	rid	       int,
    iName	   varchar(30),
    quantity   varchar(30)
);
CREATE TABLE ingredients (
    iName VARCHAR(30), 
    iNum INT
);
create table myFridge (
	email   varchar(40),
	iName   varchar(30),
    primary key (email, iName)
);

-- 여기부터 자바로 데이터 파싱 & 주피터로 데이터 가공 이후 실행




desc good_recipe;
desc ingredients;
select * from good_recipe;
select * from ingredients;


-- 내 냉장고 재료 테이블
-- 임의로 데이터를 넣어 레시피에 필요한 재료 퍼센티지 구하기
desc myFridge;
select * from myFridge;

insert into myFridge values('a1@naver.com', '소고기');
insert into myFridge values('a1@naver.com', '고추장');
insert into myFridge values('a1@naver.com', '소금');
insert into myFridge values('a1@naver.com', '후추');

select rid, count(good_recipe.iName) as iCnt, count(email), count(email)/count(good_recipe.iName)*100 as p
from good_recipe LEFT OUTER JOIN myFridge
on good_recipe.iName = myFridge.iName
group by (rid)
order by p desc;

drop view if exists userView;
create view userView as select * from myFridge where email = 'a1@naver.com';
select rid, count(u.email)/nullif(count(gr.iName), 0)*100 as p, Max(rp.image) as image, Max(rp.pName) as pName
from rProcess as rp 
LEFT OUTER JOIN good_recipe as gr 
on rp.pid = gr.rid 
LEFT OUTER JOIN userView as u 
on gr.iName = u.iName 
group by gr.rid 
order by p desc;
