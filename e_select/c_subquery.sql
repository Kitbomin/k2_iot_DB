### e_select >> c_subquery

/*
	=== 서브쿼리 (subquery) === 
    : 메인 쿼리 내부에서 실행 되는 하위 쿼리(중첩 쿼리)
    - () 안에 작성하여 필요한 값을 먼저 추출한 뒤 메인 쿼리에 필요한 데이터를 동적으로 제공해주는 역할을 함
    
    === 특징 ===
    1) SELECT, FROM, WHERE, .. 다양한 곳에서 사용 가능 
    2) 하나의 값(단일 행) 또는 여러 값(다중 행) 반환 가능
    
    === 필요성 ===
    ? 어떤 사람의 포인트가 가장 많을지 
    ? 평균보다 높은 포인트를 가진 사람은 누구일지
		>> 한번에 구할 수 없고, 값을 두번 나누어서 찾는 경우임 

*/

# 1. 서브 쿼리 예시 
# 	>> Bronze 등급이 아닌 회원의 이름과 등급 보기
#      1) 서브쿼리 없이 작성 
SELECT name, grade FROM members WHERE grade != 'Bronze' ;
#	   2) 서브쿼리 사용 작성
SELECT name, grade FROM members WHERE grade NOT IN (
	SELECT grade 
    FROM members 
    WHERE grade = 'Bronze' 
);
# 해당 쿼리는 브론즈를 먼저 뽑고, 해당 데이터를 제외하고 출력 함

SELECT name, grade FROM members WHERE grade IN ('Silver', 'Gold', 'Platinum', 'Diamond');

-- (현재 예시)서브쿼리 사용 vs 서브쿼리 미사용 --
# 서브 쿼리 없이 사용 ( != 'Bronze')
# 	: 'Bronze' 라는 값을 직접 비교 함 
#		- 정적인 조건에서 사용됨 (고정된 값) 
#		- 유연성이 낮음 -> 'Bronze' 외의 다른 등급이 생기거나 이름이 바뀌면 수정을 해야함 

# 서브 쿼리 사용 (동적 비교)
# 	: 서브쿼리로 먼저 'Bronze'를 찾아서 해당 등급을 제외한 회원만 보여주는 방식 
#		- 서브쿼리를 통해 제외할 대상을 동적으로 구해오는 방식 
#		- 동적인 조건에서 사용됨 (유동적으로 변하는 값) 
#		- 유연성이 높음 

# 차이점 
# > 조건이 단순하고 고정되는 데이터		: 빠르고 간단함 (서브쿼리 없이)
# > 조건이 복잡하거나 동적으로 바뀌는 데이터 : 더 유연하고 안전 - NOT IN (서브쿼리 있이)


SELECT * FROM members; #
SELECT * FROM purchases; # 구매 ID(PK), 구매 회원 ID(FK), 상품코드, 구매일, 가격, 수량 

# == 서브쿼리가 꼭 필요한 경우 == 
SELECT member_id FROM purchases;

# 1) purchases 멤버중 구매 이력이 없는 회원 조회 
SELECT DISTINCT member_id FROM purchases;

SELECT name, member_id
FROM members 
WHERE member_id NOT IN (
	-- 서브쿼리 값이 동적으로 바뀔 수 있음 --
	SELECT DISTINCT member_id FROM purchases
);

# 2) 가장 포인트가 높은 회원을 조회 
SELECT name, points FROM members WHERE points = (
	-- 동적으로 가장 높은 포인트 점수를 계산해서 그 값과 일치한 레코드를 조회 
    -- 항상 최신의 최대값 반영 가능 
    SELECT MAX(points) FROM members 
);

# 3) 평균보다 높은 포인트를 가진 회원 조회 
SELECT name, points FROM members WHERE points > (
	SELECT AVG(points) FROM members
);


# 4) 구매 금액이 가장 높은 회원 조회
# 4-1) 구매금액이 가장 높은 회원의 id 조회
SELECT member_id FROM purchases GROUP BY member_id ORDER BY SUM(amount) DESC;

# 4-2) 가장 높은 회원의 데이터만 뽑아오기
SELECT member_id FROM purchases 
GROUP BY member_id 
ORDER BY SUM(amount) DESC 
LIMIT 1;

# 4-3) 위의 서브쿼리를 사용해 회원 조회
SELECT member_id, name, points FROM members WHERE member_id = (
	SELECT member_id FROM purchases 
	GROUP BY member_id 
	ORDER BY SUM(amount) DESC 
	LIMIT 1
);

# >> purchases에서 회원별 구매 총액을 계산하고 가장 높은 사람 1명만 추출 -> LIMIT, ORDER BY를 사용한 서브쿼리 

### 서브쿼리: 어떠한 범위를 제외하거나, 동적인 데이터 계산에 필수 
# +) 집계, 조건 비교, 연관 데이터 추출에서도 사용됨 


 
