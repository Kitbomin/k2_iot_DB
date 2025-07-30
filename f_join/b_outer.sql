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









