## b_제약조건

/*
	제약조건(Constraint)
    : 데이터의 정확성, 일관성, 신뢰성, 무결성을 유지하기 위해 DB 시스템을 활용해 강제하는 규칙
		-> 데이터값을 축소시키는 방식
	
    1. 제약조건 사용 목적
		- 무결성 유지
			: 잘못된 데이터 삽입 방지
        - 오류 방지
			: 잘못된 입력, 삭제, 변경 등을 방지
        - 관계 유지
			: 테이블 간의 연결을 확실하게 유지
		
	2. 제약조건의 종류
		1) Primary Key(기본키)
        2) Foriegn Key(외래키, 참조키)
        3) Unique
        4) CHECK 
        5) NOT NULL
        6) DEFAULT
    
*/

/*
	1. PK (Primary Key)
    : 기본키, 각 행을 고유하게 구분하는 역할(레코드 구분의 식별자 역할을 함)
		- 중복될 수 없음(고유성)
        - null 허용이 되지 않음(반드시 유효한 데이터를 포함해야함)
        
        cf) 유일성 제약
			- 하나의 테이블 당 하나의 기본키만 지정 가능함
				> 테이블의 특성을 반영한 열 선택 권장 || PK 컬럼을 따로 생성 권장
                
                EX) members(member_id), books(book_id | isbn)
*/

drop database if exists `example`;

CREATE DATABASE `example`;
USE example;

# 기본키 지정 방법
# 1) 테이블 생성 시 - PK 컬럼에 명시: 컬럼명 데이터타입 PRIMARY KEY, 지정
CREATE TABLE `students` (
	student_id bigint primary key,
    student_id bigint,
    name varchar(100),
    primary key(student_id)
);

# 2) 테이블 생성 시 - 마지막 열에 제약조건 명시: PRIMARY KEY (설정할 컬럼명)
CREATE TABLE IF NOT EXISTS `students` (
    student_id bigint,
    name varchar(100),
    primary key(student_id)
);

desc students;

insert into `students` 
values  (1, '이승아') , 
		(2, '이도경') , 
		(3, '조승범');  

select * from students; # 테이블 내부의 실질적인 데이터를 확인 가능함

-- insert into `students` values (1, '김명진');
# Error Code: 1062. Duplicate entry '1' for key 'students.PRIMARY'	
# >> PRIMARY KEY 는 값의 중복이 불가능해서 나는 오류

# cf) DDL의 수정 키워드 ALTER 
# 	: 테이블 구조의 제약조건 수정 동반

alter table `students` drop primary key;
# 기존 테이블의 기본 키 제약 조건 삭제 시 not null에 대한 제약조건은 사라지지 않음
desc students; 

alter table `students` modify `student_id` bigint null;
# NOT NULL 조건을 없애는 방법
desc students; 

# 	: 기존 테이블의 제약 조건 추가
alter table `students` add primary key(student_id);
desc students;

/*
	2. FK (Foreign Key)
	 : 외래, 참조키
		- 두 테이블 사이의 관계를 연결, 데이터의 무결성 유지를 위함
        - 전제조건) 다른 테이블의 기본키를 참조해 관계를 표현함
		- 두 테이블 간 연결 (RDBMS)
        
	+) 기본 테이블 (기본 키가 있는 테이블)
	+) 참조 테이블 (외래 키가 있는 테이블)
    
    회원(members) - 주문(orders)
    > 고객이 실제로 존재하는 지 확인, 고객과 주문 간의 관계를 명시	
*/

CREATE TABLE `members` (
	member_id bigint primary key,
    name varchar(100)
);

drop table if exists members;

CREATE TABLE `orders` (
	order_id bigint primary key,
    order_date date,
    member_id bigint, -- 주문자 정보
    # 외래키 지정 방법
    # foreign key(참조 칼럼, 현 테이블의 컬럼 명) references 기본테이블(기본컬럼, PK컬럼)
    foreign key (member_id) references `members`(member_id)
);

drop table if exists orders;

insert into `orders`
values
	(1, '2025-07-29', 123);
# Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`example`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`))	0.000 sec


insert into `members`
values
	(123, '김보민');
    
insert into `orders`
values
	(1, '2025-07-29', 123);
    
### 외래키 제약 조건 수정(삭제 + 추가) ###
# cf) 외래키 제약조건 삭제 시 -> 해당 데이터를 참조하는 데이터가 있을 경우 삭제 불가능 함
alter table `orders` drop foreign key member_id;
# Error Code: 1091. Can't DROP 'member_id'; check that column/key exists

truncate table `orders`;

# 1) 제약조건 이름 검색 필수
select constraint_name 
from information_schema.key_column_usage
where table_name = 'orders' and column_name = 'member_id';
# where 조건 내에서 테이블명과 컬럼명을 데이터처럼 사용 : 따옴표로 지정해야함

# 'orders_ibfk_1'

# 2) 참조 테이블의 외래키를 삭제
alter table `orders` drop foreign key orders_ibfk_1;

desc orders;
# MUL: 외래키 지정 시 MySQL이 자동으로  index 생성
# 		- 외래키 삭제 후에도 존재함

select constraint_name 
from information_schema.key_column_usage
where table_name = 'orders' and column_name = 'member_id';
# >> 아무것도 출력되지 않는다면 외래키 제거 완료

# 기존 테이블의 외래키 제약조건 추가
alter table `orders` add constraint foreign key(member_id) references members(member_id); 
desc orders;
# foreign key 설정은 desc 에서 MUL로 표시
desc members;


