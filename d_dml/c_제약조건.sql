## c_제약조건

/*
	1. PK(Primary key) - 중복 X (고유값) & NOT NULL
    2. FK(Foreign key) - 다른 테이블의 PK값을 참조하는 컬럼(테이블 간의 연결)
    
    3. Unique
     : 특정 열의 값이 중복되면 안됨 
     - PK와의 차이점 -> NULL 허용됨
				  -> 한 테이블에 여러개 지정 가능
	EX) 아이디, 이메일, 주민번호 등에 사용됨
*/

CREATE TABLE `users` (
	user_id bigint primary key,
    username varchar(100) unique,
    password varchar(100),
    email varchar(100) unique,
    resident_number varchar(100) unique
);

insert into `users`
values
	(1, 'qwe123', 'qwe123123', 'qwe123@example.com', '123456');
    
insert into `users`
values
	(2, 'wer123', 'wer123123', 'wer123@example.com', '654321');

insert into `users`
values
	(3, 'asd123', 'asd123123', null,  '124578');
    
/*
	4. CHECK 제약 조건
	 : 입력값이 특정 조건을 만족해야만 삽입
     
    
*/

create table employees(
	employee_id bigint primary key,
    name varchar(100),
    age int,
    # check 제약조건 사용 방법
    # check(조건에 대한 작성)
    check (age >= 20)
);

insert into `employees`
values
	(1, '이상은', 30),
	(2, '홍기수', 20),
	-- (3, '배혜진', 10), 
	(4, '김태양', 30);
# Error Code: 3819. Check constraint 'employees_chk_1' is violated.	0.000 sec

insert into `employees`
values 
	(5, '안미향', null);
# Check 제약조건은 null의 여부를 확인하지 않음 -> 하고싶으면 NOT NULL 설정해야함

/*
	5. NOT NULL 제약조건
    : 특정 열에 NULL 값을 허용하지 않는 제약조건 
    - 비워질 수 없음
*/

create table `contacts` (
	contact_id bigint primary key, -- 자동 NOT NULL
    name varchar(100) not null,
    phone varchar(100) not null
);

insert into `contacts`
values
	(1, '권민현', '010-1111-2222'),
	-- (2, '김세훈', null); # Error Code: 1048. Column 'phone' cannot be null
	(2, '김세훈', '010-2222-3333'); 

/*
	6. DEFAULT 제약 조건
	: 테이블의 열에 값이 입력되지 않으면 자동으로 기본값을 넣어주는 제약 조건
    - 선택적 필드에 대한 입력을 단순화(데이터 무결성을 유지 시켜줌) 
*/

create table `carts` (
	cart_id bigint primary key,
    product_name varchar(100),
    # default 제약조건
    # 컬럼명 데이터타입 default 기본값(데이터 타입은 지켜야함)
    quantity int default 1
);

insert into `carts`
values
	(1, '노트북', 3),
	(2, '스마트폰', null),
	-- (3, '태블릿');
    # Error Code: 1136. Column count doesn't match value count at row 3 => null값이라도 지정해야함
	(3, '태블릿', 2);
    
select * from carts;

# default 값 사용방법
# 컬럼 자체에 값 대입이 일어나면 안됨 

insert into `carts` 
values
	# carts의 컬럼을 정의 순서대로 데이터를 전달
    # : quantity 수량을 제외한 데이터를 전달할 경우
    # 	> 테이블명 옆에 (삽입하고자 하는 컬럼명만 나열)
	();
    
insert into `carts`(cart_id, product_name)
values
		(4, '이어폰'),
        (5, '스마트폰');
        
select * from carts;
    
# ---------------------------------- #
# +) 제약조건 사용 시 여러개 동시 지정 가능
# EX) NOT NULL + CHECK

create table multiple (
	multiple_col int not null check(multiple_col > 10)
    
    );

insert into multiple
-- values (10);
# Error Code: 3819. Check constraint 'multiple_chk_1' is violated.
-- values (null);
# Error Code: 1048. Column 'multiple_col' cannot be null
values (11);

drop database if exists example;


