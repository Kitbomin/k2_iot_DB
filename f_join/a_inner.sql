### f_join >>> a_inner 

/*
	=== JOIN(조인, 결합하다) ===
    : 두개 이상의 테이블을 연결하여 하나의 결과 집합을 생성해내는 SQL 기능
		- 테이블 간의 관계를 활용 => 관련 데이터를 결합함 
        - 공통된 열(Column)을 기준으로 연결됨 
        
	1. 조인의 종류 
    
    1) 내부 조인(INNER JOIN) ★
		: 조건에 일치하는 데이터 만 결합함 (교집합) 
			- 정확하게 일치하는 데이터 만 보고싶을 때 사용 
        
    2) 외부 조인(OUTER JOIN) ★
		: 조건이 불일치해도 포함(합집합) (NULL 포함)
			- 빠진 데이터를 확인하거나, 전체 조회 시 사용
            
    3) 상호 조인(CROSS JOIN)
		: 모든 조합에 대한 반환 (곱집합 A테이블 * B테이블) 
			- 두 테이블의 모든 조합을 반환 
            
    4) 자체 조인(SELF JOIN)
		: 자기 자신과의 조인 
			- 자신과 비교하여 상위/하위 관계, 이전/다음 비교 시 사용 
    
*/

/*
	-- 1. 내부 조인 (INNER JOIN) --
		: 2개 이상의 테이블에서 공통된 컬럼의 값이 일치하는 행만 조회 
		: 일치하는 데이터가 없을 시 해당 행은 결과에 포함되지 않음 
			- 1:多 의 관계에서 주로 사용 (1 : N) 
        
		cf) members 테이블 	- purchases 테이블 	(1명의 회원이 여러 구매 기록을 가질 수 있음)
			employees 테이블 	- salaries 테이블 	(1명의 사원이 여러 급여 기록을 가질 수 있음) 
        
	기본형태
    SELECT 		열 목록
    FROM 		기준 테이블(첫번째 테이블) AS 별칭 
		INNER JOIN 조인 테이블(두번째 테이블) AS 별칭 
        ON 조인 조건(결합 조건) 
    [WHERE ~~ ];
    
    cf) INNER 키워드 생략 가능 
		- JOIN: 내부 조인으로 인식함 
    
*/
USE korea_db;

# 내부 조인 예제1 #
# : 특정 회원이 구매한 상품 확인 
SELECT * FROM purchases;

SELECT * FROM purchases
WHERE member_id = 1;

# + 해당 특정 회원의 정보를 포함해 조회 
SELECT P.purchase_id, P.member_id, M.name, M.area_code 
FROM 
	purchases AS P # 보통 별칭은 테이블의 첫 문자를 대문자로 사용 
  INNER JOIN 
	members   AS M
		ON P.member_id = M.member_id
WHERE P.member_id = 1;
# cf) 조인 시 두개 이상의 테이블에서 동일한 열 이름이 존재하는 경우 >> 테이블명(별칭). 열이름 형식으로 어디서 들고오는지 지정해야함 

# 내부 조인 예제 2 #
# : 금액이 2만원 이상인 모든 구매 내역 조회
SELECT * FROM purchases
WHERE amount >= 20000;

# + 회원 이름, 구매 날짜, 금액 
SELECT M.name, P.purchase_date, P.amount
FROM purchases AS P
INNER JOIN members AS M
ON P.member_id = M.member_id
WHERE P.amount >= 20000;

# 내부 조인 예제 3 #
# : 회원 별 총 구매 금액을 내림차순 정렬 
SELECT M.name, SUM(P.amount) AS total_purchases
FROM members AS M
INNER JOIN purchases AS P
ON M.member_id = P.member_id
GROUP BY M.name
ORDER BY total_purchases DESC;

# 내부 조인 예제 4 #
# : 구매 이력이 있는 회원만 조회

SELECT DISTINCT M.name, M.contact
FROM
	members M
	INNER JOIN purchases P
    ON M.member_id = P.member_id;

# cf) 서브쿼리 (구매 이력이 있는 회원 조회) 
# 위의 예제와 결과는 동일하지만 서브쿼리의 테이블의 데이터 조회는 불가능함 
# 새로운 값을 도출한게 아님 -> 조인이 아니니까.
SELECT name, contact FROM members
WHERE member_id IN (
	SELECT DISTINCT member_id FROM purchases
);
# 이건 테이블에 별칭 부여해도 호출 불가능함 -> 조인이 아니라서 

## 내부 조인 사용 시 주의점 ##
# 1) 동일한 이름의 컬럼 혼동 주의 : 반드시 별칭 지정할 것
# 2) 기준 테이블 선택 			: 주로 1(일) 테이블을 기준으로 조인
# 3) 조인 순서 FROM A JOIN B != FROM B JOIN A (결과는 같지만 기준되는 값이 다름)
# 4) 조건이 일치하지 않는 행은 결과에서 누락됨

## 내부조인 상황 예시 ##
# 1) 회원 + 구매 : 회원이 무엇을 샀는지 분석 시
# 2) 직원 + 부서 : 직원이 어떤 부서에 소속되어 있는지
# 3) 학생 + 성적 : 학생의 성적 관리 
# 4) 주문 + 상품 : 어떤 상품이 주문 되었는지 확인 


















