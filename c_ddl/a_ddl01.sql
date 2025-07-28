### c_ddl >> a_ddl01

### DDL (Data Definition Language) 문법 정리 ###
# : CREATE, ALTER, DROP, TRUNCATE

-- DB(스키마, Schema) 생성 --
### CREATE: 데이터베이스 생성, 데이터를 저장하고 관리하는 첫 단계
# 기본 형태
# CREATE DATABASE 데이터베이스명;

CREATE DATABASE example; -- 세미콜론 반드시 필요
CREATE DATABASE example2;

CREATE DATABASE example2; -- 같은 이름을 써도 자체적으로 오류는 나지 않음 -> 실행하지 않으면 적용이 안되서
# Error Code: 1007. Can't create database 'example2';
# 데이터베이스 이름은 중복될 수 없음 >> 같은 이름의 DB를 두번 생성하는건 불가능

-- 테이블 생성 --
### CREATE: 테이블 생성, 테이블에 저장될 데이터의 형태와 특성을 정의
# 데이터 타입, 제약조건, 기본값 등의 설정이 가능함
# 기본형태
# CREATE TABLE 데이터베이스.테이블명(
# 		컬럼 1 데이터타입 [선택적 옵션], 
# 		컬럼 2 데이터타입 [선택적 옵션], 
# 		컬럼 3 데이터타입 [선택적 옵션], 
# 		...
# 		컬럼 N 데이터타입 [선택적 옵션] 
# );

CREATE DATABASE school;
CREATE TABLE `school`.`students`( 
	students_id int,		 -- 학생 고유번호 (정수형)
    students_name char(8),   -- 학생 이름 (문자 8자리)
    students_gender char(8)  -- students 학생 성별 (문자 8자리)
);

-- cf) 문자 인코딩 추가 테이블
# : UTF-8 문자 인코딩을 사용해 한글 등의 문자 정보를 올바르게 저장할 수 있도록 설정

CREATE TABLE `students_encoding` (
	students_id int,		 -- 학생 고유번호 (정수형)
    students_name char(8),   -- 학생 이름 (문자 8자리)
    students_gender char(8)  -- students 학생 성별 (문자 8자리)
)
# Error Code: 1046. No database selected Select the default DB to be used by double-clicking its name in the SCHEMAS list in the sidebar.
# DB를 지정하지 않으면 생성 불가함 -> 진짜 대상 스키마를 더블클릭 함...

DEFAULT CHARACTER SET = utf8mb4
# utf8 = 문자까지만 인코딩 || utf8mb4 = 모든 유니코드 문자 저장(이모지, 한자 포함)

COLLATE utf8mb4_unicode_ci; 
-- 정렬 방식(문자열 끼리 비교하고 정렬할 때 어떤 기준으로 할 지 정하는 설정)
# ci => case-insentive : 대소문자 구분하지 않음 (정렬시)

# +) 테이블 명도 중복되면 안됨


-- 데이터베이스 & 테이블 삭제
# DROP : DB와 테이블의 구조, 데이터 전체를 삭제함
# 기본형태
# DROP DATABASE `데이터베이스명`;
# DROP TABLE `데이터베이스명`.`테이블명`;

DROP TABLE `school`.`students`;
DROP DATABASE `school`;
DROP DATABASE `example`;
DROP DATABASE `example2`;
DROP DATABASE `example3`;
# Error Code: 1008. Can't drop database 'example3'; database doesn't exist








