### h_trigger >>> trigger03 ###

# 트리거 예시

USE baseball_league;

SELECT * FROM players;
SELECT * FROM teams;

# 트리거 생성#
# : 선수가 새로 등록될 때마다 해당 선수가 속한 팀의 선수 수를 자동 업데이트
create table if not exists player_insert_log (
	log_id bigint auto_increment primary key,
    team_id int,
    log_msg varchar(255),
    log_time datetime
);

drop trigger if exists after_player_insert;

delimiter $$

create trigger after_player_insert
	after insert
    on players
    for each row
    
begin 
	insert into player_insert_log (team_id, log_msg, log_time)
    values
		(NEW.team_id, concat('create team', NEW.team_id), now());
end $$

delimiter ;

# OLD: update, delete 시 변경 사항이 임시로 저장되는 테이블 
# NEW: insert, update, delete 시 방금 삽입된 또는 갱신된 행을 참조함 

select * from player_insert_log;

insert into players
	values
		(106, 'LSA', '타자', '2025-07-31', 1);

insert into players
	values
		(107, 'LSA', '타자', '2025-07-31', 1),
		(108, 'LDK', '타자', '2025-07-31', 1),
		(109, 'LAA', '타자', '2025-07-31', 1),
		(110, 'AAA', '타자', '2025-07-31', 1);

select * from player_insert_log;



