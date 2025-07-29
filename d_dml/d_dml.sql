## d_dml

# cf) ddl (definition) - DB 정의 언어
# : CREATE, ALTER, DROP, TRUNCATE

/*
	DML(Data Manuipulation Language)
    : 데이터 조작(관리) 언어
    - 데이터를 삽입, 조회, 수정, 삭제(CRUD) 와 근사하게 매칭됨
*/

CREATE database if not exists `company`;
use `company`;

CREATE TABLE `example01` (
	name varchar(100),
    age int,
    major varchar(100)
);

/*
	1. 데이터 삽입(INSERT)
    : 테이블에 행 데이터(레코드)를 입력 
    
    - 기본 형식
    INSERT INTO 테이블명 (열1, 열2, ...) VALUES (값1, 2, 3...);
    
    cf) 테이블명 뒤 열 이름의 나열을 생략할 경우 모든 속성값을 다 넣어야함 
		-> 값 순서는 테이블 정의할 때 입력한 순서대로
		>> name, age, major 순
        
	cf) 전체 테이블의 컬럼순서 & 개수와 차이가 나는 경우 반드시 원하고자 하는 열 이름 나열
*/

# 1) 컬럼명 지정 안되있는것
INSERT INTO `example01`
VALUES 
	('오신혁', 20, 'IT');
    
-- INSERT INTO `example01`
-- VALUES 
	-- ('오신혁', 20);
    -- -> major값이 누락되어 오류 발생

-- INSERT INTO `example01`
-- VALUES 
-- 	('오신혁', 'Cooking', 20);
# Error Code: 1366. Incorrect integer value: 'Cooking' for column 'age' at row 1

# 2) 컬럼명 지정
INSERT INTO `example01` (major, name)
VALUES 
	('Health', '손태경');
    

# 데이터 삽입 시 NULL 허용 컬럼에 값 입력이 이루어지지 않은 경우 -> 자동으로 NULL 값 지정(삽입)

# cf) "auto_increment"
#		: 열을 정의할 때 1부터 1씩 증가하는 값을 입력하는 방식
# 		- insert에서는 해당 열이 없다고 가정하고 입력
#		- 유의사항) 해당 옵션이 지정된 컬럼은 반드시 PK 값으로 지정해야함(하나의 테이블에 한 번만 지정 가능)

CREATE TABLE `example02` (
	# 컬럼명 데이터타입 [primary key] [auto_increment] / 옵션 순서 상관 없음
    id bigint auto_increment primary key,
    name varchar(50)
);

INSERT INTO `example02` (name)
VALUES 
	('최광섭'),
	('정은혜'),
	('정지훈');
    
    
SELECT * FROM example02;

INSERT INTO `example02`
VALUES (null, '김승민');
SELECT * FROM example02;

# cf) auto_increment 최대값 확인
# select max(auto_increment 컬럼명) form 테이블명;
select max(id) from example02;

# cf) 시작값 변경
alter table `example02` auto_increment = 100;

INSERT INTO `example02`
VALUES (null, '박현우');

SELECT * FROM example02;

# cf) 다른 테이블의 데이터를 한번에 삽입하는 구문
# INSERT INTO `삽입받을 테이블` SELECT ~~(조회구문 작성)

create table example03 (
	id int,
    name varchar(100)
);

insert into example03 select * from example02; 
SELECT * FROM example03;


/*
	2. 데이터 수정(UPDATE)
    : 테이블의 내용을 수정하는 구문
    
    - 기본 형식
    UPDATE '테이블명' set 열1=값1, 열2=값2 ... 
    (WHERE 조건);
    
    cf) WHERE 조건이 없는 경우
		: 해당 열(칼럼) 의 데이터가 해당값으로 모두 변경되어버림
        
*/

use company;

update `example02`
set name = '권지애';
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
# To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

select * from example02;

# cf) 실행 중인 세션에서 일시적으로 safe mode를 해제할 수 있음
SET SQL_SAFE_UPDATES = 1; # 1: 모드 사용 | 0: 모드 해제

update example02 set name = "김동후" where id = 1;

select * from example02;

/*
	3. 데이터 삭제(DELETE)
    : 테이블의 데이터를 삭제하기 위한 키워드
    
    - 기본 형태
    DELETE FROM '테이블명' WHERE 조건;
*/

select * from example02;

delete from example02;
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
# To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

set sql_safe_updates = 0;

delete from example02;

select * from example02;

set sql_safe_updates = 1;

delete from `example02` where id = 1;




