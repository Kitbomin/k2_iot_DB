## k_정규화 >>> d_제 3 정규형

### 제 3 정규화(3NF) ###
# : 정규화의 3번째 단계 
# - 2NF를 만족하는 테이블에서, 모든 비기본 속성이 기본키에만 함수적으로 종속되어야 함
# 		> 이행적 함수적 종속을 제거 

# cf) 이행적 종속석
# : 어떤 속성 A가 다른 속성 B에 종속되고, B가 또 다른 속성 C에 종속된 경우 A가 C에 이행적으로 종속됨
#		A -> B, B -> C = A -> C 

# 제 3 정규형의 핵심 조건 
# : 이행적 종속성을 제거하는 것이 핵심 

/*
	학번		이름		학과ID	학과명	학과위치
	1		정은희	101		코리아	부산
    기본키: 학번 
    비기본 속성: 이름, 학과ID, 학과명, 학과 위치 
    
    함수 종속 관계 
    - 학번 -> 학과 ID (학생은 특정 학과에 소속되어있음) 
    - 학과명, 학과 위치-> 학과ID (학과 ID로 학과 정보 확인 가능) 
    
    이행적 종속 관계 
    - 학번 -> 학과 ID -> 학과명, 학과 위치 
    
*/

drop database if exists normal;
create database if not exists normal;
use normal;

create table department (
	department_ID int primary key,
    department_name varchar(100),
    location varchar(100)
);

create table student (
	student_ID int primary key,
    student_name varchar(50),
    department_ID int,
    foreign key(department_ID) references department(department_ID)
);

-- 정보 입력 
insert into department
values
	(101, '컴공', '서울'),
	(102, '통계', '부산');
    
insert into student 
values
	(1, '최광섭', 101),
	(2, '손태경', 101),
	(3, '박현우', 102);


# 학생 번호 > 강의 ID 
# 강의 ID > 강의 위치(이행적 종속성 분리 - 구조화)
# : 학생의 정보와 강의 위치를 한번에 파악하고 싶다면? -> 조인(Join) 연산 필요 

select * from department;
select * from student;

select S.student_ID, S.student_name, D.department_name, D.location 
from student S
	inner join department D
	on S.department_ID = D.department_ID;

### 제3정규화 장점 ###
# 1) 중복 제거로 저장 공간 절약 가능 
# 2) 데이터 일관성 유지 가능 
# 3) 삽입, 갱신, 삭제 이상 방지 
# 4) 테이블 간 명확한 관계가 형성됨 ★


### 제3정규화 모범 사례 ###
# : 서로 다른 종류의 정보를 따로 담아야 안전 
# - 무조건적인 정규화는 오히려 효율성이 저하됨 (JOIN 증가) 
# - 경우에 따라 반정규화(역정규화) 고려
#	>> '기본적인 정규화 원칙' 이해 적용이 필수임 













