### c_ddl >> b_ddl01

# --- 데이터베이스 생성 ---
# 1. 생성(CREATE)
CREATE DATABASE dtatbase_name;
DROP database dtatbase_name;
# 위 두개의 실행문은 여러번 실행할 경우 에러 발생

# 이를 방지하기 위한 키워드
# +) if[not] exists 옵션
# : 데이터베이스의 유무를 확인하고 오류를 방지하는 sql 문법 => 존재할 때, 또는 존재하지 않을 때 실행됨

CREATE DATABASE IF NOT EXISTS database_name; # 존재하지 않을 때 > 생성
# 1 row(s) affected, 1 warning(s): 1007 Can't create database 'database_name'; database exists

DROP DATABASE IF EXISTS database_name; # 존재할 때 > 삭제
# 0 row(s) affected, 1 warning(s): 1008 Can't drop database 'database_name'; database doesn't exist

# 2. 선택(USE)
# : 데이터베이스 선택시 이후 모든 SQL 명령어가 선택된 DB 내에서 실행됨
# - GUI로 Navigator > Schemas > 스키마명 더블클릭과 동일한 명령

USE database_name;

create database if not exists example;
use example;

# 3. 삭제(DROP)
# : 데이터베이스 삭제, 해당 작업은 실행 후 복구할 수 없음 -> 신중히 실행해야함
DROP DATABASE database_name;

# 4. 데이터 베이스 목록 조회
# : 해당 SQL 서버에 존재하는 모든 DB(스키마) 목록을 확인할 수 있음
SHOW DATABASES;

# 스키마는 뭘 수정한다는 개념이 없음

# --- 테이블 ---
# 1. 생성
use example;
CREATE TABLE student (
# 테이블 생성 시 DB 명은 필수 X
# > USE 명령어를 통해 DB 지정이 되어있는 경우 생략 가능함
# > 오류 방지를 위해 작성 권장됨
	student_id int primary key,
    name varchar(100) not null,
    age int not null,
    major varchar(100)
);

# 2. 테이블 구조 조회(DESCRIBE, desc) 
# : 정의된 컬럼, 데이터 타입, 키, 정보(제약조건) 등을 조회
# - describe 테이블명;
# - desc 테이블명;

# cf) 테이블 구조
# Field: 각 컬럼의 이름
# Type: 각 컬럼의 데이터 타입
# Null: Null(데이터 생략, 비워짐) 허용 여부
# Key : 각 컬럼의 제약사항
# Default: 기본값 지정
# Extra: 제약사항(추가옵션)

# --- 테이블 수정 ---
# ALTER TABLE
# : 이미 존재하는 테이블의 구조를 변경하는 데 사용함
# - 컬럼 또는 제약 조건을 추가, 수정, 삭제할 수 있음

# 1) 컬럼
# : 컬럼 추가 (ADD)
# ALTER TABLE 테이블명 ADD COLUMN 컬럼명 데이터타입 기타사항;

ALTER TABLE `student` ADD COLUMN email VARCHAR(255);

describe student;
desc student; # 오름차순 내림차순이랑 햇갈릴 수 있음 -> 주의ㅡ의의ㅡ이으의

# : 컬럼 수정(MODIFY)
# alter table 테이블명 modify column 컬럼명 새로운컬럼_데이터타입 [기타사항];
ALTER TABLE student 
MODIFY COLUMN email VARCHAR(100);

DESC student;
 
# : 컬럼 삭제(DROP)
# alter table 테이블명 drop column 컬럼명;
ALTER TABLE student DROP COLUMN email;
# 테이블 수정 시 column 키워드 생략 가능
# add, modify, drop
DESC student;

 
# --- 테이블 데이터 삭제(초기화) ---
# : TRANCATE
# : 테이블의 구조는 그대로 두고, 내부의 모든 데이터를 삭제(초기 상태로 되돌림)
truncate table student;

desc student;


# if exists / if not exists
# >> 선택적 키워드, 오류 방지 키워드










