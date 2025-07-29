### d_dml >>> e_삭제명령어

# DELETE vs DROP vs TRUNCATE

# 1) 공통점: 삭제를 담당하는 키워드
# 2) 차이점
# - delete (DML)
#	: 테이블의 틀은 남겨놓으면서 데이터를 삭제 -> 적은 용량의 데이터나 조건이 필요한 데이터에 사용(WHERE)

# - drop(DDL)
#	: 테이블 자체를 삭제(틀 + 데이터)

# - truncate(DDL)
#	: 테이블의 틀은 남기면서 데이터를 삭제 -> 주로 대용량 데이터 삭제에 사용

-- 대용량 테이블 생성 
USE `company`;
create table `big1` (select * from `world`.`city`, `sakila`.`actor`); 
create table `big2` (select * from `world`.`city`, `sakila`.`actor`);
create table `big3` (select * from `world`.`city`, `sakila`.`actor`);

-- 삭제 명령어 비교
delete from `big1` ; # 5초

drop table `big2`; # 0.031초

truncate table `big3`; # 0.031초




