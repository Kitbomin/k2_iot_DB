## a_index02

### 인덱스 사용 정리 ###
# : 검색 속도 향상 도구 
# - 책의 목차 처럼 빠르게 데이터를 찾게 해줌 
# - 조건문(where), 정렬(order by), 조인(join) 등에서 유용함 

/*
	인덱스 생성 방법 (키 설정 방식 X) 
    
    create [unique] index 인덱스명 
    on 테이블명 (열이름 [asc | desc]);

	cf) [] 대괄호 키워드 = 생략 가능 
    
    1) unique: 중복을 허용하지 않는 고유 인덱스 생성 (생략 시 중복을 허용함) 
    2) asc | desc : 오름차순? 내림차순? (생략 시 오름차순) 
    
*/

use 인덱스;

# 단순 인덱스 생성 
create index idx_member_addr 
	on members (address);
    
# 고유 인덱스 생성
create unique index idx_member_name
	on members (mem_name);

# cf) create index로 생성된 인덱스는 drop index 로만 제거가 가능함 
#		>> 기본키(PK), 고유키(Unique)로 자동생성된 인덱스는 drop index 불가능 

show index from members;

show table status like 'members';
# : 테이블에 대한 다양한 정보 확인 명령어 
# > 테이블 엔진 타입, 행 수, 데이터 크기, 인코딩 방식, 자동 증가값, 주석 ... 
# 1) Data_length(클러스터형 인덱스 크기) : 16354 바이트 (16KB) 
# 2) index_length (보조 인덱스 크기) : 0  => 보조 인덱스가 적용되고있지 않음 

# cf) 생성된 인덱스 적용 방법 (create index 이후 반드시 실행하여야 성능 최적화 기여 가능)
analyze table members; -- analyze table 테이블명;

show table status like 'members';
# index_length : 49152
# cf) MySQL (InnoDB엔진) 의 기본 인덱스 페이지 크기는 16kb 정도 


