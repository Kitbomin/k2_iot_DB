### c_select 폴더 >>> z_practice_question 파일 ###

use `korea_db`;
# members, purchases 테이블 사용

-- 1. 모든 회원의 이름, 연락처, 회원등급을 조회하시오.
SELECT name, contact, grade FROM members;

-- 2. 'SEOUL'에 거주하는 회원의 이름과 회원등급을 조회하시오.
SELECT name, grade FROM members WHERE area_code = 'SEOUL';

-- 3. 회원등급이 'Gold' 이상인 회원의 이름과 가입일을 조회하시오.
SELECT name, join_date FROM members WHERE grade IN( 'Gold', 'Platinum', 'Diamond') ;

-- 4. 2023년도에 가입한 회원의 이름과 가입일을 조회하시오.
SELECT name, join_date FROM members WHERE YEAR(join_date) = 2023;

-- 5. 100포인트 이상을 가진 회원의 이름과 포인트를 조회하시오.
SELECT name, points FROM members WHERE points >= 100;

-- 6. 'Male' 성별의 회원 중에서 'Gold' 등급 이상의 회원을 조회하시오.
SELECT * FROM members WHERE gender = 'Male' AND grade NOT IN ('Bronze', 'Silver') ORDER BY grade DESC ;

-- 7. 최근에 구매한 회원과 구매일을 조회하시오. (가장 최근 구매일 기준 상위 3명)
-- group by, 집계함수, order by, limit
SELECT member_id, purchase_date FROM purchases GROUP BY purchase_id ORDER BY purchase_date DESC LIMIT 3;

SELECT member_id, purchase_date FROM purchases GROUP BY member_id ORDER BY purchase_date DESC LIMIT 3;
# Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated 
# column 'korea_db.purchases.purchase_date' which is not functionally dependent on columns in GROUP BY clause; 
# this is incompatible with sql_mode=only_full_group_by

SELECT member_id, MAX(purchase_date) AS last_purchase 
FROM purchases GROUP BY member_id ORDER BY last_purchase DESC LIMIT 3;


SELECT M.member_id, name, purchase_date 
FROM purchases AS P
INNER JOIN members AS M
ON P.member_id = M.member_id
GROUP BY purchase_id ORDER BY purchase_date DESC LIMIT 3;


-- 8. 회원별로 구매한 총 금액(amount의 합)을 조회하시오.
-- group by, 집계함수
SELECT member_id , SUM(amount) FROM purchases GROUP BY member_id;

SELECT M.name , SUM(P.amount) AS '누적 구매 금액'
FROM members M
INNER JOIN purchases P 
ON M.member_id = P.member_id
GROUP BY P.member_id;


-- 9. 구매 금액이 가장 높은 회원의 정보와 총 구매 금액
SELECT M.member_id , M.name, M.grade, SUM(P.amount) AS total_amount
FROM members M 
INNER JOIN purchases P 
ON M.member_id = P.member_id
GROUP BY M.member_id ORDER BY total_amount DESC
LIMIT 1;