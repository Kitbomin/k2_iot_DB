### g_programming >> b_형변환
# : 한 데이터 타입을 다른 데이터 타입으로 바꾸는 것
 
USE market_db;

### 1) 명시적인 형 변환
# case (값 as 데이터 형식)
# convert(값, 데이터 형식)
# >> 두 문법은 형식만 다를 뿐 기능은 동일함 

select * from buy;

select AVG(price) as '평균 가격' 
from buy; # 142.9167

# cf) 형 변환 시 정수형 데이터 타입 
# 		>> signed, unsigned만 사용 가능 (tinyint, int 등 사용 불가능함)
#			- signed  : 부호가 있는 정수 (양수 음수 다 가능) 
#			- unsigned: 부호가 없는 정수

select 
	AVG(price) '평균 가격' ,
    cast(avg(price) as unsigned)  '정수 평균 가격',
    convert(avg(price), unsigned) '정수 평균 가격'
from buy;

-- 날짜 형 변환(포맷 지정)
# date 타입: YYYY-MM-DD 
# >> MYSQL은 문자 형식을 자동으로 분석해서 YYYY-MM-DD 형식으로 변환해줌 
# cf) 형식에서 너무 벗어나는 경우 오류 발생 -> 변환시켜주지 않음 

select cast('2025$07$31' as Date);
select cast('2025%07$31' as Date);
select cast('2025&07@31' as Date);
select cast('2025!07*31' as Date);

select convert('07/31/2025', Date); # 이건 NULL이 나옴 -> 형식에서 어긋나기 때문 













