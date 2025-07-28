### c_ddl >> d_datatype

# 날짜형, 열거형 데이터 타입

/*
	5. 날짜형
    : 날짜 및 시간을 저장할 때 사용
    - date(3byte)
		: 날짜만 저장
        형식: YYYY-MM-DD 형식
        EX) 기념일, 생일 등
        
	- time(3byte)
		: 시간만 저장
        형식: HH:mm:SS 
        EX) 수업 시간, 타이머 등
        
	- datetime(8byte)
		: 날짜와 시간을 저장 
        형식: YYYY-MM-DD HH:mm:SS
        EX) 주문 시간, 가입 날짜 등
        
*/

CREATE DATABASE IF NOT EXISTS `example`;
use `example`;

create table `event` (
	event_nume varchar(100),
    event_date date
);

insert into `event` values('Birthday', '2025-03-14');

/*
	6. 열거형(ENUM)
    : 사전에 정의된 값의 집합 중 하나의 값을 저장
    - 제한된 값 목록 중 선택됨

*/

CREATE TABLE `rainbow` (
	color enum('red', 'orange' , 'yellow', 'purple'),
    description varchar(100)
);

insert into `rainbow`
values
('red', '빨강'),
('orange', '주황'),
('yellow', '노랑'),
('purple', '보라');

select * From rainbow;

insert into `rainbow` values('green', '초록');
# Error Code: 1265. Data truncated for column 'color' at row 1
# >> ENUM 목록에 존재하지 않는 데이터 삽입 시 발생하는 오류



