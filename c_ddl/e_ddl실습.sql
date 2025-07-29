# e_ddl실습

/*
	DB(데이터베이스): 데이터를 저장하는 공간
    DBMS: 데이터를 효율적으로 관리할 수 있는 소프트웨어
    RDBMS: 데이터를 테이블 형태로 저장하고 테이블 간의 관계를 통해 데이터 관리하는 시스템
    
    - TABLE: 데이터가 저장되는 기본 단위
        - COLUMN(열, 속성): 각 데이터 유형을 정의
        - ROW(행, 레코드): 고유한 데이터 세트를 정의
        - Key(키): 레코드 식별 속성 
        
        
	== SQL 언어 ==
    : DBMS 에서 데이터를 관리하기 위해 사용되는 표준 프로그래밍 언어
		- DDL(정의)
			Data Definition Language
            : 데이터 정의 언어
            - DB와 테이블의 구조를 생성, 수정, 삭제
            
            1. CREATE(생성)
            2. ALTER(수정)
            3. DROP(삭제 -> 구조체 자체를 삭제)
            4. TRUNCATE(삭제 -> 내부 데이터를 삭제, 구조는 유지함)
            
            +) USE DB명: DB 지정 키워드
			   DESC(Describe) 테이블명: 테이블 구조 조회
               SHOW DB명: 해당 SQL 서버 내의 DB(스키마) 목록을 조회
               IF EXISTS / IF NOT EXISTS: 존재할 경우 실행 / 존재하지 않을 경우 실행 => 추가 옵션
               
			- 데이터 타입(Data Type)
				1. 정수형
					- tinyint, smallint, int, bigint + unsigned(부호가 없는 정수)
				2. 문자형
					- char(개수) , varchar(개수) 
				3. 실수형
					- float, double + decimal
				4. 논리형
					- boolean(true, false => 실제 데이터는 tinyint, 즉 1과 0로 저장)
                5. 날짜형
					- date, time, datetime
				6. 열거형
					- enum
        
		- DML(조작)
		- DCL(제어)
        
*/

/*
DDL 및 데이터 타입 실습 문제
다음 요구사항에 따라 야구 리그 관리 시스템을 위한 데이터베이스와 테이블을 생성하고
	, 구조를 확인 및 수정한 후 삭제하는 SQL 문을 작성하시오.

🔹 [문제 1] 데이터베이스 생성 및 선택
	데이터베이스 생성: baseball_league

	해당 데이터베이스를 사용 지정 
*/

CREATE DATABASE baseball_league;
USE baseball_league;

/*🔹 [문제 2] 팀 정보 테이블 생성
	테이블 생성: teams 

		컬럼명			데이터 타입			설명
		team_id			INT				팀 고유 번호
		name			VARCHAR(100)	팀 이름
		city			VARCHAR(100)	연고지
		founded_year	YEAR			창단 연도 (YYYY 형식)

⚠️ 유의사항: 각 컬럼 선언 뒤에는 쉼표(,)를 적절히 사용하고, 마지막 컬럼 뒤에는 콤마를 쓰지 마세요.

*/

CREATE TABLE `baseball_league`.`teams`(
		team_id 		INT,
        name 			VARCHAR(100),
        city 			VARCHAR(100),
        founded_year 	YEAR
);

/*
🔹 [문제 3] 선수 정보 테이블 생성
	players라는 테이블을 생성 (이미 존재하지 않을 경우에만 생성)

	아래와 같은 구조로 생성:

		컬럼명			데이터 타입								설명
		player_id		INT									선수 고유 번호
		name			VARCHAR(100)						선수 이름
		position		ENUM('타자', '투수', '내야수', '외야수')	선수 포지션

*/

CREATE TABLE IF NOT EXISTS `baseball_league`.`players` (
	player_id 	INT,
    name 		VARCHAR(100),
    position 	ENUM('타자', '투수', '내야수', '외야수')
);


/*
🔹 [문제 4] 테이블 구조 확인
	teams 테이블과 players 테이블의 구조를 확인하는 SQL문을 각각 작성
*/
DESC teams;
DESC players;


/*
🔹 [문제 5] 테이블 구조 수정
	players 테이블에 birth_date 컬럼을 날짜형(DATE) 으로 추가

	변경 후 players 테이블의 구조를 다시 확인
*/
ALTER TABLE players ADD COLUMN birth_date DATE;
DESC players;

/*
🔹 [문제 6] 테이블 삭제
	games 테이블과 players 테이블 삭제 (존재할 경우에만)

*/
DROP TABLE IF EXISTS games, players; 

/*
🔹 [문제 7] 데이터베이스 삭제
	baseball_league 데이터베이스 삭제
*/

DROP DATABASE baseball_league;






