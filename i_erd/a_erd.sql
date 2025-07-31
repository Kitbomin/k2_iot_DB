### i_erd >>> a_erd ###

### ERD 다이어그램 ###
# : Entity Relationship Diagram
# >> Entity 간의 관계를 나타낸 다이어그램 
# >> 데이터(엔티티)와 데이터 간의 관계를 시각적으로 표현한 도표 

# 1. 사용 목적 
-- 실무에서 DB설계 전, 정보 분석과 설계 방향을 명확하게 정리를 위해
-- 팀원간 효율적인 의사소통 도구 

# 2. ERD 구성요소
# 1) ENTITY 
-- 존재하는 실체 (데이터베이스에서 관리되어야 하는 대상)
-- 고유하게 식별 가능해야함 (PK)
-- 사각형으로 표시됨 (엔티티 명은 사각형 안에 명시됨)

# 2) 속성(Attribute)
-- 엔티티의 세부 정보이자 설명 항목 
-- 일반 속성 - 이름, 주소, 전화번호... > 기본키(PK), 외래키(FK) ... 
-- 타원형으로 표시 (속성명은 원 안에 명시)

# 3) 관계(relational) 
-- 엔티티 간의 연결과 연관성 
-- 마름모 OR 선 으로 표현 
# cf) 관계의 유형
# 		1:1 -> 한 엔티티가 다른 하나와만 관계를 가짐 (사람 - 여권) 
#		1:N -> 한 엔티티가 여러 개와 관계를 가짐 (교수 1 - 학생N) 
#		N:N -> 여러 엔티티가 여러개와의 관계를 가짐 (학생 - 과목 - 학생) => 중간 테이블이 필요함 

#### 실무 ERD 표현 규칙 ####
# 1) 부모 PK를 자식이 FK로 가짐 -> 관계성 정의 필요 
# 		>> 실선 관계: 자식이 부모의 존재에 종속됨 (부모가 있어야만 자식이 존재) -> PK + FK
#		>> 점선 관계: 자식이 독립적인 존재 가능함 (부모 없이도 자식 생성이 가능) -> FK 

# 2) 예시 1 
# 학생과 수강 내역 
# 학생 테이블) 부모 테이블 - 학번 PK, 학생명 ... 
# 수강 내역 테이블) 자식 테이블 - 수강 ID PK, 학번 FK, 강의명 ... 
# >>> 관계: 1명의 학생은 여러개의 수강 내역을 가질 수 있음 (1:N 관계)

# 3) 예시 2
# 주문과 주문 상세 내역
# 주문 테이블) 부모 - 주문 ID PK, 주문 일시 ...
# 주문 상세 내역 테이블) 자식 - 주문 ID PK, 주문 상품 ... 
# >>> 관계: 자식 테이블의 기본키가 부모의 기본키를 포함하거나 그대로 사용 (1:1 관계) 


# 4) 예시 3
# 회원과 즐겨찾기 프로그램 
# 회원 테이블) 부모 - 회원 ID PK, 이름 ...
# 즐겨찾기 프로그램 테이블) 고유 번호 ID PK, 회원번호(FK), 프로그램명 ...
# >>> 비회원 또는 임시 사용자도 '즐겨찾기' 기능에 대해 허용된다면? 
# 		- 회원 없이도 자식 테이블이 존재 가능한 구조로 설계 가능 (1:N 관계 - 근데 이제 점선임)


# cf) N:M 관계 처리 방법
# : 관계형 데이터베이스(RDBMS)는 직접적인 N:M 관계를 허용하지 않음 
# - 중간 테이블을 사용해 분해해야함
# EX) 학생 - 과목 
#			1명의 학생은 여러과목을 수강 student
#			1개의 과목은 여러 학생이 수강 subject
# >> 중간테이블: 수강(student_subject)
#		- 학생 ID (FK)
#		- 과목 ID (FK) 
#			>> 연결되는 두 개의 참조값을 복합 키 설정함 
#				cf) 복합키 : 두 개 이상의 컬럼으로 구성된 기본키 
#			- 수강 날짜 등 추가 속성 정의 가능


create database if not exists `composit`;

create table student (
	student_id bigint primary key auto_increment
);

create table course (course_id bigint primary key auto_increment);

create table course_enrollment(# 강의 등록 테이블 (수강)
	student_id bigint,
    course_id bigint,
    
    emrollment_date date,
    
    primary key(student_id, course_id),
    # >> student_id와 course_id의 조합이 비워질 수 없으며, 둘 다 합쳐서 유일한 값이 되어야함
    
    foreign key(student_id) references student(student_id),
    foreign key(course_id) references course(course_id)
);


### MySQL 워크벤치에서 ERD 다이어그램 생성 방법 ###
# 1. 테이블 생성
# 2. 상단 텍스트 메뉴바 Database 클릭 
#		> Revers Engineer 클릭 
# 3. 연결하고자 하는 Connection 선택 > Next 
# 4. 생성하고자 하는 스키마 선택 > Next 
# 5. Execute 실행 - 생성 


### ERD 객체-관계 다이어그램의 관계 표시 ###
# | : 정확히 1개
# < : 여러개 (1 이상)
# 0 : 0개, 없어도 됨 (선택적 관계임)

# 예시
# 회원(Member) 1명이 주문(Order) 을 여러개 할 수 있음 ( Member |< Order) -> 1:N
# 주문(Order) 은 0개 이상의 리뷰(Review 를 가질 수 있음 (Order 0< Review) -> 0:N
# 사원(Employee)은 정확히 하나의 부서(Department)에 속함 (Employee | Department) -> 1:1  










