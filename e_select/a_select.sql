### e_select >> a_select

/*
	=== select(선택하다, 조회하다) ===
    : DB는 '어떻게' 가져오는 것보다 '무엇을' 가지고 오는지가 중요함
		>> '무엇을' 선택할 것인지 결정하는 키워드 - select
        
	### select 문의 기본 구조('작성순서') ###
    1. select 컬럼명(열 목록) 	: 원하는 컬럼(열) 지정
    2. from 테이블명 		  	: 어떤 테이블에서 데이터를 가져올 지 결정
    ---
    3. where 조건식 		  	: 특정 조건에 맞는 데이터만 선택(필터링)
    4. group by 그룹화할 컬럼명	: 특정 열을 기준으로 그룹화함
    5. having 그룹 조건		: 그룹화한 데이터에 대한 조건 지정
    6. order by 정렬할 컬럼명	: 결과를 특정 컬럼의 순서로 정렬
    7. limit 컬럼 수 제한		: 반환할 행(레코드)의 수를 제한함
    
    
    cf) DB 내부에서 실제 실행 순서
    FROM > JOIN(추가 테이블 데이터 가져옴) > WHERE(조건 필터링) > GROUP BY > HAVING > SELECT > ORDER BY > LIMIT  
    
*/

use korea_db;

## 1. 기본 조회
# select 컬럼명 from `데이터베이스명` . `테이블명`
select name from `korea_db`.`members`;
# > 정렬하지 않고 조회시 데이터 입력 순서대로 출력

## 2. 전체 컬럼 조회
select * from `korea_db`.members;   -- 회원 테이블
select * from `korea_db`.purchases; -- 구매목록 테이블

# cf) 두개 이상의 컬럼 조회시, 콤마로 구분해 나열
SELECT
	`member_id`, `name`, `contact`
from
	`members`;

# cf) alias 별칭 부여 조회 (as 키워드)
# 별칭을 부여하지 않을 경우 테이블 생성 시 지정한 컬럼명으로 조회됨
# - 컬럼명이 변경되는 것이 아니라 조회 당시의 테이블에 쓰이는 이름임
# - 공백 사용 시 따옴표로 반드시 지정해야함

SELECT
	`member_id` as 고유번호, `name` as '회원 이름', `contact` as '회원 연락처'
from
	`members`;


## 2. 특정 조건에 부합하는 데이터 조회
# : select A from B where C (A: 컬럼명, B: 테이블명, C: 조건식 - 연산자 사용)

select 
	`member_id`, `name`, `points`
from
	`members`
where
#	조건절에는 true/false 를 반환하는 연산자를 주로 사용
	points > 200;


# 1) 관계 연산자
# : 이상, 이하, 초과, 미만, 일치(=), 불일치(!=)
select * from members
where name = 'Minji';

# 2) 논리 연산자
# : AND, OR, NOT 
# : 여러 조건을 조합해 데이터 조회가 가능함

# AND - 모든 조건이 참일 경우
select * from members
where area_code = 'Jeju' AND points >= 400;

# OR - 조건 중 하나라도 참일 경우
select * from members
where area_code = 'Busan' OR area_code = 'Seoul';

# NOT - 조건이 거짓일 때
select * from members
where NOT area_code = 'Busan';

# 3) NULL 값 연산
# : 주의점) 직접적인 연산이 불가능함
select * from members where points = null; 
# cf) null은 '값이 없음' 을 나타냄: 그 어떤 값과도 비교하거나 연산이 불가능함 
# 		>> 그래서 is null, is not null 연산자 사용 -> null 여부 확인 가능

# A is null => null인 경우 true, 아닌 경우 false
# A is not null => null인 경우 false, 아닌경우 true

select * from members 
where 
	points IS NULL; 
    
select * from members 
where
	points IS NOT NULL;

# 4) BETWEEN A AND B연산자
# : A 와 B 사이의 값을 반환
# - 숫자형 데이터, 날짜형 데이터에 주로 사용됨
select * from members 
where
	points BETWEEN 200 AND 400; -- 이상, 이하에 대한 개념 내포
    
select * from members 
where
	join_date BETWEEN '2021-12-31' AND '2022-01-04';
    
    
# 5) IN 연산자
# : 지정할 범위의 문자 데이터를 나열
# - 지정된 리스트 중에서 일치하는 값이 있으면 true 
select * from members 
where
	area_code IN('Seoul', 'Busan');
# > 문자열 데이터에 대한 OR 식 간소화 방식


# 6) LIKE 연산자
# : 문자열 일부를 검색함

# cf)  와일드 카드 문자
# 	_(언더스코어), % (퍼센트)
# _ : 하나의 기호가 한 글자를 허용 (정확하게 하나의 임으의 문자 공간을 나타냄)
# % : 무엇이든지 허용 (0개 이상의 임의의 문자 공간을 나타냄)

# 시작이 J이고 뒤는 0개 이상의 문자를 검색 -> J% 
select * from members 
where
	name LIKE 'J%';
    
# 시작이 J이고 뒤는 3개의 임의의 문자를 허용검색 -> J_ _ _
select * from members 
where
	name LIKE 'J___';

# 어떤 문자열이든 un 이 포함되어 있는 검색
select * from members 
where
	name LIKE '%un%';
    
# 1개의 임의의 문자 + u + 0개 이상의 임의의 문자 허용 검색 -> 이름의 두번째 글자가 u인 모든 회원 조회
select * from members 
where
	name LIKE '_u%';

# 이름이 4글자인 모든 회원 조회
select * from members 
where
	name LIKE '____';


## 날짜와 시간 조회 ##
# date : 'YYYY-MM-DD'
# time : 'HH:mm:SS'

# 일치, 불일치 (=, !=)
# 기간값 조회 (between A and B)

# cf) 특정 시간 기준 그 이후의 데이터 조회
select * from members 
where
	join_date > '2022-01-02'; # 미래
    
# cf) 날짜나 시간의 특정 부분과 일치하는 데이터 조회
# 날짜: year(컬럼명), month(컬럼명), day(컬럼명)
# 시간: hour(), minute(), second()

select * from members 
where
	year(join_date) = '2024';
    
# cf) 현재 날짜나 시간을 기준으로 조회
# curdate() : 현재 날짜만 반환
# now(); 	: 현재 날짜 + 시간 반환

select * from members 
where
	join_date < curdate();

select curdate();
select now();

select * from members 
where
	join_date < now();
    

	
