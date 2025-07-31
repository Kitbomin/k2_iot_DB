### h_trigger >>> trigger01 ###

### 트리거 (trigger) ###
# '방아쇠' , 자동 실행 
# : 테이블에 특정 이벤트가 발생할 때 자동으로 실행되는 저장된 프로시저 형태의 객체 

# 1. 트리거 사용 목적 #
-- 일정 작업을 자동화: 일련의 동작을 같이 처리(회원가입 시 가입 로그 자동 기록) 
-- 데이터 무결성 보장: 수동으로 처리할 작업을 자동으로 처리하여 데이터의 오류를 방지 가능 (주문 후 결제 테이블에 자동 삽입)

# 2. 트리거 사용 예시 # 
-- 특정 레코드(행) 삭제 >> 삭제된 데이터에 대한 로그 기록 생성 
-- 데이터 삽입 시 	   >> 자동으로 관련 값 계산 추가 
-- 회원 정보 수정 시   >> 수정 시간 자동 갱신 

# 3. 트리거 동작 방식 #
# 이벤트가 발생할 대만 자동 실행 (call문으로 직접 실행은 불가능함)
# cf) DML 이벤트 감지 (insert, update, delete) -> select는 감지 못함 

# 4. 트리거 종류 #
# 1) BEFORE 트리거: 해당 작업이 수행되기 전에 실행 
# 2) AFTER 트리거 : 해당 작업이 수행된 후에 실행 

# cf) 모든 트리거는 행(row) 단위로 실행됨 'for each row' 사용 

# 5. 트리거 실무 사용법 #
# : 특정 테이블에서 이벤트 (insert, update, delete) 발생 시 자동 '로그 기록' 
# - 재고 수량 자동 조정, 포인트 자동 적립 등 '자동화된 비즈니스 로직 처리'에 특화 되어있음

# cf) 주의점
# 	  : 남용 시 디버깅이 어렵고, 성능 저하 가능성 존재 >> 꼭 필요한 곳에서만 사용해야함 

# 6. 트리거 기본 문법 #
# : 스토어드 프로시저와 유사함 (call 문 사용 금지)

create database if not exists `trigger`;

USE `trigger`;

/*
	delimiter $$
    
    create trigger 트리거명
		트리거 시점(종류: after, before) 이벤트 종류(insert, update, delete)
		on 테이블명 
		for each row
        
	begin 
		-- 실행 코드 -- 
	end $$ 
    
    delimiter ;
*/

-- 트리거 연습용 테이블 --
create table if not exists `trigger_table` (
	id int,
    txt varchar(10)
);

insert into `trigger_table` 
values 
	(1, '레드벨벳'),
	(2, '에스파'),
	(3, '하츠투하츠');

select * from trigger_table;

-- 트리거 생성 
delimiter $$

create trigger myTrigger 
	# 트리거 종류 이벤트 종류 
    after delete -- delete 문이 발생된 이후에 작동함
    on trigger_table -- 어느 테이블에서 동작할건지? 
    for each row -- 각 행마다 적용 시킴(모든 행에 트리거 적용) 
    
# 실제 트리거에서 작동할 부분 
begin
	set @msg = '가수 그룹이 삭제됨' ;
end $$
delimiter ;	


-- 트리거 사용 테스트 
set @msg = '' ; -- 변수 초기화 

select @mag;  -- 아무 값도 없음 

# 1) 삽입 테스트
insert into trigger_table 
values (4, '아이브');

select @msg;

# 2) 수정 테스트
update trigger_table
set txt = '피프티피프티'
where id = 3;

# cf) id값 PK 설정 
alter table trigger_table
modify id int primary key; 

select * from trigger_table;
desc trigger_table;

select @msg;

# 3) 삭제 테스트
delete from trigger_table
where id = 4;

select @msg;


## 트리거 VS 트랜잭션 ##

# 1) 트리거 
#	: 이벤트 발생 시 '자동처리' 됨 
# 	- INSERT, UPDATE, DELETE 이벤트 발생 시에만 동작 
#	- 자동실행, 개발자가 직접 제어할 수 없음 
#   - 사용목적: 자동화된 응답처리, 감시(로그) 
# 	EX) 게시글 수정 시 로그 자동 기록 등에 사용됨 


# 2) 트랜잭션 
# 	: 여러 작업을 하나의 작업 단위로 원자성 있게 '묶은' 것
# 	- 개발자가 직접 명시적으로 시작함 
# 	- COMMIT(적용시점), ROLLBACK(취소) 로 직접 제어 가능 
# 	- 사용목적: 데이터의 일관성 보장, 오류를 복구하기 위해 사용 
# 	EX) 주문 처리 중 오류 발생 시 전체 작업 롤백 같은 작업에 사용됨 

# cf) 원자성 (Atomicity): 모두 성공 또는 모두 실패 (하나라도 실패 시 모두 롤백) => 일관성 유지를 위한 개념 


