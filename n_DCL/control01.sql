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














 