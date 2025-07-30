### e_review 

USE korea_db;

/*
	지역 별로 GROUP BY
    여성 회원들의 WHERE
    총 구매 금액을 구하되 SUM - total 
    총액이 30,000원 이상인 HAVING total > 30000
    지역만 추출하고
    총액 기준으로 내림차순 정렬 하여 ORDER BY
    상위 3개 지역을 조회 LIMIT
*/


## 쿼리 실행 순서대로 작성 
# 1) FROM + JOIN
# +) 회원 + 구매 내역이 합쳐진 하나의 가상 테이블 생성 (구매 정보가 있는 회원만 조회)
SELECT *  FROM members M 
INNER JOIN 	   purchases P
ON M.member_id = P.member_id;

# 2) FROM + JOIN + WHERE
# +) 조인된 결과에서 여성 회원들 만 필터링 함 
# -) WHERE은 그룹핑 전에 작동, 개별 행에 대해 조건을 적용 시킴 
SELECT *  FROM members M 
INNER JOIN purchases P
ON M.member_id = P.member_id
WHERE M.gender = 'Female';

# 3) FROM + JOIN + WHERE + GROUP BY
# +) 필터링 된 여성 회원 데이터를 지역 코드를 기준으로 그룹화 
SELECT *  FROM members M 
INNER JOIN purchases P
ON M.member_id = P.member_id
WHERE M.gender = 'Female'
GROUP BY M.area_code;
# Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'korea_db.M.member_id' 
# which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
# GROUP BY를 사용한 테이블의 모든 컬럼이 조회됨 -> 그룹화 되지 않는 칼럼들에 대한 데이터 결합 오류 

SELECT 		M.area_code AS '지역코드', SUM(P.amount) '토탈금액', COUNT(distinct M.member_id) '회원 수'  
FROM 		members M 
INNER JOIN 	purchases P
		ON M.member_id = P.member_id
WHERE 		M.gender = 'Female'
GROUP BY 	M.area_code;

# 4) 남은 데이터에 HAVING 조건 부여 -> 그룹화된 데이터에 조건식 적용 
SELECT 		M.area_code AS '지역코드', SUM(P.amount) '토탈금액', COUNT(distinct M.member_id) '회원 수'  
FROM 		members M 
INNER JOIN 	purchases P
		ON M.member_id = P.member_id
WHERE 		M.gender = 'Female'
GROUP BY 	M.area_code
HAVING 		SUM(P.amount) >= 30000;


# + 추가 조건 ORDER BY, LIMIT 
SELECT 		M.area_code AS '지역코드', 
			SUM(P.amount) '토탈금액', 
			COUNT(distinct M.member_id) '회원 수'  
            
FROM 		members M 
INNER JOIN 	purchases P
		ON M.member_id = P.member_id
        
WHERE 		M.gender = 'Male'
GROUP BY 	M.area_code
HAVING 		SUM(P.amount) >= 30000
ORDER BY 	SUM(P.amount) DESC 
LIMIT		3;

