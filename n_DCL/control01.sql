### n_DCL >> control01

### SQL 종류 ###
# 1. DDL (Data Definition) : 데이터 정의언어 (데이터베이스, 데이터베이스 개체 구조 정의)
# >>> CREATE, ALETER, DROP, TRUNCATE 

# 2. DML (Data Manipulation) : 데이터 조작언어 (데이터 CRUD)
# >>> INSERT, SELECT, UPDATE, DELETE 

# 3. DCL (Data Control) : 데이터 통제언어
# >>> GRANT, REBOKE


# DCL (Data Control Language) #
# : 데이터베이스 사용자 권한을 제어하는 SQL 명령어
# - 보안과 접근 제어를 위한 역할 수행 

# 1. GRANT 
# : 특정 사용자에게 권한을 부여하는 것

# 2. REVOKE
# : 특정 사용자에게 부여된 권한을 회수하는 것

### DCL 사용 목적 ###
# 1. 보안강화			: 민감한 데이터에 접근 가능한 사용자 제한이 가능
# 2. 데이터 무결성 유지	: 특정 사용자만 데이터를 수정할 수 있도록 제한할 수 있음 
# 3. 역할 기반 접근 제어	: 사용자의 역할에 다라 필요한 권한만 부여 가능함 

USE korea_db;
SELECT * FROM members;
SELECT * FROM purchases;

# 1) 사용자 계정 생성 
# CREATE USER 명령어 사용 
CREATE USER 'readonly_user'@'localhost' identified by '1234';

# '계정명'@'접속범위설정' INDENTIFIED BY '사용자 로그인 비밀번호 설정';

# cf) 접속 범위 설정 
# - localhost: 현 시스템 컴퓨터를 의미함 (MySQL 서버가 설치된 이 컴퓨터에서만 로그인이 가능)
# - '%': 어떤 IP든지 접속 가능함을 의미함 -> 보안상 매우매우매우 위험함 
# - '127.0.0.1' : 해당 IP 주소를 가진 컴퓨터에서만 로그인이 가능함 (127.0.0.1은 localhost랑 동일함)

# 2) 권한 부여
GRANT SELECT ON korea_db.* TO 'readonly_user'@'localhost';
# GRANT (승인하다)
# SELECT (조회 권한만 부여)
# ON ~(해당스키마의 해당 테이블을 대상으로 권한 부여)
# TO ~(특정 사용자에 대한 권한 부여)

# 3) 권한 확인 방법
# : SHOW GRANTS FOR '권한명'@'접속범위';
SHOW GRANTS FOR 'readonly_user'@'localhost';
SHOW GRANTS FOR 'readonly_user'@'127.0.0.1';

# cf) USAGE 권한 -> 아무 권한도 없는 상태임 사실상 
# >> 계정은 있지만, 어떤 작업도 할 수 없는 상태
# 1. CREATE USER 이후 자동으로 USAGE 권한만 가진 계정이 생성됨 
# 2. 권한을 모두 회수한 뒤에도 USAGE만 남음 

# CLI 명령어로 로그인하는 방법 ▼ - 명령 프롬프트 써야함 
# mysql -u readonly_user -p -h localhost;

# 모든 사용자 계정 목록 확인 #
SELECT user, host FROM mysql.user;
# root 계정 / root 비밀번호 
# readonly 계정 / 1234 비밀번호 

# 현재 로그인한 사용자 확인 #
SELECT CURRENT_USER(); # 현재 접속된 계정을 반환함 
# 현재접속된계정@권한위치; 

USE korea_db;
SELECT user();

SELECT * FROM members;

INSERT INTO members (name, gender, area_code, grade, contact, join_date)
values ('TEST', 'Male', 'JEJU', 'Bronze', '010-0000-0000', '2025-08-04');

### 권한부여 ###
GRANT INSERT, UPDATE, DELETE ON korea_db.members TO 'readonly_user'@'localhost';

### 권한 제거 ###
# 1) 일부 권한 제거
# REVOKE [권한목록] ON [데이터베이스].[테이블] FROM '사용자'@'호스트';
# REVOKE INSERT, UPDATE ON korea_db.members FROM 'readonly_user'@'localhost';

# 2) 모든 권한 제거 (ALL PRIVILEGES = 모든 권한) (GRANT OPTION = 권한 위임 금지)
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'readonly_user'@'localhost';

### 사용자 삭제 ###
DROP USER 'readonly_user'@'localhost';

 