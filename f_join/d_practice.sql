### d_practice  

--  구매 금액이 가장 높은 회원의 정보와 총 구매 금액
SELECT 
	M.member_id , M.name, M.grade, SUM(P.amount) AS total_amount
FROM members M 
	INNER JOIN purchases P 
	ON M.member_id = P.member_id
GROUP BY M.member_id 
ORDER BY total_amount DESC
LIMIT 1;

SELECT  M.member_id , M.name, M.grade, SUM(P.amount) AS total_amount
FROM members M JOIN purchases P 
ON 		M.member_id = P.member_id
GROUP BY 	M.member_id 
ORDER BY 	total_amount DESC
LIMIT 1;

USE baseball_league;

## JOIN 예제 ##

SELECT * FROM players;
SELECT * FROM teams;

# 1. 내부 조인 
# 1) 타자인 선수오 ㅏ해당 선수가 속한 팀 이름 가져오기 
#  - plauers 테이블에서 선수 이름을 , teams 테이블에서 팀 이름을 가져올거임 
SELECT 
	P.name , T.name , P.position
FROM players P    -- 기준 테이블 
	INNER JOIN teams T
		ON P.team_id = T.team_id 
WHERE 
	P.position = '타자';
    
# 2) 1990년 이후 창단된 팀의 선수 목록 가져오기 
SELECT P.name , T.name 
FROM teams T
	INNER JOIN players P
	ON T.team_id = P.team_id 
WHERE T.founded_year >= 1990;

# 2. 외부 조인 
# 1) 모든 팀과 그 팀에 속한 선수 목록 가져오기 
SELECT T.name team_name , P.name players_name
FROM teams T
	LEFT JOIN players P
    ON T.team_id = P.team_id;
    
# +) 타자 가져오기 
SELECT T.name team_name , P.name players_name
FROM teams T
	LEFT JOIN players P
    ON T.team_id = P.team_id
WHERE P.position = '타자';
    
    
# 2) 모든 선수와 해당 선수가 속한 팀 이름 가져오기
SELECT
	P.name players_name , T.name team_name
FROM players P
LEFT JOIN teams T
ON P.team_id = T.team_id;




























