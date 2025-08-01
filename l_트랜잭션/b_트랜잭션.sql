### l_트랜잭션 >> b_트랜잭션

# cf) 트랜잭션 실무 적용 예시
# 1) 은행, 쇼핑몰, 주문 / 결제 시스템 등의 복수의 INSERT,UPDATE 작업이 동시에 필요한 곳에서 필수 사용됨 
# 2) 예외 처리 로직에서 ROLLBACK이 반드시 수행되도록 설계 
# 3) 자바(Spring) 연동 시, @Transactional 어노테이션을 활용함 

use `트랜잭션`;

create table users (
	id int auto_increment primary key,
    username varchar(50) not null,
    password varchar(50) not null
);

drop table user_settings;

create table user_settings (
	id int auto_increment primary key,
    user_id int,
    dark_mode boolean,
    
    foreign key (user_id) references users(id) on delete cascade 
    # cascade = 위에서 아래로 흐른다 -> 흐름이 일정하다 -> 연속적인 흐름을 정의 
    
    # cf) on delete cascade: 외래키 제약조건(옵션) -> 외래키가 참조하는 부모 테이블의 레코드가 삭제될 경우 그 레코드를 참조하던 자식도 자동 삭제 함 
    # 							-> 참조 무결성 유지 시켜줌 
    
    # cf) on update cascade: 부모 테이블의 기본키 값이 수정될 경우 이를 참조하던 자식 테이블의 외래키 값도 자동 수정됨   
    
);

create table logs (
	id int auto_increment primary key,
    message text,
    created_at datetime default current_timestamp 
);

select * from users;
select * from user_settings;
select * from logs;


start transaction;

-- 1단계: 사용자 등록
insert into users (username, password)
values 
	('qwe123','qwe12341234');
savepoint step1;
    
-- 2단계: 설정 추가
insert into user_settings (user_id, dark_mode)
values (last_insert_id(), true);

		# cf) last_insert_id()
        # : 마지막으로 자동 증가된 스키마의 해당 데이터값을 반환 
        # > users 테이블의 id 값이 반환됨 

savepoint step2;

-- 3단계: 로그 저장
insert into logs (message) values ('회원가입 시도');

rollback to savepoint step1;
# >> 임의로 에러가 발생되었다고 가정! -> 2단계에서 문제 발생해서 1단계가 유지된 이후 환경으로 롤백 -> 2단계만 취소됨 

commit;

select * from users;
select * from user_settings; ### step1 위치로 이동하기 때문에 사용자 설정은 기록에 남지 않음 
select * from logs;


















