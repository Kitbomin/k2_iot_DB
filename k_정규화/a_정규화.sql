## k_정규화 >>> a_정규화

/*
	1. 정규화(Normalization) 개요
     : 중복된 데이터를 제거하고 , 데이터의 무결성을 유지하기 위해 테이블을 구조적으로 나누는 과정 
     
     >> 정규화를 하지 않으면 데이터 중복과 이상 현상(삽입, 갱신, 삭제) 발생 위험 有
     
     
	2. 정규화 목적 
		1) 중복 최소화		: 데이터의 재사용성과 저장 공간에 대한 효율을 증가 시킴 
		2) 무결성 유지		: 데이터의 일관성과 정확성을 유지 
        3) 이상 현상 방지	: 삽입, 갱신, 삭제 시 발생하는 오류 제거 
		4) 유지보수 용이 	: 테이블 구조가 명확해짐 -> 관리하기가 쉬워짐 
        
	3. 정규화 종류
		제 1 정규형(1NF)
		제 2 정규형(2NF)
		제 3 정규형(3NF)
		보이스코드 정규형(BCNF - Boyce-Codd)
		제 4 정규형(4NF)
		제 5 정규형(5NF)
    
    cf) 정규형(Normal Form): 데이터 베이스 정규화 과정에서 달성하고자 하는 일정한 규칙이나 기준을 의미함 
    
    
    4. 정규화의 필요성 
    
		id		name	course_id	course_name		course_instructor
        1		김태양	101			슬립테크 			김준일 
        1		김태양	102			IoT				이승아 
        2		홍기수	102			IoT				이승아 
    
		>> 위 테이블의 문제점 
			1) 중복 데이터 발생: 학생, 강의, 강사 정보가 중복 저장됨 
            2) 이상 현상 발생	
				- 삽입 이상: 수강생 없이 강의만 등록이 불가능함 
                - 수정 이상: 같은 강사명이나 학생명을 여러 행에 걸쳐 모두 수정해야함 -> 하나라도 누락되면 무결성 위배
                - 삭제 이상: 학생 삭제 시, 강의 정보까지 삭제될 위험 우려 
            
            cf) 이상현상: 비정규화 된 테이블에서 발생하는 데이터 무결성 문제 
				>> 삽입, 갱신, 삭제 이상 
		
	5. 정규화의 단계 
		1) 제 1 정규형
			: 모든 컬럼이 원자값을 가질 것 
            - 반복되는 그룹 제거 (EX: 하나의 셀에 여러 값 저장 금지) 
        
        2) 제 2 정규형
			: 1NF를 만족 + 기본키(PK)에 대한 완전 함수 종속을 가질 것
            - 부분 종속을 제거 => 복합키의 일부 컬럼에만 의존하는 속성을 분리 
        
        3) 제 3 정규형
			: 2NF를 만족 + 이행적 함수 종속을 제거할 것 
            - 비주요 속성이 다른 비주요 속성에 의존하지 않도록 분리 
        
        +) BCNF정규형 
			: 3NF를 만족 + 후보키가 아닌 결정자가 존재하지 않아야함 
            - 3NF보다 조금 더 엄격함(모든 결정자가 후보키여야함)
            
        4) 제 4 정규형
			: 다치 종속 제거할 것 
            
        5) 제 5 정규형 
			: 조인 종속성 제거 
        
    
*/

create database `normal`;
use normal;

DROP table if exists `student_course`;

create table if not exists student_course (
	student_id 		bigint not null,
	student_name 	varchar(50) not null,
	course_id 		bigint not null,
	course_name 	varchar(50) not null,
	course_instructor varchar(50) not null,
    
    primary key(student_id, course_id) # student_id, course_id는 중복이 허용되지 않음 -> 비워질 수 없음 
);

insert into student_course
values
	(1, '이상은', 101, '생성형AI', '김준일'),
	(1, '이상은', 102, '챗GPT', '이승아'),
	(2, '이상은', 102, '챗GPT', '이승아'),
	(3, '이상은', 103, '생성형AI', '안근수');
    
select * from student_course;

### 이상현상 예시 ###
# 1) 삽입 이상 
insert into student_course (course_id, course_name, course_instructor)
values (104, '코리아IT', '조승범');
# Error Code: 1364. Field 'student_id' doesn't have a default value


# 2) 갱신 이상 
# : 오류는 안나는데 각 행에서 조건을 찾아 일일히 변경해야함 -> 메모리에 부담이 감 
update student_course set course_instructor = '김준이'
where course_id = 101;
# 1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0 => 정상 실행되긴 함 근데 이제 이게 동시에 몇백개씩 갱신한다면? -> 누락 가능성 존재

select * from student_course;

# 3) 삭제 이상 
delete from student_course
where student_id = 3;

select * from student_course;


### 정규화 예시 ### 
# 학생, 과목, 학생 - 과목 테이블
# 학생과 과목간의 관계 (N:M) 
create table students (
	student_id int primary key,
    student_name varchar(50)
);

create table courses (
	course_id int primary key,
    course_name varchar(50),
    instructor varchar(50)
);

create table `student_course_connect` (
	# 학생 / 과목 관계 테이블 
    student_id int,
    course_id int,
    primary key(student_id, course_id), -- 복합키 설정 
    foreign key(student_id) references students(student_id),
    foreign key(course_id) references courses(course_id)
);

insert into students
values
	(1, '김세훈'),
	(2, '권민현'),
	(3, '안미향');

insert into courses
values
	(101, '챗봇', '이승아'),
	(102, 'ERP', '김준일'),
	(103, '코리아 IT', '조승범');
    
insert into student_course_connect
values
	(1, 101), (1, 102), (2,102), (3,103);

select * from students;
select * from courses;
select * from student_course_connect;

-- 수강생 없이 새로운 과목만 등록 
insert into courses values (104, 'SAAS', '안근수');
# 정상 작동함
select * from courses;

-- 강사 이름 갱신 (수정)
update courses set instructor = '김준상' where course_id = 102;
select * from courses;

-- 수강 정보 삭제 시 학생과 과목에 영향을 미치지 않음 (삭제) 
delete from student_course_connect where student_id = 3;
select * from students;
select * from student_course_connect;
select * from courses;

### 정규화 사용 모범 사례 ###
# 정규화가 무조건적인 정답은 아님 
# : 과도한 정규화는 Join이 많아짐 -> 성능 저하의 우려 발생 (5 정규화 해야함)
# - 실무에서는 3NF + 일부 반정규화를 조합 (성능과 무결성 사이 균형을 유지해야함) 


# cf) 베스트 프렉티스 (best practice) : 특정 문제를 해결하거나 목표를 달성함에 있어서 가장 효과적이고 검증된 방법 

