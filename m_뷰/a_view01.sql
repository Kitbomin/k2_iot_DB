### m_트랜잭션 >> a_view01

### 뷰 (View) ###
# : 데이터 베이스 개체 중 하나 
# - 하나 이상의 테이블을 기반으로 생성된 '가상의 테이블' 임

# 1) 뷰의 특징 
# > 실제 데이터를 저장하지 않음 
# > SELECT 문의 결과를 저장한 것처럼 작동함 
# > 일반 테이블처럼 SELECT로 조회 가능 
# > 뷰를 통해서 데이터를 보호하거나 단순화 할 수 있음 

# 2) 뷰 VS 테이블 
# View 
# - 데이터 저장을 하지 않음 
# - 필요한 데이터만 보는 용도로 사용됨 
# - 갱신 방식: 기본테이블(참조테이블) 변경 시 자동 반영도미 
# >> CREATE VIEW 뷰명 AS SELECT문 ~ 


# Table
# - 데이터를 직접 저장하고 있음 
# - 데이터 전체 저장 / 관리 용도로 사용됨 
# - 갱신 방식: DML(INSERT, UPDATE, DELETE) 로 직접 조작해야함 
# >> CREATE TABLE 테이블명 (... 테이블 구성 ...)


# 3) 뷰의 종류 
# - 단순 뷰: 하나의 테이블과 연관된 뷰 
# - 복합뷰: 2개 이상의 테이블과 연관된 뷰 -> 여러 테이블의 조인을 포함함 


USE market_db;

SELECT * FROM member;
SELECT * FROM buy;

SELECT mem_id, mem_name, addr FROM member;

/*
	1) 뷰 생성 방법 
    CREATE VIEW 뷰 이름 
    AS 
		SELECT문; 
        
	2) 뷰 접근 방법 
    : SELECT 문 사용 -> 전체 접근, 테이블 조회 처럼 조건식 사용도 가능함 
    SELECT 열 이름 나열 FROM 뷰_이름 [WHERE];
    
    cf) 뷰 이름은 테이블과의 구분을 위해 v_로 시작을 권장함 
*/

CREATE VIEW v_member 
AS SELECT mem_id, mem_name, addr FROM member;

SELECT * FROM v_member;
SELECT * FROM v_member WHERE addr in('서울', '경남');

# 4) 뷰 작동 방식
# 1. 사용자가 뷰에 SELECT 쿼리를 실행
# 2. DBMS가 뷰 내부 SELECT문을 실행 
# 3. 원본 테이블에서 데이터를 가져와 뷰 형태로 반환 
# >> 뷰는 테이블처럼 보이지만, 내부적으로 SELECT 문으로 작동됨 

# 5) 뷰 사용 목적 
# 1. 보안성: 민감한 정보를 직접 공개하지 않고, 필요한 정보만 선별해 제공이 가능함 
#		EX) 주민번호, 연락처, 이메일 등을 제외한 고객 정보 제공 
CREATE VIEW v_member_secure
AS SELECT mem_name, addr FROM member;
SELECT * FROM v_member_secure;

# cf) DB 개체들은 생성과 삭제 시 DDL 문법 사용함 
DROP VIEW v_member_secure;
SELECT * FROM v_member_secure; # 삭제된 뷰는 못불러옴 

# 2. SQL 쿼리의 단순화 목적
CREATE VIEW v_member_buy
AS SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
	FROM buy B join member M on B.mem_id = M.mem_id ;
    
SELECT * FROM v_member_buy WHERE mem_name = '블랙핑크';

# 뷰 모범 사례 #
# : 통계용, 필터링, 보안용 뷰 등 다양하게 사용됨 

# cf) 뷰와 스프링부트 연동 -> Spring Boot는 주로 JPA, 또는 MyBatis를 통해 DB와 연동함 
#		- 이때, 뷰는 일반 테이블 처럼 인식됨 

# cf) 뷰 VS 반정규화 
# 뷰: 실제 데이터를 복제하지 않고 조인 결과를 미리 정의하는 것 (마치 테이블 처럼) 
# 반정규화: 정규화 된 테이블을 의도적으로 중복하거나 조인 없이 바로 조회할 수 있도록 재구성한 것 (성능의 최적화를 목표로 함) 







