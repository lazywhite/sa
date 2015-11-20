-- MySQL dump 10.13  Distrib 5.5.24, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: PiLi_GameDB
-- ------------------------------------------------------
-- Server version	5.5.24-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'PiLi_GameDB'
--
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_CHANGE_NAME`(IN p_user_id INT UNSIGNED,
	IN p_name VARCHAR(30))
l_pro:BEGIN
	DECLARE v_old_name VARCHAR(30);
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	SET AUTOCOMMIT = 0;
	
	
	IF (SELECT COUNT(`id`) FROM `T_SYS_NAME_FORBIDDEN` WHERE `name` = p_name) > 0
	THEN
		ROLLBACK;
		SELECT '1209' AS `code`;
		LEAVE l_pro;
	END IF;
	
	IF (SELECT COUNT(`user_id`) FROM `T_USER` WHERE `user_name` = p_name) > 0
	THEN
		ROLLBACK;
		SELECT '1207' AS `code`;
		LEAVE l_pro;
	END IF;
	SELECT `user_name` into v_old_name FROM `T_USER` WHERE `user_id` = p_user_id FOR UPDATE;
	UPDATE `T_USER`
		SET `user_name` = p_name
	WHERE `user_id` = p_user_id;
	DELETE FROM `T_SYS_NAME_CANDIDATE` WHERE `name` = p_name;
	if v_old_name <> ''
	then
	INSERT INTO `T_SYS_NAME_CANDIDATE` (`name`) 
	SELECT `name` FROM `T_SYS_NAME` WHERE `name` = v_old_name;
	end if;
	COMMIT;
	SELECT '0000' AS `code`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_CUP_MATCH_SAVE`(                                                         
	IN p_final_num SMALLINT UNSIGNED,                                                          
	IN p_match_id SMALLINT UNSIGNED,                                                           
	IN p_user1_win BIT,                                                                        
	IN p_user1 INT UNSIGNED,                                                                   
	IN p_disp1 VARCHAR(511),                                                                   
	IN p_disp1_detail VARCHAR(511),                                                            
	IN p_user2 INT UNSIGNED,                                                                   
	IN p_disp2 VARCHAR(511),                                                                   
	IN p_disp2_detail VARCHAR(511),                                                            
	IN p_report BLOB,                                                                          
	IN p_win_count INT UNSIGNED,                                                               
	IN p_best_grade SMALLINT UNSIGNED,                                                         
	IN p_is_reversal BIT,                                                                      
	IN p_is_nose_out BIT                                                                       
)
BEGIN                                                                                        
	DECLARE v_winner_id INT UNSIGNED;                                                          
	DECLARE v_score INT UNSIGNED;                                                              
	IF(p_user1_win) THEN                                                                       
		SET v_winner_id = p_user1;                                                               
	ELSE		                                                                                   
		SET v_winner_id = p_user2;                                                               
	END IF;                                                                                    
                                                                                             
	IF v_winner_id > 0 THEN                                                                    
		IF p_final_num = 16 THEN                                                                 
			SET v_score = 5;                                                                       
		ELSEIF p_final_num = 8 THEN                                                              
			SET v_score = 10;                                                                      
		ELSEIF p_final_num = 4 THEN                                                              
			SET v_score = 20;                                                                      
		ELSEIF p_final_num = 2 THEN                                                              
			SET v_score = 30;                                                                      
		ELSE                                                                                     
			SET v_score = 0;                                                                       
		END IF;                                                                                  
                                                                                             
		UPDATE T_USER_CUP                                                                        
		SET win_count = p_win_count,                                                             
			best_grade = p_best_grade,                                                             
			today_score = today_score + v_score                                                    
		WHERE user_id = v_winner_id;                                                             
	END IF;                                                                                    
                                                                                             
	INSERT INTO `T_CUP_MATCH`                                                                  
	(                                                                                          
		`final_num`,                                                                             
		`match_id`,                                                                              
		`user1_win`,                                                                             
		`user1`,                                                                                 
		`disp1`,                                                                                 
		`disp1_detail`,                                                                          
		`user2`,                                                                                 
		`disp2`,                                                                                 
		`disp2_detail`,                                                                          
		`report`,                                                                                
		`is_reversal`,                                                                           
		`is_nose_out`                                                                            
	)                                                                                          
	VALUES                                                                                     
	(                                                                                          
		p_final_num,                                                                             
		p_match_id,                                                                              
		p_user1_win,                                                                             
		p_user1,                                                                                 
		p_disp1,                                                                                 
		p_disp1_detail,                                                                          
		p_user2,                                                                                 
		p_disp2,                                                                                 
		p_disp2_detail,                                                                          
		p_report,                                                                                
		p_is_reversal,                                                                           
		p_is_nose_out                                                                            
	);                                                                                         
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_GET_NEXT_NAME`()
BEGIN 
	DECLARE v_id INT UNSIGNED;
	DECLARE v_name VARCHAR(30);

	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

	SET AUTOCOMMIT = 0;

	SELECT `id`, `name` into v_id, v_name FROM `T_SYS_NAME_CANDIDATE` ORDER BY `id` LIMIT 0,1 FOR UPDATE;
	DELETE FROM `T_SYS_NAME_CANDIDATE` WHERE `id` = v_id;
	INSERT INTO `T_SYS_NAME_CANDIDATE` (`name`) VALUES (v_name);

	SELECT v_name;

	COMMIT;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_GUILD_BOSS_ATTACKBOSS`(
     in p_user_id int,
     in p_guild_id int,
     in p_dmg int,
     IN p_dmg_for_rob int,
     in p_paidtimes int,
     in p_availtimes int,
     in p_attackts int,
     in p_fight int,
     IN p_bonus_scores int
     )
