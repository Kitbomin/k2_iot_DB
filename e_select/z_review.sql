### e_select >> z_review

# 1. DDL vs DML

# 1) DDL(Data Definition Launguage)
# : 데이터 베이스의 구조를 정의함
# - CREATE, ALTER, DROP, TRUNCATE

# 2) DML (Data Manipulation Language)
# : 데이터 조작(CRUD)
# - INSERT, SELECT, UPDATE, DELETE

# 2. SELECT 문의 기본 구조
/*
	1. SELECT 
			컬럼명
            1) 여러개 나열시, 콤마로 구분
            2) 모든 컬럼을 조회할 때는 * 사용 -> 테이블 정의시 작성되는 컬럼 순서대로 출력
            3) 조회 시의 컬럼 별칭 지정 가능: AS 키워드 작성(+ 생략 가능함)
    2. FROM
			조회할 테이블 명
    3. WHERE
			조건식
            cf) UPDATE, DELETE는 where문 없이 실행 불가능 
    4. GROUP BY
			그룹 기준 (그룹화를 하기 위해선 묶일 수 있는 데이터만 조회 가능) -> 나이는 그룹화 되는데 이름은 그룹화 안됨
    5. HAVING
			그룹 조건(반드시 그룹화 된 이후 사용)  
    6. ORDER BY
			정렬 기준
            1) 기본값(생략 시) - ASC (오름차순)
            2) 작성 필수 - DESC (내림차순) 
					cf) DESC -> 테이블 구조 출력 하는 키워드랑 이름이 겹침. 주의할 것
                    cf) SHOW DATABASE -> 데이터베이스 목록 조회 
    7. LIMIT
			출력 튜플 개수 제한 
            +) offset : 시작 행 지정 가능 (0부터 시작)

*/

/*
	3. SELECT문 실행 순서 
    
    1) FROM			: 조회할 테이블 선택
    2) WHERE		: 조건에 맞는 행 필터링
    3) GROUP BY		: 조건에 맞는 데이터 그룹화 
    4) HAVING		: 그룹화 될 조건 필터링 
    5) SELECT		: 거기서 볼 데이터 선택
    6) ORDER BY		: 그 데이터를 어떻게 정렬 시킬건지
    7) LIMIT 		: 그 데이터 어디까지 볼건지
    
    +) DISTINCT : 해당 컬럼에서 중복되는 데이터를 제거하고 닥 하나만 남김 

*/

/*
	WHERE 절 연산자 정리
    
    1) 비교 연산자 : 값을 비교함
			- 부등호, =(일치), !=(불일치)
	
    2) 논리 연산자 : 조건 연결
			- AND, OR, NOT
            
	3) NULL 체크 : NULL 여부를 확인함
			- IS NULL, IS NOT NULL 
            
	4) 범위 연산자	: A 이상, B 이하의 범위
			- BETWEEN A AND B (숫자형, 날짜형에 주로 쓰임)
    
    5) 목록 연산자	: 여러 값들 중 포함여부 
			- IN (값1, 2, 3....)
            
	6) 패턴 연산자	: 와일드카드(_, %) 로 문자열 검색
			- LIKE '_a%' 
            
	7) 집합 연산자	: 결과 집합을 병합 / 비교 함
            - UNION 	합집합
            - INTERSECT	교집합
            - EXCEPT	차집합
            
            - 특징) MySQL은 UNION만 지원함 
*/

use korea_db;

-- 2024년 회원 중 이름에 'ji' 이 들어간 회원을 조회 --
-- name과 area_code 컬럼은 각각 '회원 이름' , '지역 코드' 로 컬럼명 조회

SELECT 
	name AS '회원 이름', area_code AS '지역 코드' 
FROM 
	members
WHERE 
	year(join_date) = '2024' AND name LIKE '%ji%' ; 












