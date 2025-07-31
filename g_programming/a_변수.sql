### g_programming >> a_변수

USE market_db;

# 테이블명의 단수, 복수 지정은 일관성이 중요함 
SELECT * FROM member;
SELECT * FROM buy;


/*
	1. 변수 
     : 데이터를 저장할 수 있는 임시 저장 공간 
     - SQL 에서는 간단한 데이터 연산, 조건 비교, 동적 쿼리 등에 사용됨 
     
	1) 변수 선언 규칙
		: = (등호) 를 기준으로 우항의 데이터를 좌항의 변수에 저장함 
			>> SET @변수명 = 데이터;
            
	2) 변수 값 출력 
			>> SELECT @변수명; 
	
    cf) SQL의 변수 특징 
		1) MySQL 워크벤치 시작 시 유지 , 종료 시 사라짐 (진짜 임시 저장임) 
        2) SQL은 비절차적 언어임 -> 원하는 구문을 따로따로 실행해야함 -> <변수 선언문 실행 >> 변수 출력문 실행은 따로 해야함>  
*/

-- SQL 변수 사용 예제 -- 
# 변수 선언
SET @myVar1 = 5;
SET @myVar2 = 3.14; 

SELECT @myVar1;
SELECT @myVar2; -- 변수 초기화문을 실행하지 않으면 null 값이 출력됨 

# 테이블 조회 시 변수 사용 
SELECT * FROM member;

# 키가 166 이상인 그룹명 출력 
SET @txt = '가수 이름';
set @height = 166;
set @limitNumber = 1;

select @txt , mem_name , height
from member
where height > @height;
-- limit @limitNumber; Error Code: 1064. You have an error in your SQL syntax; 
-- check the manual that corresponds to your MySQL server version for the right syntax to use near '@limitNumber' at line 4
# >> limit 키워드에는 제한 수의 값을 변수로 사용할 수 없음 

-- 동적 프로그래밍을 사용한 변수 사용 --
# prepare, execute

# cf) prepare: SQL문을 실행시키지 않고 준비시킴
# 		>> ? 키워드를 사용해 코드 작성 시 값이 채워지지 않지만, 실행 시에는 채워지는 코드 작성 가능 
#	  execute: prepare 코드를 실행시켜줌 

# PREPARE 실행시킬 문장명 (코드 블럭명)
# FROM '실제 SQL문' ;

prepare mySQL 
from 'select * from `member` order by height limit ?';
-- 0 row(s) affected Statement prepared => execute만 던지면실행시킬 준비가 되었다. 

# EXECUTE 실행시킬 문장명 using 변수명;
#		>> using 뒤의 변수값이 ? 키워드으ㅔ 대입됨 

set @count = 3;
execute mySQL using @count;

# set		 : 변수 선언 (+ 변수명 앞에 @ 사용)
# select 변수명: 변수값 출력 
# prepare	 : 쿼리 준비(실행 X)
# execute	 : 준비된 쿼리 실행 
# ?			 : 실행 시 채워질 자리(플레이스 홀더)
# using 	 : 플레이스 홀더에 넣을 값 지정 








  