BEGIN
    declare p_date int(12);
    SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET AUTOCOMMIT = 0;
    set p_date = UNIX_TIMESTAMP(CURDATE());
    
    
	UPDATE T_USER_GUILD_BOSS
	SET dmg_total = dmg_total + p_dmg,
	dmg_daily = dmg_daily + p_dmg,
	dmg_for_rob = dmg_for_rob + p_dmg_for_rob,
	dmg_for_rob_base = dmg_for_rob,
	dmg_for_rob_old = dmg_for_rob,
	attack_ts = p_attackts,
	paid_times = p_paidtimes,
	avail_times = p_availtimes,
	fight = p_fight,
	bonus_scores = p_bonus_scores
	WHERE user_id=p_user_id
	and today=p_date;
	
    
	
	UPDATE T_GUILD_BOSS SET
        dmg = dmg + p_dmg,
        dmg_daily = dmg_daily + p_dmg
        WHERE guild_id = p_guild_id
        and today=p_date;
 
    commit;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_GUILD_BOSS_ROB`(in p_user_id int,
     in p_target_user_id int,
     in p_guild_id int,
     in p_target_guild_id int,
     in p_win int,
     in p_dmg int,
     in p_availtimes int,
     in p_paidtimes int,
     in p_attackts int,
     in p_target_formation blob,
     in p_target_blood int,
     in p_target_curfight int,
     in p_target_hurt int)
BEGIN
    declare p_date int(12); 
    declare p_dmg_old int(12);
    declare p_dmg_add int(12);
    SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET AUTOCOMMIT = 0;

    set p_date = UNIX_TIMESTAMP(CURDATE());
    set p_dmg_add = p_dmg + 20000;
    select dmg_for_rob into p_dmg_old from T_USER_GUILD_BOSS where user_id=p_target_user_id and today = p_date;
    if p_dmg_old < p_dmg
    then
	set p_dmg = p_dmg_old;
	set p_dmg_add = p_dmg_old + 20000;
    end if;
    
    IF(p_user_id > p_target_user_id)
    then
	UPDATE T_USER_GUILD_BOSS
	SET dmg_total = dmg_total - p_dmg,
	rob_dmg = rob_dmg - p_dmg,
	rob_dmg_daily = rob_dmg_daily - p_dmg,
	dmg_daily = dmg_daily - p_dmg,
	dmg_for_rob = dmg_for_rob-p_dmg,
	rob_blood = p_target_blood,
	cur_fight = p_target_curfight,
	formation = p_target_formation,
	hurt_ts = p_target_hurt	
	WHERE user_id=p_target_user_id and today=p_date;

	update T_USER_GUILD_BOSS
	set dmg_total = dmg_total + p_dmg_add,
	rob_dmg = rob_dmg + p_dmg_add,
	rob_dmg_daily = rob_dmg_daily + p_dmg_add,
	dmg_daily = dmg_daily + p_dmg_add,
	attack_ts = p_attackts,
	paid_times = p_paidtimes,
	avail_times = p_availtimes
	where user_id=p_user_id AND today=p_date;
    else
	UPDATE T_USER_GUILD_BOSS
	SET dmg_total = dmg_total + p_dmg_add,
	rob_dmg = rob_dmg + p_dmg_add,
	rob_dmg_daily = rob_dmg_daily + p_dmg_add,
	dmg_daily = dmg_daily + p_dmg_add,
	attack_ts = p_attackts,
	paid_times = p_paidtimes,
	avail_times = p_availtimes
	WHERE user_id=p_user_id AND today=p_date;
	
	UPDATE T_USER_GUILD_BOSS
	SET dmg_total = dmg_total - p_dmg,
	rob_dmg = rob_dmg - p_dmg,
	rob_dmg_daily = rob_dmg_daily - p_dmg,
	dmg_daily = dmg_daily - p_dmg,
	dmg_for_rob = dmg_for_rob-p_dmg,
	rob_blood = p_target_blood,
	cur_fight = p_target_curfight,
	formation = p_target_formation,
	hurt_ts = p_target_hurt
	WHERE user_id=p_target_user_id AND today=p_date;
	
	
    end if;
    
    if p_guild_id < p_target_guild_id
    then
	UPDATE T_GUILD_BOSS SET
        dmg = dmg + p_dmg_add,
        dmg_daily = dmg_daily +p_dmg_add,
        rob_dmg_daily = rob_dmg_daily +p_dmg_add
        WHERE guild_id = p_guild_id AND today=p_date;
        
        UPDATE T_GUILD_BOSS SET 
	dmg = dmg -p_dmg,
	dmg_daily = dmg_daily-p_dmg,
	rob_dmg_daily = rob_dmg_daily - p_dmg
	WHERE guild_id=p_target_guild_id AND today=p_date;
    else 
	update T_GUILD_BOSS set 
	dmg = dmg -p_dmg,
	dmg_daily = dmg_daily-p_dmg,
	rob_dmg_daily = rob_dmg_daily - p_dmg
	where guild_id=p_target_guild_id AND today=p_date;
	
	UPDATE T_GUILD_BOSS SET
        dmg = dmg + p_dmg_add,
        dmg_daily = dmg_daily + p_dmg_add,
        rob_dmg_daily = rob_dmg_daily +p_dmg_add
        WHERE guild_id = p_guild_id AND today=p_date;
    end if;
    
    if not exists(select id from T_GUILD_BOSS_HATRED where guild_id=p_guild_id and  target_id=p_target_guild_id)
    then
	insert into T_GUILD_BOSS_HATRED(guild_id,target_id,dmg)
	values(p_guild_id,p_target_guild_id,p_dmg);
    else
	update T_GUILD_BOSS_HATRED
	set dmg = dmg+p_dmg
	where guild_id=p_guild_id
	and target_id = p_target_guild_id;
    end if;
    commit;
    select p_dmg_add,dmg_for_rob from T_USER_GUILD_BOSS where user_id=p_target_user_id AND today=p_date;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_REGISTER`(IN p_plat SMALLINT UNSIGNED,
	IN p_plat_id VARCHAR(128),
	IN p_user_name VARCHAR(30),
	IN p_init_power INT UNSIGNED,	IN p_init_endurance INT UNSIGNED,IN p_device_type VARCHAR(50))
