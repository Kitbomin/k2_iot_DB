# b_select

# select A from B where C;

/*
	select 		A
    from 		B
    where 		C
    group by	D
    having 		E
    order by 	F
    limit		G
*/

/*
	4. GROUP BY
    : 그룹으로 붂어주는 역할
    - 여러 행을 그룹화 해서 집계 함수를 사용해 데이터 단일화에 주로 사용함 
	
    cf) 집계함수: 그룹화된 데이터에 대한 계산을 해줌
		- MAX(), MIN(), AVG(), SUM(), ...
        - COUNT() : 행의 수를 반환
        - COUNT(DISTINCT): 중복값을 하나만 반환해 행의 수를 반환
*/

select * from members
GROUP BY grade;
# Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'korea_db.members.member_id' 
# which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
# >> 등급별로 데이터를 그룹화 할 때 결합되지 않는 데이터 까지 조회하는 경우 발생하는 오류

select name, grade from members
GROUP BY grade;
# Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'korea_db.members.name' 
# which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

select grade from members
GROUP BY grade;

# cf) 집계함수는 그룹화된 영역 내에서 각각 계산 해줌
# 1) 등급별 회원 수 카운트
select grade, COUNT(*) from members
GROUP BY grade;

# 2) 지역별 평균 포인트 계산
select 
	area_code, AVG(points) -- 평균값은 실수 반환
from 
	members
GROUP BY 
	area_code;


/*
	5. HAVING
    : GROUP BY와 함께 사용해야함
		그룹화 된 결과에 대한 조건 지정
	- WHERE 절과 유사 BUT 그룹화 된 데이터에 대한 조건 지정
*/


# 총 인원이 2명 이상인 등급 조회
select grade, COUNT(*) from members
GROUP BY grade
HAVING count(*) >= 2;


# 지역 평균 포인트가 200이 넘는 지역 조회
select 
	area_code, AVG(points)
from 
	members
GROUP BY 
	area_code
HAVING avg(points) > 200;


/*
	6. ORDER BY
    : 데이터 정렬
    - 결과의 값이나 개수에 영향을 미치지 않음
    - 기본값: ASC(Ascending 오름차순) 
			DESC(dexcending 내림차순) 
*/

select * from members; -- 데이터 삽입 순서대로 정렬(auto_increment PK 값에 따라 정렬됨)

select * from members
ORDER BY
	join_date; # 과거순 정렬
    
select * from members
ORDER BY
	name DESC; # 이름 뒷 순 정렬
    
    
# cf) 정렬된 데이터를 기반으로 추가 정렬(콤마로 정렬 상태 나열)
select * from members
ORDER BY
	grade DESC;
    
select * from members
ORDER BY
	grade DESC, points DESC;
    
/*
	7. LIMIT
    : 출력하는 개수를 제한 (반환되는 행의 수를 제한)
    
    LIMIT 행 수 (offset 시작행)
    - 첫번째 행의 기본값이 0
*/

select * from members
LIMIT 5;

select * from members
LIMIT 5 OFFSET 2; -- offset 2: 세번째 행부터 출력(인덱스 체계 생각하면 됨)

select * from members
order by
	grade desc
LIMIT 5;

/*
	cf) DISTINCT (별개의, 뚜렷한)
    : 중복된 결과를 제거함 
    - 조회된 결과에서 중복된 데이터를 1개만 남기고 생략해 반환
	
    조회할 열 이름 앞에 DISTINCT 키워드 사용
*/

select area_code from members;

select DISTINCT area_code from members;
select DISTINCT grade from members;




