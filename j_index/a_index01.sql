## a_index01

### 인덱스 ###
# : select 문으로 데이터 조회 시, 원하는 데이터를 더 빠르게 찾아주는 도구
# - 데이터 검색 속도를 향상 >> 전체 시스템 성능을 높임 

# EX) 책에서 원하는 단어를 찾을 때 사용하는 '찾아보기 색인 파트'

# 1. 인덱스 종류
# 1) 클러스터형 인덱스
# : 기본키(PK) 설정 시 자동 생성됨
# - 테이블 당 단 하나만 생성 가능함 
# - 자동 정렬 기능 포함: 지정된 열(기본키 컬럼)을 기준으로 자동정렬 됨 
select * from `A` ; 
# => order by 정렬문이 없으면 클러스터형 인덱스를 기준으로 정렬됨 
# EX) 영어사전, 국어사전: 내용을 미리 정렬해놓은 것들 

# 2) 보조 인덱스  
# : 고유키(unique key) 설정 시 자동 생성 
# - 테이블 당 여러 개 생성 가능
# - 자동 정렬 기능을 포함하지 않음
# EX) 일반 서적: 색인(찾아보기) 등의 페이지 번호를 보고 해당 위치로 이동해야 내용 확인 가능 


## 인덱스 사용 예시 ##
create database if not exists idx_db;

use idx_db;

create table table1 (
	col1 int primary key,
    col2 int,
    col3 int 
);

# 인덱스 정보 확인: show index from 테이블 명 
show index from table1;
# Non_unique 
# >> 값이 0: false -> 중복허용이 되지 않는 인덱스 (유일한 값 설정이 되어있어야함) | 값이 1: true -> 중복허용이 됨 

# Key_name: 기본키 설정으로 자동 생성된 인덱스

# Column_name: 인덱스가 부여된 컬럼명 

# Seq_in_index: 인덱스 안에서의 컬럼 순서 
# >> 복합키를 인덱스로 사용하는 복합 인덱스에서 두 개의 컬럼의 순서(우선순위)를 의미 

create table table2(
	col1 int primary key,
    col2 int unique,
    col3 int unique
);

show index from table2;
# Key_name: 열 이름 지정 시 - 보조 인덱스 
#		>> PRIMARY - 클러스터형 인덱스
# Non_unique: 고유키 중복 허용 X
#		Null에 Yes라고 되어있으면 Null값이 허용 됨 


### 인덱스 활용 ###
drop database 인덱스;
create database 인덱스;
use 인덱스;

drop table if exists members, purchases;
create table members (
	mem_id char(8),
    mem_name varchar(10),
    mem_number int,
    address char(2)
);

insert into members
values 
	('IVE', '아이브', 6, '서울'),
	('BLK', '블랙핑크', 4, '부산'),
	('LSF', '르세라핌', 5, '경기'),
	('ASF', '에스파', 4, '경남');

select * from members; -- 클러스터형 인덱스가 없는 경우(PK값이 없는 경우) : 데이터 삽입 순서대로 출력됨 

show index from members;
-- 기본키 설정 (클러스터형 인덱스 생성)--
alter table members
add constraint primary key(mem_id);

select * from members; -- mem_id를 기준으로 오름차순 정렬되어있음 
show index from members;

insert into members
	values ('H2H', '하츠투하츠', 7, '대전');
select * from members; -- 인덱스 저장 후 추가 데이터 삽입 시: 정렬 기준에 따라 자동 정렬 됨 

-- 정렬되지 않는 보조 인덱스 --
# : 고유 키 지정 시 생성 / 테이블 당 여러개 가능 / 정렬 X 

drop table if exists members;
create table members (
	mem_id char(8),
    mem_name varchar(10),
    mem_number int,
    address char(2)
);
insert into members
	values 
		('IVE', '아이브', 6, '서울'),
		('BLK', '블랙핑크', 4, '부산'),
		('LSF', '르세라핌', 5, '경기'),
		('ASF', '에스파', 4, '경남');
        
select * from members;
show index from members;

alter table members
add constraint unique(mem_id);

select * from members;
show index from members;

insert into members
	values ('H2H', '하츠투하츠', 7, '대전');

select * from members;   -- 데이터 삽입 순서가 유지 
show index from members;

### 보조 인덱스의 경우 정렬되지는 않지만 성능적인 향상이 이루어짐 ### 