l_pro:BEGIN
	DECLARE v_user_id INT UNSIGNED;
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	SET v_user_id = 0;
	IF (SELECT count(user_id) FROM T_USER where plat = p_plat and plat_id = p_plat_id) > 0
	THEN
		ROLLBACK;
		SELECT '1203' AS code, v_user_id as user_id;
		LEAVE l_pro;
	END IF;
	
	IF (p_user_name <> '' AND (SELECT count(user_id) FROM T_USER where user_name = p_user_name) > 0)
	THEN
		ROLLBACK;
		SELECT '1207' AS code, v_user_id as user_id;
		LEAVE l_pro;
	END IF;
	
	IF (p_user_name <> '' AND (SELECT count(id) FROM T_SYS_NAME_FORBIDDEN where name = p_user_name) > 0)
	THEN
		ROLLBACK;
		SELECT '1207' AS code, v_user_id as user_id;
		LEAVE l_pro;
	END IF;
	INSERT INTO T_USER
	(plat, plat_id,user_name,power_value,reg_ts,last_login_ts,logout_ts, endu_val, device_type) 
	VALUES
	(p_plat, p_plat_id, p_user_name, p_init_power, unix_timestamp(), unix_timestamp(),UNIX_TIMESTAMP(),p_init_endurance,p_device_type);
	SET v_user_id = LAST_INSERT_ID();
	INSERT INTO T_USER_MONEY(user_id)values(v_user_id);
	INSERT INTO T_USER_EXPLORE
	(user_id, chapter_id, map_id)
	VALUES 
	(v_user_id, 1, 101);
	
	DELETE FROM T_SYS_NAME_CANDIDATE WHERE name = p_user_name;
	INSERT INTO T_TODAY_USER (plat, user_id, today) values (p_plat, v_user_id, UNIX_TIMESTAMP(CURDATE()));
	COMMIT;
	SELECT '0000' AS code, v_user_id as user_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_RETENTION_STAT`(IN p_site INT(10), IN p_server INT(10),IN p_date_ts int(12))
BEGIN
	declare p_date varchar(32) default '';
	declare p_today_ts int(12) default 0;
	declare p_reg_num int(12) default 0;
	declare p_1day_num int(12) default 0;
	declare p_2day_num int(12) default 0;
	declare p_6day_num int(12) default 0;
	declare p_1day_ts int(12) default 0;
	declare p_2day_ts int(12) default 0;
	declare p_6day_ts int(12) default 0;
	
	set p_date = FROM_UNIXTIME(p_date_ts);
	set p_today_ts = UNIX_TIMESTAMP(CURDATE());
	set p_1day_ts = p_date_ts + 86400;
	set p_2day_ts = p_date_ts + 86400 * 2;
	set p_6day_ts = p_date_ts + 86400 * 6;
	
	
	select count(user_id) into p_reg_num from T_USER where reg_ts >= p_date_ts and reg_ts < p_1day_ts;
	
	If p_1day_ts < p_today_ts
	then
		select count(U.user_id) into p_1day_num from T_USER U INNER JOIN T_TODAY_USER T ON(U.user_id=T.user_id)
		where U.reg_ts >= p_date_ts and U.reg_ts < p_1day_ts
		and T.today = p_1day_ts;
	end if;
	IF p_2day_ts < p_today_ts
	THEN
		SELECT COUNT(U.user_id) INTO p_2day_num FROM T_USER U INNER JOIN T_TODAY_USER T ON(U.user_id=T.user_id)
		WHERE U.reg_ts >= p_date_ts AND U.reg_ts < p_1day_ts
		AND T.today = p_2day_ts;
	END IF;
	
	insert into T_STAT_RETENTION_SERVER(`date`,site_id,server_id,reg_num,`1dr`,`2dr`,`6dr`)
	select p_date,p_site,p_server,p_reg_num,p_1day_num/p_reg_num,p_2day_num/p_reg_num,p_6day_num/p_reg_num;
	
	insert into T_STAT_RETENTION_PLAT (`date`,site_id,server_id,plat_id,today_reg)
	SELECT p_date,p_site,p_server,plat,COUNT(user_id)
	FROM T_USER
	WHERE reg_ts >= p_date_ts AND reg_ts < p_1day_ts GROUP BY plat;
	UPDATE T_STAT_RETENTION_PLAT c,(SELECT COUNT(DISTINCT(a.user_id)) retention_num,a.plat plat_id FROM T_USER a INNER JOIN T_TODAY_USER b ON (a.user_id=b.user_id) WHERE a.reg_ts >= p_date_ts AND a.reg_ts < p_1day_ts AND b.today=p_1day_ts GROUP BY a.plat )d
	SET c.1day_num = d.retention_num
	WHERE c.plat_id=d.plat_id
	AND c.date = p_date;
	
	UPDATE T_STAT_RETENTION_PLAT c,(SELECT COUNT(DISTINCT(a.user_id)) retention_num,a.plat plat_id FROM T_USER a INNER JOIN T_TODAY_USER b ON (a.user_id=b.user_id) WHERE a.reg_ts >= p_date_ts AND a.reg_ts < p_1day_ts AND b.today=p_2day_ts GROUP BY a.plat )d
	SET c.2day_num = d.retention_num
	WHERE c.plat_id=d.plat_id
	AND c.date = p_date;
	
	UPDATE T_STAT_RETENTION_PLAT c,(SELECT COUNT(DISTINCT(a.user_id)) retention_num,a.plat plat_id FROM T_USER a INNER JOIN T_TODAY_USER b ON (a.user_id=b.user_id) WHERE a.reg_ts >= p_date_ts AND a.reg_ts < p_6day_ts AND b.today=p_1day_ts GROUP BY a.plat )d
	SET c.6day_num = d.retention_num
	WHERE c.plat_id=d.plat_id
	AND c.date = p_date;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_RETENTION_STAT_HISTORY`(IN p_site INT(10), IN p_server INT(10))
