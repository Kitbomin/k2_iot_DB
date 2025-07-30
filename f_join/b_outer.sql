### b_outer

/*
	-- 2. 외부 조인 (OUTER JOIN) --
		: 한쪽 테이블에만 존재하는 데이터 까지도 결과로 포임하는 조인 방식 
		: 조건에 일치하지 않아도 기준 테이블의 행은 모두 출력됨
			- 일치하지 않는 열은 NULL로 채워짐 => 어쨌건 다 출력 됨 
			
	--- 외부 조인 종류 ---
    1) LEFT OUTER JOIN
		- 기준 테이블의 위치(왼쪽, FROM 뒤의 테이블)
        - 포함 범위(왼쪽 테이블의 모든 행 + 매칭된 오른쪽 테이블)
        
    2) RIGHT OUTER JOIN
		- 기준 테이블의 위치(오른쪽, JOIN 뒤의 테이블)
        - 포함 범위(오른쪽 테이블의 모든 행 + 매칭된 왼쪽 테이블) 
    
    3) FULL OUTER JOIN 
		- 양쪽 모두, 두 테이블의 모든 행이 출력
        - MySQL에서는 직접 지원하지 않음 ...
        
        
	-- 기본 문법 구조 -- 
    SELECT 	열 목록
    FROM 	기준 테이블 AS 별칭 
		LEFT | RIGHT OUTER JOIN 조인할 테이블 AS 별칭
        ON 조인 조건
	[WHERE ... ]
    
    cf) OUTER 키워드 생략 가능 - LEFT JOIN, RIGHT JOIN 으로도 사용 가능 
    
*/

# 외부 조인 예제 1 #
# : 왼쪽 테이블의 모든 레코드오 ㅏ오른쪽 테이블의 매칭되는 레코드만 포함
SELECT 
	M.member_id, M.name, P.product_code, M.area_code
FROM members M -- 모두 출력됨
LEFT OUTER JOIN 
		purchases P
ON M.member_id = P.member_id;

# 외부 조인 예제 2#
# : 오른쪽 테이블의 내용을 모두 출력 
SELECT
	M.member_id, M.name, P.product_code, M.area_code
FROM
	purchases P
RIGHT OUTER JOIN
	members M
ON M.member_id = P.member_id;

# 외부 조인 예제 3#
SELECT M.member_id, P.product_code, M.name, M.contact
FROM
	members M -- 기준 테이블 
    LEFT JOIN purchases P 
    ON M.member_id = P.member_id
WHERE P.product_code IS NULL;

# cf) MuSQL은 FULL OUTER JOIN을 지원하지 않음 => UNION으로 대체됨 

## 외부 조인 사용 시 유의 점 ##
# 1) 기준 테이블의 위치를 잘 파악해야함
#		- LEFT : 왼쪽 테이블이 기준 (FROM 절에서 선언되는 테이블)
# 2) OUTER 키워드 생략 가능 
# 3) IS NULL 조건: 외부 조인 후 일치하지 않는 데이터를 찾을 때 사용 (차집합) 







