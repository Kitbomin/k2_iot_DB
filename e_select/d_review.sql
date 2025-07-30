### e_select >> d_review

# korea_db 데이터베이스의 members, purchases 테이블 기반 
# > select ~ from ~ where 구문 전체 복습 

USE korea_db;

# 1) 이름을 기준으로 정렬 
SELECT * FROM members ORDER BY name;
SELECT * FROM members ORDER BY name ASC;
SELECT * FROM members ORDER BY name DESC;

# 2) 3번째 레코드부터 2개의 행 조회
SELECT * FROM members LIMIT 2 OFFSET 2;
SELECT * FROM members LIMIT 2, 2; # offset 대신 , 로도 대체 가능 

# 3) 포인트가 가장 높은 상위 3명의 회원 조회
SELECT * FROM members ORDER BY points DESC LIMIT 3;

# 4) 서로 다른 등급 목록 조회 (= 중복되는 등급 생략) 
SELECT DISTINCT grade FROM members;

# 5) 지역 별 최대 포인트 조회 
SELECT area_code, MAX(points) AS max_points FROM members GROUP BY area_code;

# 6) 성별 (gender) 에 따른 평균 포인트 조회 
SELECT gender, AVG(points) FROM members GROUP BY gender;

# 7) 평균 포인트가 250 이상인 등급만 조회 
SELECT grade, AVG(points) FROM members GROUP BY grade HAVING AVG(points) >= 250;

# 8) 등급별 최소 포인트가 100이상인 그룹 조회
SELECT grade, MIN(points) min_points FROM members GROUP BY grade HAVING MIN(points) >= 100;