BEGIN
	declare p_date varchar(32) default '';
	declare p_date_ts int(12) default 0;
	declare p_today_ts int(12) default 0;
	declare p_reg_num int(12) default 0;
	declare p_1day_num int(12) default 0;
	declare p_2day_num int(12) default 0;
	declare p_6day_num int(12) default 0;
	declare p_1day_ts int(12) default 0;
	declare p_2day_ts int(12) default 0;
	declare p_6day_ts int(12) default 0;
	
	set p_date = '2014-03-26';
	SET p_today_ts = UNIX_TIMESTAMP(CURDATE());
	
	while p_date < '2014-04-23'
	do
		set p_date_ts = UNIX_TIMESTAMP(p_date);
		set p_1day_ts = p_date_ts + 86400;
		set p_2day_ts = p_date_ts + 86400 * 2;
		set p_6day_ts = p_date_ts + 86400 * 6;
		
		
		select count(user_id) into p_reg_num from T_USER where reg_ts >= p_date_ts and reg_ts < p_1day_ts;
		
		If p_1day_ts < p_today_ts
		then
			select count(U.user_id) into p_1day_num from T_USER U INNER JOIN T_TODAY_USER T ON(U.user_id=T.user_id)
			where U.reg_ts >= p_date_ts and U.reg_ts < p_1day_ts
			and T.today = p_1day_ts;
		end if;
		IF p_2day_ts < p_today_ts
		THEN
			SELECT COUNT(U.user_id) INTO p_2day_num FROM T_USER U INNER JOIN T_TODAY_USER T ON(U.user_id=T.user_id)
			WHERE U.reg_ts >= p_date_ts AND U.reg_ts < p_1day_ts
			AND T.today = p_2day_ts;
		END IF;
		IF p_6day_ts < p_today_ts
		THEN
			SELECT COUNT(U.user_id) INTO p_6day_num FROM T_USER U INNER JOIN T_TODAY_USER T ON(U.user_id=T.user_id)
			WHERE U.reg_ts >= p_date_ts AND U.reg_ts < p_1day_ts
			AND T.today = p_6day_ts;
		END IF;
		
		insert into T_STAT_RETENTION_SERVER(`date`,site_id,server_id,reg_num,`1dr`,`2dr`,`6dr`)
		select p_date,p_site,p_server,p_reg_num,p_1day_num/p_reg_num,p_2day_num/p_reg_num,p_6day_num/p_reg_num;
		
		insert into T_STAT_RETENTION_PLAT (`date`,site_id,server_id,plat_id,today_reg)
		SELECT p_date,p_site,p_server,plat,COUNT(user_id)
		FROM T_USER
		WHERE reg_ts >= p_date_ts AND reg_ts < p_1day_ts GROUP BY plat;
		UPDATE T_STAT_RETENTION_PLAT c,(SELECT COUNT(DISTINCT(a.user_id)) retention_num,a.plat plat_id FROM T_USER a INNER JOIN T_TODAY_USER b ON (a.user_id=b.user_id) WHERE a.reg_ts >= p_date_ts AND a.reg_ts < p_1day_ts AND b.today=p_1day_ts GROUP BY a.plat )d
		SET c.1day_num = d.retention_num
		WHERE c.plat_id=d.plat_id
		AND c.date = p_date;
		
		UPDATE T_STAT_RETENTION_PLAT c,(SELECT COUNT(DISTINCT(a.user_id)) retention_num,a.plat plat_id FROM T_USER a INNER JOIN T_TODAY_USER b ON (a.user_id=b.user_id) WHERE a.reg_ts >= p_date_ts AND a.reg_ts < p_1day_ts AND b.today=p_2day_ts GROUP BY a.plat )d
		SET c.2day_num = d.retention_num
		WHERE c.plat_id=d.plat_id
		AND c.date = p_date;
		
		UPDATE T_STAT_RETENTION_PLAT c,(SELECT COUNT(DISTINCT(a.user_id)) retention_num,a.plat plat_id FROM T_USER a INNER JOIN T_TODAY_USER b ON (a.user_id=b.user_id) WHERE a.reg_ts >= p_date_ts AND a.reg_ts < p_6day_ts AND b.today=p_6day_ts GROUP BY a.plat )d
		SET c.6day_num = d.retention_num
		WHERE c.plat_id=d.plat_id
		AND c.date = p_date;
		set p_date = DATE_ADD(p_date, interval 1 day);
	end while;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_SERVER_STAT`( in p_site int(10), in p_server int(10),in p_date_ts int(12))
BEGIN
    declare p_date varchar(32);
    declare p_yesterday int default 0;
    declare p_tomorrow int default 0;
    declare p_dau int default 0;
    declare p_reg int default 0;
    declare p_amount int default 0;
    declare p_dpu int default 0;
    declare p_yesterday_reg int default 0;
    declare p_yesterday_on int default 0;
    declare p_1dr float default 0.0000;
    declare p_month_1 varchar(32);
    declare p_month_ts int default 0;
    declare p_total_reg int default 0;
    declare p_total_amount int default 0;
    declare p_total_pu int default 0;
    declare p_mau int default 0;
    SET p_date = FROM_UNIXTIME(p_date_ts);
    set p_yesterday = p_date_ts - 86400;
    set p_tomorrow = p_date_ts + 86400;
    set p_month_1 = date_add(CURDATE(),INTERVAL -day(curdate())+1 day);
    set p_month_ts = UNIX_TIMESTAMP(p_month_1);
    SELECT COUNT(user_id) INTO p_reg FROM T_USER WHERE reg_ts >= p_date_ts AND reg_ts < p_tomorrow;
    select count(distinct(user_id)) into p_dau from T_TODAY_USER where today = p_date_ts;
    select IFNULL(sum(amount),0) into p_amount from T_USER_CHARGE where create_ts >= p_date and create_ts < FROM_UNIXTIME(p_tomorrow);
    select IFNULL(count(distinct(user_id)),0) into p_dpu from T_USER_CHARGE where create_ts >= p_date AND create_ts < FROM_UNIXTIME(p_tomorrow);
    select count(user_id) into p_yesterday_reg from T_USER where reg_ts >= p_yesterday AND reg_ts < p_date_ts;
    select count(distinct(a.user_id)) into p_yesterday_on from T_USER a inner join T_TODAY_USER b
     on (a.user_id=b.user_id) where a.reg_ts>=p_yesterday and a.reg_ts < p_date_ts and b.today=p_date_ts;
     
     IF p_yesterday_reg > 0 
     then 
	set p_1dr = p_yesterday_on / p_yesterday_reg; 
     end if;
     
    select count(user_id) into p_total_reg from T_USER where reg_ts>=p_month_ts and reg_ts < p_tomorrow;
    
    select count(distinct(a.user_id))+p_total_reg into p_mau from T_TODAY_USER a inner join T_USER b
    on (a.user_id=b.user_id) where a.today >= p_month_ts and a.today < p_tomorrow
    and b.reg_ts < p_month_ts;
  
    select ifnull(sum(amount),0) into p_total_amount from T_USER_CHARGE where create_ts>= p_month_1 and create_ts < FROM_UNIXTIME(p_tomorrow);
   
    select ifnull(count(distinct(user_id)),0) into p_total_pu from T_USER_CHARGE where create_ts >= p_month_1 and create_ts < FROM_UNIXTIME(p_tomorrow); 
     delete from T_STAT_SERVER where `date` = p_date;
     insert into T_STAT_SERVER(`date`,site_id,server_id,dau,reg,amount,dpu,`1dr`,arpu,arppu,pr,total_reg,mau,total_amount,total_pu,total_arpu,total_arppu,total_pr)
    select p_date,p_site,p_server,p_dau,p_reg,p_amount,p_dpu,p_1dr,p_amount/p_dau,p_amount/p_dpu,p_dpu/p_dau,p_total_reg,p_mau,p_total_amount,p_total_pu,p_total_amount/p_mau,p_total_amount/p_total_pu,p_total_pu/p_mau;
   delete from T_STAT_PLAT where `date` = p_date;
    insert into T_STAT_PLAT(`date`,site_id,server_id,plat_id,total_reg)
    select p_date,p_site,p_server,plat,count(user_id)
    from T_USER
    WHERE reg_ts >= p_month_ts AND reg_ts < p_tomorrow GROUP BY plat;
    update T_STAT_PLAT a,(select count(user_id) usernum,plat from T_USER where reg_ts >= p_date_ts and reg_ts < p_tomorrow group by plat)b
    set a.today_reg = b.usernum
    where a.plat_id=b.plat
    and a.date = p_date;
    UPDATE T_STAT_PLAT a,(select count(distinct(user_id)) usernum,plat from T_TODAY_USER where today >= p_date_ts and today < p_tomorrow group by plat)b
    SET a.dau = b.usernum
    WHERE a.plat_id=b.plat
    AND a.date = p_date;
    UPDATE T_STAT_PLAT a,(select ifnull(sum(amount),0) useramount,plat from T_USER_CHARGE where create_ts >= p_date and create_ts< FROM_UNIXTIME(p_tomorrow) group by plat)b
    SET a.amount = b.useramount
    WHERE a.plat_id=b.plat
    AND a.date = p_date;
    UPDATE T_STAT_PLAT a,(select ifnull(count(distinct(user_id)),0) usernum,plat from T_USER_CHARGE where create_ts >=p_date AND create_ts< FROM_UNIXTIME(p_tomorrow) GROUP BY plat)b
    SET a.pu = b.usernum
    WHERE a.plat_id=b.plat
    AND a.date = p_date;
     UPDATE T_STAT_PLAT a,(SELECT IFNULL(SUM(amount),0) useramount,plat FROM T_USER_CHARGE WHERE create_ts >= p_month_1 AND create_ts< FROM_UNIXTIME(p_tomorrow) GROUP BY plat)b
    SET a.total_amount = b.useramount
    WHERE a.plat_id=b.plat
    AND a.date =p_date;
    UPDATE T_STAT_PLAT a,(SELECT IFNULL(COUNT(DISTINCT(user_id)),0) usernum,plat FROM T_USER_CHARGE WHERE create_ts >= p_month_1 AND create_ts< FROM_UNIXTIME(p_tomorrow) GROUP BY plat)b
    SET a.total_pu = b.usernum
    WHERE a.plat_id=b.plat
    AND a.date = p_date;
    
    update T_STAT_PLAT c,(select count(distinct(a.user_id)) mau_num ,a.plat plat_id from T_TODAY_USER a inner join T_USER b
    on (a.user_id=b.user_id) where a.today >= p_month_ts and a.today < p_tomorrow and b.reg_ts < p_month_ts group by a.plat) d
    set c.mau = c.total_reg+d.mau_num
    where c.plat_id=d.plat_id
    AND c.date = p_date;
    
    update T_STAT_PLAT c,(select count(user_id) reg_num ,plat from T_USER where reg_ts>=p_yesterday and reg_ts < p_date_ts group by plat)d
    set c.yesterday_reg=d.reg_num
    where c.plat_id=d.plat
    and c.date = p_date;
    
    update T_STAT_PLAT c,(select count(distinct(a.user_id)) retention_num,a.plat plat_id from T_USER a inner join T_TODAY_USER b on (a.user_id=b.user_id) where a.reg_ts >= (p_date_ts - 86400) and a.reg_ts < p_date_ts and b.today=p_date_ts group by a.plat )d
    set c.yesterday_regon = d.retention_num
    where c.plat_id=d.plat_id
    and c.date = p_date;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_STAT_CHARGE_MONTH`(IN p_site INT(10), IN p_server INT(10))
