### c_etc 

/*
	3. 상호 조인 (CROSS JOIN)
		: 두 테이블의 모든 조합을 반환하는 조인
			- A CROSS JOIN B 는 A의 각 행과 B의 각 행을 모두 조합 한 결과를 반환 
				> 결과 행 수: A의 행 수 X B의 행 수
        
		cf) ON 절이 필요하지 않음 
				- WHERE 절로 필터링하지 않을 경우 모든 조합이 출력되어 결과량이 많아질 수 있음 
		cf) 더미데이터 생산에 많이 사용됨 
*/

USE korea_db;

# 모든 회원과 모든 구매 정보 조합 #
SELECT M.name, P.product_code, P.amount
FROM members M
	CROSS JOIN purchases P;
    
# 필터 조건과 함께 사용 #
# > 회원의 member_id와 구매의 member_id 가 일치하는 경우 필터링 
# > 내부 조인이랑 같은 결과를 낼거임 
SELECT M.name, P.product_code, P.amount
FROM members M
	CROSS JOIN purchases P
WHERE M.member_id = P.member_id;    
    
    
/*
	4. 자체 조인(SELF JOIN)
		: 자기 자신을 기준으로 한 조인 
			- 실제 테이블은 자기 자신 하나지만, 테이블을 두 번 사용하는 것 처럼 별칭을 부여해 조인 함 
*/    

# 같은 지역에 사는 회원끼리 묶기
# area_code 
SELECT A.name AS '회원 1' , B.name AS '회원 2' , A.area_code
FROM members A
	JOIN members B
    ON A.area_code = B.area_code;
    
# 중복 제거 
SELECT A.name AS '회원 1' , B.name AS '회원 2' , A.area_code
FROM members A
	JOIN members B
    ON A.area_code = B.area_code
WHERE A.member_id != B.member_id;    
    
    
# 등급이 같은 회원끼리 묶기 
SELECT A.name '회원 1', B.name '회원 2' , A.grade 
FROM members A 
JOIN members B
ON A.grade = B.grade
WHERE A.member_id < B.member_id;
    
    
    