BEGIN
	DECLARE p_date VARCHAR(32) DEFAULT '';
	DECLARE p_next VARCHAR(32) DEFAULT '';
	DECLARE p_reg_num INT(12) DEFAULT 0;
	DECLARE p_1day_num INT(12) DEFAULT 0;
	DECLARE p_2day_num INT(12) DEFAULT 0;
	DECLARE p_6day_num INT(12) DEFAULT 0;
	DECLARE p_1day_ts INT(12) DEFAULT 0;
	DECLARE p_2day_ts INT(12) DEFAULT 0;
	DECLARE p_6day_ts INT(12) DEFAULT 0;
	set p_date = '2013-09-01';
	
	while p_date < '2014-05-01'
	do
		set p_next = date_add(p_date,INTERVAL 1 MONTH);
		
		insert into T_STAT_CHARGE_MONTH_PLAT(`date`,`site_id`,`server_id`,`plat_id`,amount)
		SELECT p_date,p_site,p_server,plat,IFNULL(SUM(amount),0) 
		FROM T_USER_CHARGE  
		where create_ts>=p_date and create_ts < p_next
		group by plat;
		set p_date = p_next;
	end while;
	select 1;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_USER_CHALLENGE_GET`(IN p_user_id INT UNSIGNED,
	IN p_time INT UNSIGNED)
BEGIN
	DECLARE v_rank,v_count,v_level,v_leader_sid, v_leader_level, v_leader_dress_id INT UNSIGNED;
	DECLARE v_name VARCHAR(50);

	SELECT U.user_name, U.user_lv, W.warrior_id, W.warrior_lv, W.dress_id 
		INTO v_name, v_level, v_leader_sid, v_leader_level, v_leader_dress_id
	FROM T_USER U 
		INNER JOIN T_USER_FORMATION F 
			ON U.user_id = p_user_id AND F.user_id = U.user_id AND F.pos_status = 2
		INNER JOIN T_USER_WARRIOR W 
			ON W.user_id = U.user_id AND F.warrior_id = W.warrior_id;

	SELECT COUNT(1) INTO v_count
		FROM T_USER_CHALLENGE
	WHERE user_id = p_user_id;

	IF(v_count = 0) THEN
		INSERT INTO T_USER_CHALLENGE
		(
			user_id,
			name,
			level,
			leader_sid,
			leader_level,
			best_rank,
			rank,
			rank_ts,
			point,
			remain_ch_times,
			last_ch_ts,
			boss_win_times,
			boss_times,
			last_boss_ts,
			rewards,
			leader_dress_id
		)
		VALUES
		(
			p_user_id, 
			v_name, 
			v_level, 
			v_leader_sid, 
			v_leader_level, 
			0,
			0,
			p_time,
			0,
			0,
			0,
			0,
			0,
			0,
			'[]',
			v_leader_dress_id
		);

		UPDATE T_USER_CHALLENGE
		SET rank = id,
			best_rank = id
		WHERE user_id = p_user_id;
	ELSE
		UPDATE T_USER_CHALLENGE
		SET name = v_name,
			level = v_level,
			leader_sid = v_leader_sid,
			leader_level = v_leader_level,
			leader_dress_id = v_leader_dress_id
		WHERE user_id = p_user_id;
	END IF;

	SELECT
		name,
		level,
		leader_sid,
		leader_level,
		best_rank,
		rank,
		rank_ts,
		point,
		remain_ch_times,
		last_ch_ts,
		boss_times,
		boss_win_times,
		last_boss_ts,
		rewards,
		leader_dress_id,
		win,
		lose,
		my_win,
		my_lose
	FROM T_USER_CHALLENGE
	WHERE user_id = p_user_id;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_USER_CHALLENGE_LOSE`(IN p_user_id INT UNSIGNED,
	IN p_lose	INT UNSIGNED,	
	IN p_point	INT UNSIGNED,IN p_my_lose	INT UNSIGNED,
  IN p_target_user_id INT UNSIGNED,
	IN p_target_win	INT UNSIGNED)
BEGIN
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	SET AUTOCOMMIT = 0;

	UPDATE T_USER_CHALLENGE
	SET 
		lose = p_lose,
		my_lose = p_my_lose,
		point = p_point
	WHERE 
		user_id = p_user_id;

	IF(p_target_user_id > 0)
	THEN
		UPDATE T_USER_CHALLENGE 
		SET 
			win = p_target_win
		WHERE
			user_id = p_target_user_id;
	END IF;

	COMMIT;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_USER_CHALLENGE_WIN`(IN p_user_id INT UNSIGNED,
	IN p_best_rank INT UNSIGNED,
	IN p_rank	INT UNSIGNED,
	IN p_rank_ts	INT UNSIGNED,
	IN p_point	INT UNSIGNED,
	IN p_ch_ts	INT UNSIGNED,
  IN p_win	INT UNSIGNED, IN p_my_win	INT UNSIGNED,	
  IN p_target_user_id INT UNSIGNED,
	IN p_target_rank	INT UNSIGNED,
	IN p_target_rank_ts	INT UNSIGNED,
	IN p_target_lose	INT UNSIGNED)
BEGIN
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	SET AUTOCOMMIT = 0;

	UPDATE T_USER_CHALLENGE
	SET 
		best_rank = p_best_rank,
		rank = p_rank,
		rank_ts = p_rank_ts,
		point = p_point,
		last_ch_ts = p_ch_ts,
		win = p_win,
		my_win = p_my_win
	WHERE 
		user_id = p_user_id;

	IF(p_target_user_id > 0)
	THEN
		UPDATE T_USER_CHALLENGE 
		SET 
			rank = p_target_rank,
			rank_ts = p_target_rank_ts,
			lose = p_target_lose
		WHERE
			user_id = p_target_user_id;
	END IF;

	COMMIT;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `SP_P_USER_LIMIT_TIME_DRAW_CARD`()
BEGIN

	DECLARE tbl INT;
	DECLARE tblname CHAR(36);
	DECLARE curdt CHAR(8);
	SET curdt=REPLACE(DATE_ADD(CURDATE(),INTERVAL -1 DAY),'-','');
	SET tblname=CONCAT('P_USER_LIMIT_TIME_DRAW_CARD_',curdt);

	SELECT COUNT(0) INTO tbl  FROM information_schema.TABLES WHERE TABLE_SCHEMA='PiLi_GameDB' AND TABLE_NAME=tblname;
	IF tbl=0 THEN
		SET @a=CONCAT('CREATE TABLE ',tblname,'(',
		'id int(11) unsigned NOT NULL,
		user_id int(11) NOT NULL,
    name varchar(300) DEFAULT '''',
		active_id int(10) DEFAULT NULL,
		point int(10) NOT NULL,
		create_ts int(11) NOT NULL,
		update_ts int(11) NOT NULL,
		is_award int(11) NOT NULL DEFAULT ''0''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;');
	PREPARE cmd FROM @a;
	
	EXECUTE cmd;

	
	set @b=CONCAT('INSERT INTO ',tblname ,' SELECT * FROM P_USER_LIMIT_TIME_DRAW_CARD;');
	PREPARE cmd FROM @b;
	
	EXECUTE cmd;	
	
	DEALLOCATE PREPARE cmd;
	
 ELSE
	
	set @c=CONCAT('INSERT INTO ',tblname ,' SELECT * FROM P_USER_LIMIT_TIME_DRAW_CARD;');
	PREPARE cmd FROM @c;
	
	EXECUTE cmd;	
	DEALLOCATE PREPARE cmd;

	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `SP_T_USER_EXCHANGE`()
BEGIN

	DECLARE tbl INT;
	DECLARE tblname CHAR(36);
	DECLARE curdt CHAR(8);
	SET curdt=REPLACE(DATE_ADD(CURDATE(),INTERVAL 0 DAY),'-','');
	SET tblname=CONCAT('T_USER_EXCHANGE_',curdt);
	
	SELECT COUNT(0) INTO tbl  FROM information_schema.TABLES WHERE TABLE_SCHEMA='PiLi_GameDB' AND TABLE_NAME=tblname;
	IF tbl=0 THEN
			SET @a=CONCAT('ALTER TABLE T_USER_EXCHANGE ',' RENAME TO ',tblname);
			PREPARE cmd FROM @a;
			
			EXECUTE cmd;

			SET @b=CONCAT('CREATE TABLE T_USER_EXCHANGE (
										id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT ''自增编号'',
										activity_id int(10) unsigned NOT NULL COMMENT ''活动编号'',
										user_id int(10) unsigned NOT NULL COMMENT ''玩家编号'',
										contribute int(10) unsigned NOT NULL DEFAULT ''0'' COMMENT ''贡献值'',
										total_contribute int(10) unsigned NOT NULL DEFAULT ''0'' COMMENT ''总贡献度'',
										global_reward int(11) unsigned NOT NULL COMMENT ''全局奖励领取情况 2进制'',
										rank_reward bit(1) NOT NULL DEFAULT b''0'' COMMENT ''排名奖励是否已发放'',
										refresh_ts int(10) unsigned NOT NULL DEFAULT ''0'' COMMENT ''刷新时间'',
										ex_item1 int(10) unsigned NOT NULL DEFAULT ''0'' COMMENT ''兑换组合1'',
										ex_item2 int(10) unsigned NOT NULL DEFAULT ''0'' COMMENT ''兑换组合2'',
										ex_item3 int(11) unsigned NOT NULL DEFAULT ''0'' COMMENT ''兑换组合3'',
										ex_item1_status smallint(2) NOT NULL DEFAULT ''0'',
										ex_item2_status smallint(2) NOT NULL DEFAULT ''0'',
										ex_item3_status smallint(2) NOT NULL DEFAULT ''0'',
										PRIMARY KEY (id),
										UNIQUE KEY idx (activity_id,user_id),
										KEY tc (total_contribute,activity_id)) ENGINE=InnoDB  DEFAULT CHARSET=utf8;');

			PREPARE cmd FROM @b;
			
			EXECUTE cmd;

			DEALLOCATE PREPARE cmd;
	ELSE
			SELECT 'Repeat craete table Error!' AS Msg;
	END IF;
		
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-10 15:19:12
