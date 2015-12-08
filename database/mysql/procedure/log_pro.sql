-- MySQL dump 10.13  Distrib 5.5.24, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: PiLi_LogDB
-- ------------------------------------------------------
-- Server version	5.5.24-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'PiLi_LogDB'
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_ARCHIVE_LOG`()
BEGIN
  DECLARE p_tbl_date VARCHAR(10);
	DECLARE p_recent_date INT UNSIGNED;
	DECLARE p_recent_sys_util_date DATE;
  
  SET p_tbl_date=REPLACE(ADDDATE(CURDATE(),INTERVAL -1 DAY),'-','');
	SET p_recent_date = UNIX_TIMESTAMP(CURDATE());
	SET p_recent_sys_util_date =  CURDATE();


	TRUNCATE TABLE T_LOG_RECENT;
  TRUNCATE TABLE T_LOG_SYS_UTIL_RECENT;


	SET @a=CONCAT('INSERT INTO T_LOG_RECENT
	(
		trans_id,
		sequence,
		category,
		user_id,
		title,
		content,
		operate_id,
		log_ts,
		related1,
		related2,
		related3,
		related4,
		user_call
	)
	SELECT
		trans_id,
		sequence,
		category,
		user_id,
		title,
		content,
		operate_id,
		log_ts,
		related1,
		related2,
		related3,
		related4,
		user_call
	FROM T_LOG_',p_tbl_date,' WHERE log_ts < ',p_recent_date);
	PREPARE cmd FROM @a;
  EXECUTE cmd;
	DEALLOCATE PREPARE cmd;


	INSERT INTO T_LOG_SYS_UTIL_RECENT
	(
		date,
		user_id,
		pve,
		wonder,
		tower,
		challenge,
		sign_up,
		draw_card,
		cup,
		equip_enhance,
		warrior_train,
		warrior_up,
		eat_chicken
	)
	SELECT
		date,
		user_id,
		pve,
		wonder,
		tower,
		challenge,
		sign_up,
		draw_card,
		cup,
		equip_enhance,
		warrior_train,
		warrior_up,
		eat_chicken
	FROM T_LOG_SYS_UTIL
	WHERE date < p_recent_sys_util_date;

	DELETE FROM T_LOG_SYS_UTIL WHERE date < p_recent_sys_util_date;

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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_ECONOMY_STAT`(IN p_date DATE)
BEGIN
	DECLARE v_max_date DATE;
	SET v_max_date = DATE_ADD(p_date, INTERVAL 1 DAY);
    TRUNCATE TABLE T_ECONOMY_TODAY;
    INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,1, A.vip,1,B.related1, B.get_num
    FROM T_KPI_USER A 
    inner JOIN 
    (
      SELECT user_id, related1, SUM(related2) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 1001 and related1 in (10018,10011,10012,10013,10014,10015,10016,10019,10020,10017,10024,10004)
      GROUP BY user_id, related1
    ) B
    ON A.user_id = B.user_id;











   INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,1, A.vip,2,0, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, SUM(related1) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 1811 
      GROUP BY user_id
    ) B
    ON A.user_id = B.user_id;    
    
    INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,1, A.vip,3,0, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, SUM(related1) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 1813 
      GROUP BY user_id
    ) B
    ON A.user_id = B.user_id;  
    
	INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,1, A.vip,4,B.related3, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, related3,SUM(related2) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 2401 
      GROUP BY user_id,related3
    ) B
    ON A.user_id = B.user_id;  
    
    INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,2, A.vip,1,B.related1, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, related1, SUM(related2) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 1003 AND related1 IN (10018,10011,10012,10013,10014,10015,10016,10019,10020,10017,10024,10004)
      GROUP BY user_id, related1
    ) B
    ON A.user_id = B.user_id;
    
   INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,2, A.vip,2,0, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, SUM(related1) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 1812
      GROUP BY user_id
    ) B
    ON A.user_id = B.user_id;    
    
    INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,2, A.vip,3,0, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, SUM(related2) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 1601
      GROUP BY user_id
    ) B
    ON A.user_id = B.user_id;      
    INSERT INTO T_ECONOMY_TODAY
    (user_id,type, vip, item_type, item_id,item_num)
    SELECT A.user_id,2, A.vip,4,B.related3, B.get_num
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      SELECT user_id, related3,SUM(related2) get_num
      FROM T_LOG_RECENT
      WHERE log_ts >= UNIX_TIMESTAMP(p_date) AND log_ts < UNIX_TIMESTAMP(v_max_date)
      AND operate_id = 2403
      GROUP BY user_id,related3
    ) B
    ON A.user_id = B.user_id;   
    
    
    insert into T_ECONOMY_STAT(date, item_type, item_id, get_r, use_r, get_ur, use_ur)
    select DISTINCT p_date, item_type , item_id, 0, 0, 0, 0 FROM T_ECONOMY_TODAY;
	
	UPDATE T_ECONOMY_STAT A
	INNER JOIN 
	(
		SELECT item_id,item_type, SUM(item_num) amount FROM T_ECONOMY_TODAY WHERE vip >= 2 AND vip <= 15 and type=1 GROUP BY item_type, item_id
	) B
	ON( A.item_id = B.item_id and A.item_type = B.item_type)
	SET A.get_r = B.amount
	WHERE A.date = p_date;
	UPDATE T_ECONOMY_STAT A
	INNER JOIN 
	(
		SELECT item_id,item_type, SUM(item_num) amount FROM T_ECONOMY_TODAY WHERE vip >= 2 AND vip <= 15 AND type=2 GROUP BY item_type, item_id
	) B
	ON( A.item_id = B.item_id AND A.item_type = B.item_type)
	SET A.use_r = B.amount
	WHERE A.date = p_date;
	
	
	UPDATE T_ECONOMY_STAT A
	INNER JOIN 
	(
		SELECT item_id,item_type, SUM(item_num) amount FROM T_ECONOMY_TODAY WHERE vip < 2 AND type=1 GROUP BY item_type, item_id
	) B
	ON( A.item_id = B.item_id AND A.item_type = B.item_type)
	SET A.get_ur = B.amount
	WHERE A.date = p_date;
	
	UPDATE T_ECONOMY_STAT A
	INNER JOIN 
	(
		SELECT item_id,item_type, SUM(item_num) amount FROM T_ECONOMY_TODAY WHERE vip < 2 AND type=2 GROUP BY item_type, item_id
	) B
	ON( A.item_id = B.item_id AND A.item_type = B.item_type)
	SET A.use_ur = B.amount
	WHERE A.date = p_date;
      
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_EQUIP_STAT`(IN p_date DATE,
	IN p_user_type SMALLINT UNSIGNED,
	IN p_min_vip INT UNSIGNED,
	IN p_max_vip INT UNSIGNED)
BEGIN
	DECLARE v_total_users INT UNSIGNED;

	SELECT COUNT(user_id) INTO v_total_users
	FROM T_USER_MONEY
	WHERE vip >= p_min_vip AND vip <= p_max_vip;

  IF(v_total_users = 0)
  THEN
    INSERT INTO T_EQUIP_STAT 
      SET `date` = p_date, 
      user_type = p_user_type;
  ELSE
    INSERT INTO T_EQUIP_STAT 
    SET
      `date` = p_date, 
      user_type = p_user_type,
      weapon2 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4)
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 1 AND E.color = 2
      ),
      armor2 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4)
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 2 AND E.color = 2
      ),
      ornament2 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4)
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 3 AND E.color = 2
      ), 
      treasure2 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 4 AND E.color = 2
      ), 
      weapon3 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 1 AND E.color = 3
      ), 
      armor3 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 2 AND E.color = 3
      ), 
      ornament3 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4)
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 3 AND E.color = 3
      ), 
      treasure3 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 4 AND E.color = 3
      ), 
      weapon4 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 1 AND E.color = 4
      ), 
      armor4 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 2 AND E.color = 4
      ), 
      ornament4 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 3 AND E.color = 4
      ), 
      treasure4 = (
        SELECT ROUND(COUNT(E.`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_PACKAGE_EQUIP E INNER JOIN T_USER_MONEY U 
          ON E.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND E.`type` = 4 AND E.color = 4
      );
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_KPI`(IN p_date INT UNSIGNED)
BEGIN
  DECLARE v_date DATE;
  DECLARE v_n_date DATE;
  DECLARE v_1_date DATE;
  DECLARE v_2_date DATE;
  DECLARE v_3_date DATE;
  DECLARE v_6_date DATE;
  DECLARE v_7_date DATE;
  DECLARE v_14_date DATE;
  DECLARE v_15_date DATE;
  DECLARE v_30_date DATE;
  DECLARE v_7_date_ts INT UNSIGNED;
  DECLARE v_14_date_ts INT UNSIGNED;
  DECLARE v_21_date_ts INT UNSIGNED;
  DECLARE v_online_ts_i INT UNSIGNED;
  DECLARE v_online_ts_e INT UNSIGNED;
  DECLARE v_online_ts INT UNSIGNED;
  DECLARE v_faith_user_days SMALLINT UNSIGNED;
  DECLARE v_faith_user_weeks SMALLINT UNSIGNED;
  DECLARE v_1wu INT UNSIGNED;
  DECLARE v_1wau INT UNSIGNED;
  DECLARE v_1wapu INT UNSIGNED;
  DECLARE v_p int UNSIGNED;
  DECLARE v_done int DEFAULT 0;

  DECLARE cursor_plat CURSOR FOR select plat from T_USER group by plat;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

  SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  SET AUTOCOMMIT = 0;

  SET v_date = CAST(FROM_UNIXTIME(p_date) AS DATE);
  SET v_n_date = DATE_ADD(v_date, INTERVAL 1 DAY);
  SET v_1_date = DATE_ADD(v_date, INTERVAL -1 DAY);
  SET v_2_date = DATE_ADD(v_date, INTERVAL -2 DAY);
  SET v_3_date = DATE_ADD(v_date, INTERVAL -3 DAY);
  SET v_6_date = DATE_ADD(v_date, INTERVAL -6 DAY);
  SET v_7_date = DATE_ADD(v_date, INTERVAL -7 DAY);
  SET v_14_date = DATE_ADD(v_date, INTERVAL -14 DAY);
  SET v_15_date = DATE_ADD(v_date, INTERVAL -15 DAY);
  SET v_30_date = DATE_ADD(v_date, INTERVAL -30 DAY);
  SET v_7_date_ts = UNIX_TIMESTAMP(DATE_ADD(v_date, INTERVAL -7 DAY));
  SET v_14_date_ts = UNIX_TIMESTAMP(DATE_ADD(v_date, INTERVAL -14 DAY));
  SET v_21_date_ts = UNIX_TIMESTAMP(DATE_ADD(v_date, INTERVAL -21 DAY));
  SET v_online_ts_i = 900;
  SET v_online_ts_e = UNIX_TIMESTAMP(v_n_date);
  SET v_online_ts = p_date;
  SET v_faith_user_days = 5;

  TRUNCATE TABLE T_USER;
  TRUNCATE TABLE T_USER_CHARGE;
  TRUNCATE TABLE T_USER_MONEY;

  INSERT INTO T_USER
  (user_id,plat,plat_id,user_name,user_lv,user_exp,coins,power_value,update_ts,reg_ts,last_login_ts,last_rush_ts,award_version,logout_ts,device_type) 
  SELECT user_id,plat,plat_id,user_name,user_lv,user_exp,coins,power_value,update_ts,reg_ts,last_login_ts,last_rush_ts,award_version,logout_ts,device_type 
  FROM PiLi_GameDB.T_USER;

  INSERT INTO T_USER_CHARGE
  (user_id, plat, plat_id, amount, points, bonus, `level`, create_ts, order_id)
  SELECT user_id, plat, plat_id, amount, points, bonus, `level`, create_ts, order_id 
  FROM PiLi_GameDB.T_USER_CHARGE;

  INSERT INTO T_USER_MONEY
  (user_id,points,bonus,vip,vip_bag,total_points,total_bonus,total_points_consume,total_bonus_consume,last_pay_type,pow_times,pow_ts)
  SELECT user_id,points,bonus,vip,vip_bag,total_points,total_bonus,total_points_consume,total_bonus_consume,last_pay_type,pow_times,pow_ts
  FROM PiLi_GameDB.T_USER_MONEY;

#插入新用户
  SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
  INSERT INTO T_KPI_USER
  (user_id,plat,user_name, reg_date, active_date, cad, device_type)
  SELECT user_id,plat,user_name, CAST(FROM_UNIXTIME(reg_ts) AS DATE), CAST(FROM_UNIXTIME(reg_ts) AS DATE), 1, device_type
  FROM T_USER U
  WHERE NOT EXISTS (
    SELECT user_id 
    FROM T_KPI_USER 
    WHERE user_id = U.user_id
  );

#更新渠道号
  UPDATE T_KPI_USER KU
  INNER JOIN T_USER U 
  ON KU.user_id = U.user_id AND KU.plat <> U.plat
  SET KU.plat = U.plat;

#更新活跃时间，更新连续登陆天数，更新是否是7天前的用户再次登入
  UPDATE T_KPI_USER U
  INNER JOIN (
    SELECT DISTINCT user_id
    FROM T_LOG_RECENT 
    WHERE log_ts >= UNIX_TIMESTAMP(v_date) 
      AND log_ts < UNIX_TIMESTAMP(v_n_date)
      AND user_call = 1
  ) B ON U.user_id = B.user_id
  SET U.is_bu = IF(U.active_date <= v_7_date, 1, 0),
    U.active_date = v_date,
    U.cad = U.cad + 1
  WHERE U.active_date < v_date;

#重置连续登陆天数
  UPDATE T_KPI_USER
  SET cad = 0
  WHERE active_date < v_date;
#更新VIP变化
  UPDATE T_KPI_USER U
  INNER JOIN T_USER_MONEY M 
  ON U.user_id = M.user_id AND U.vip <> M.vip
  SET U.vip = M.vip;

	#更新登陆次数
  UPDATE T_KPI_USER U
  INNER JOIN (
    SELECT user_id, COUNT(id) AS login_times 
    FROM T_LOG_RECENT
    WHERE operate_id = 1801
      AND log_ts >= UNIX_TIMESTAMP(v_date)
      AND log_ts < UNIX_TIMESTAMP(v_n_date)
      AND user_call = 1
    GROUP BY user_id
  ) B ON U.user_id = B.user_id
  SET U.login_times = B.login_times
  WHERE U.active_date = v_date;
  
#更新首充的日期，金额，和距离开服有多少时间
  UPDATE T_KPI_USER U
    INNER JOIN (
      SELECT A.user_id, CAST(A.create_ts AS DATE) AS `date`, A.amount 
      FROM T_USER_CHARGE A 
        INNER JOIN (
          SELECT IFNULL(MIN(id), 0) AS id 
          FROM T_USER_CHARGE 
          GROUP BY user_id
        ) B
        ON A.id = B.id
    ) C 
    ON U.user_id = C.user_id
  SET U.fc_date = C.date,
      U.fc_amount = C.amount,
      U.fc_days = DATEDIFF(C.date, U.reg_date)
  WHERE U.fc_amount = 0;
  
#更新最近充值时间
  UPDATE T_KPI_USER U
    INNER JOIN (
       SELECT user_id  FROM T_USER_CHARGE WHERE CAST(create_ts AS DATE)= v_date group by user_id
    ) C 
    ON U.user_id = C.user_id
  SET U.c_date = v_date;
  
  #每日
  INSERT INTO T_KPI_DAILY
  SET `date` = v_date,
    dnu = (#日新用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_date
    ),
    dnu_ios = (#日新IOS用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_date AND device_type = 'ios'
    ),
    dnu_and = (#日新android用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_date AND device_type = 'android'
    ),
    dau = (#日活跃用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE active_date = v_date
    ),
    dpu = (#日付费用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE active_date = v_date
        and c_date = v_date
    ),
    dfu = (#日忠诚用户
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE active_date = v_date
        AND cad > v_faith_user_days
    ),
    `1du` = (#注册一天的用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_1_date
    ),
    `1dru` = (#1日留存
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_1_date
      AND active_date >= v_date
    ),
    `3du` = (#注册3天的用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_3_date
    ),
    `3dru` = (#3日留存
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_3_date
      AND active_date >= v_date
    ),
    `7du` = (#注册7天的用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_7_date
    ),
    `7dru` = (#7日留存
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_7_date
      AND active_date >= v_date
    ),
    `15du` = (#注册15天的用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_15_date
    ),
    `15dru` = (#15日留存
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_15_date
      AND active_date >= v_date
    ),
    `30du` = (#注册30天的用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_30_date
    ),
    `30dru` = (#30日留存
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date = v_30_date
      AND active_date >= v_date
    ),
    pcu = IFNULL((#最高在线人数
      SELECT IFNULL(MAX(`num`), 0)
      FROM T_ONLINE
      WHERE `date` = v_date
      GROUP BY `date`
    ), 0),
    acu = IFNULL((#平均在线人数
      SELECT IFNULL(ROUND(AVG(`num`), 1), 0)
      FROM T_ONLINE
      WHERE `date` = v_date
      GROUP BY `date`
    ), 0),
    alt = (#平均登录次数
      SELECT IFNULL(ROUND(AVG(login_times), 1), 0)
      FROM T_KPI_USER 
      WHERE active_date = v_date AND reg_date < v_date
    ),
    rev = (#日收入
      SELECT IFNULL(SUM(amount), 0)
      FROM T_USER_CHARGE
      WHERE create_ts >= v_date AND create_ts < v_n_date
    ),
    fcu = (#首充人数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE fc_date = v_date
    ),
    afca = (#平均首充金额
      SELECT IFNULL(ROUND(AVG(fc_amount), 2), 0)
      FROM T_KPI_USER 
      WHERE fc_date = v_date
    ),
    dbu = (#回流用户数
      SELECT COUNT(fc_amount)
      FROM T_KPI_USER 
      WHERE active_date = v_date
      AND is_bu = 1
    );

	OPEN cursor_plat;
		
		REPEAT
		
				FETCH cursor_plat into v_p;
				
				IF v_done = 0 THEN
					
					#每日
					INSERT INTO T_CHANNEL_KPI_DAILY
					SET `date` = v_date,
						plat = v_p,
						dnu = (#日新用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_date and plat = v_p
						),
						dau = (#日活跃用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE active_date = v_date and plat = v_p
						),
						rev = (#日收入
							SELECT IFNULL(SUM(amount), 0)
							FROM T_USER_CHARGE
							WHERE create_ts >= v_date AND create_ts < v_n_date and plat = v_p
						),
						dpu = (#日付费用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE active_date = v_date
								and c_date = v_date and plat = v_p
						),
						arev = (#新增充值
							SELECT IFNULL(SUM(amount), 0)
							FROM T_USER_CHARGE
							WHERE user_id in (
									SELECT user_id 
									FROM T_KPI_USER 
									WHERE reg_date >= v_date 
									AND reg_date < v_n_date 
									AND plat = v_p
							)
							AND create_ts >= v_date 
							AND create_ts < v_n_date
						),
						adpu = (#新增付费人数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE user_id in (
								SELECT user_id 
								FROM T_KPI_USER 
								WHERE reg_date >= v_date 
								AND reg_date < v_n_date 
								AND plat = v_p
							) 
							and active_date = v_date
							and c_date = v_date and plat = v_p
						),
						`1du` = (#注册一天的用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_1_date and plat = v_p
						),
						`1dru` = (#1日留存
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_1_date
							AND active_date >= v_date and plat = v_p
						),
						`3du` = (#注册3天的用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_3_date and plat = v_p
						),
						`3dru` = (#3日留存
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_3_date
							AND active_date >= v_date and plat = v_p
						),
						`7du` = (#注册7天的用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_7_date and plat = v_p
						),
						`7dru` = (#7日留存
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_7_date
							AND active_date >= v_date and plat = v_p
						),
						`15du` = (#注册15天的用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_15_date and plat = v_p
						),
						`15dru` = (#15日留存
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_15_date
							AND active_date >= v_date and plat = v_p
						),
						`30du` = (#注册30天的用户数
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_30_date and plat = v_p
						),
						`30dru` = (#30日留存
							SELECT COUNT(user_id) 
							FROM T_KPI_USER 
							WHERE reg_date = v_30_date
							AND active_date >= v_date and plat = v_p
						);

				END IF;

		UNTIL v_done END REPEAT;

	CLOSE cursor_plat;

  SET v_1wu = 0;#周新注册人数
  SET v_1wau = 0;#周活跃人数
  SET v_1wapu = 0;#周活跃付费人数

  SELECT wnu, wau, wapu 
    INTO v_1wu, v_1wau, v_1wapu
  FROM T_KPI_WEEKLY 
  WHERE `date` = v_7_date;

  INSERT INTO T_KPI_WEEKLY
  SET `date` = v_date,
    wau = (#周活跃用户数
      SELECT COUNT(user_id)
      FROM T_KPI_USER
      WHERE active_date > v_7_date AND active_date <= v_date
    ),
    wnu = (#周新注册用户数
      SELECT COUNT(user_id)
      FROM T_KPI_USER
      WHERE reg_date > v_7_date AND reg_date <= v_date
    ),
    wnu_ios = (#周新IOS用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date > v_7_date AND reg_date <= v_date AND device_type = 'ios'
    ),
    wnu_and = (#周新android用户数
      SELECT COUNT(user_id) 
      FROM T_KPI_USER 
      WHERE reg_date > v_7_date AND reg_date <= v_date AND device_type = 'android'
    ),
    wapu = (#周活跃付费用户数
      SELECT COUNT(user_id)
      FROM T_KPI_USER
      WHERE active_date > v_7_date AND active_date <= v_date
        AND fc_amount > 0
    ),
    wrnu = (#周留存新用户数
      SELECT COUNT(user_id)
      FROM T_KPI_USER
      WHERE reg_date > v_14_date AND reg_date <= v_7_date
        AND active_date > v_7_date
    ),
    `1wu` = v_1wu,#上周注册的用户数
    wcu = (#周流失用户数
      SELECT COUNT(user_id)
      FROM T_KPI_USER
      WHERE active_date > v_14_date AND active_date <= v_7_date
    ),
    `1wau` = v_1wau,#上周活跃用户数'
    wcpu = (#周付费用户流失数
      SELECT COUNT(user_id)
      FROM T_KPI_USER
      WHERE active_date > v_14_date AND active_date <= v_7_date
        AND fc_amount > 0
    ),
    `1wapu` = v_1wapu,#上周活跃付费用户数
    wfcu = (#周忠实用户数
      SELECT IFNULL(SUM(fcu),0)
      FROM T_KPI_DAILY
      WHERE `date` > v_7_date AND `date` <= v_date
    ),
    wafca = (#周平均首充金额
      SELECT IFNULL(ROUND(AVG(afca), 2),0)
      FROM T_KPI_DAILY
      WHERE `date` > v_7_date AND `date` <= v_date
    ),
    wrev = (#周收入
      SELECT IFNULL(SUM(rev), 0) 
      FROM T_KPI_DAILY
      WHERE `date` > v_7_date AND `date` <= v_date
    );

#插入当前日的所有等级及人数
  INSERT INTO T_LEVEL_STAT
  (`date`, `level`, `num`)
  SELECT v_date, user_lv, COUNT(user_id)
  FROM T_USER
  GROUP BY user_lv;

#更新当前日的等级等于7天前等级的数量
  UPDATE T_LEVEL_STAT L
  INNER JOIN (
    SELECT A.user_lv, COUNT(A.user_id) c_num
    FROM T_USER A INNER JOIN T_KPI_USER B
      ON A.user_id = B.user_id
    WHERE B.active_date = v_7_date
    GROUP BY A.user_lv
  ) C
  SET L.c_num = C.c_num
  WHERE L.`date` = v_date
    AND L.`level` = C.user_lv;

#流失用户等级统计
  INSERT INTO T_CHURN_LEVEL_STAT
  SET `date` = v_date,
    level_5 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` <= 5
    ),
    level_10 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` > 5 AND `level` <= 10
    ),
    level_15 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 10 AND `level` <= 15
    ),
    level_20 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 15 AND `level` <= 20
    ),
    level_25 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 20 AND `level` <= 25
    ),
    level_30 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 25 AND `level` <= 30
    ),
    level_35 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 30 AND `level` <= 35
    ),
    level_40 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 35 AND `level` <= 40
    ),
    level_45 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 40 AND `level` <= 45
    ),
    level_50 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 45 AND `level` <= 50
    ),
    level_55 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 50 AND `level` <= 55
    ),
    level_60 = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date 
        AND `level` >= 55
    ),
    total = (
      SELECT IFNULL(SUM(c_num),0) 
      FROM T_LEVEL_STAT 
      WHERE `date` = v_date
    );

#VIP统计
  INSERT INTO T_USER_VIP_STATA
  SET `date` = v_date,
    level_1 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 1
    ),
    level_2 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 2
    ),
    level_3 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 3
    ),
    level_4 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 4
    ),
    level_5 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 5
    ),
    level_6 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 6
    ),
    level_7 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 7
    ),
    level_8 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 8
    ),
    level_9 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 9
    ),
    level_10 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 10
    ),
    level_11 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 11
    ),
    level_12 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 12
    ),
    level_13 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 13
    ),
    level_14 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 14
    ),
    level_15 = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY 
      WHERE `vip` = 15
    ),
    total = (
      SELECT IFNULL(SUM(vip),0) 
      FROM T_USER_MONEY
    );

#系统使用率
  INSERT INTO T_SYS_UTIL
  SET `date` = v_date,
    pve = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND pve = 1
    ),
    wonder = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND wonder = 1
    ),
    tower = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND tower = 1
    ),
    challenge = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND challenge = 1
    ),
    sign_up = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND sign_up = 1
    ),
    draw_card = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND draw_card = 1
    ),
    cup = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND cup = 1
    ),
    equip_enhance = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND equip_enhance = 1
    ),
    warrior_train = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND warrior_train = 1
    ),
    warrior_up = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND warrior_up = 1
    ),
    eat_chicken = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND eat_chicken = 1
    ),
    sign_up_new = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND sign_up_new = 1
    ),
    warrior_enhance = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND warrior_enhance = 1
    ),
    skill_enhance = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND skill_enhance = 1
    ),
    refining = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND refining = 1
    ),
    wish = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND wish = 1
    ),
    explore_rush = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND explore_rush = 1
    ),
    explore_onemore = (
      SELECT COUNT(user_id)
      FROM T_LOG_SYS_UTIL_RECENT
      WHERE `date` = v_date
      AND explore_onemore = 1
    );
    CALL P_EQUIP_STAT(v_date, 1, 0, 1);
    CALL P_EQUIP_STAT(v_date, 2, 2, 4);
    CALL P_EQUIP_STAT(v_date, 3, 5, 8);
    CALL P_EQUIP_STAT(v_date, 4, 9, 11);
    CALL P_EQUIP_STAT(v_date, 5, 12, 13);
    
    CALL P_WARRIOR_STAT(v_date, 1, 0, 1);
    CALL P_WARRIOR_STAT(v_date, 2, 2, 4);
    CALL P_WARRIOR_STAT(v_date, 3, 5, 8);
    CALL P_WARRIOR_STAT(v_date, 4, 9, 11);
    CALL P_WARRIOR_STAT(v_date, 5, 12, 13);
    CALL P_PAYMENT_STAT(v_date);
    call P_ECONOMY_STAT(v_date);
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_PAYMENT_STAT`(IN p_date DATE)
BEGIN
	DECLARE v_max_date DATE;
	SET v_max_date = DATE_ADD(p_date, INTERVAL 1 DAY);

    TRUNCATE TABLE T_PAYMENT_TODAY;

    INSERT INTO T_PAYMENT_TODAY
    (user_id, vip, type, product_id, points)
    SELECT A.user_id, A.vip, B.con_type, B.con_id, B.points 
    FROM T_KPI_USER A 
    INNER JOIN 
    (
      
	  SELECT user_id, 1 con_type, con_id, SUM(points) points 
      FROM PiLi_GameDB.T_USER_CONSUME
      WHERE con_ts >= p_date AND con_ts < v_max_date
      GROUP BY user_id,  con_id
		
    ) B
    ON A.user_id = B.user_id;

	INSERT INTO T_PAYMENT_STAT
	(date, sys_type, product_id, huge, large, normal, little)
	SELECT DISTINCT p_date, type, product_id, 0, 0, 0, 0 FROM T_PAYMENT_TODAY;

	UPDATE T_PAYMENT_STAT A
	INNER JOIN 
	(
		SELECT product_id, SUM(points) amount FROM T_PAYMENT_TODAY WHERE vip >= 12 AND vip <= 15 GROUP BY product_id
	) B
	ON A.product_id = B.product_id
	SET A.huge = B.amount
	WHERE A.date = p_date;

	UPDATE T_PAYMENT_STAT A
	INNER JOIN 
	(
		SELECT product_id, SUM(points) amount FROM T_PAYMENT_TODAY WHERE vip >= 9 AND vip <= 11 GROUP BY product_id
	) B
	ON A.product_id = B.product_id
	SET A.large = B.amount
	WHERE A.date = p_date;

	UPDATE T_PAYMENT_STAT A
	INNER JOIN 
	(
		SELECT product_id, SUM(points) amount FROM T_PAYMENT_TODAY WHERE vip >= 5 AND vip <= 8 GROUP BY product_id
	) B
	ON A.product_id = B.product_id
	SET A.normal = B.amount
	WHERE A.date = p_date;

	UPDATE T_PAYMENT_STAT A
	INNER JOIN 
	(
		SELECT product_id, SUM(points) amount FROM T_PAYMENT_TODAY WHERE vip >= 2 AND vip <= 4 GROUP BY product_id
	) B
	ON A.product_id = B.product_id
	SET A.little = B.amount
	WHERE A.date = p_date;
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `P_WARRIOR_STAT`(IN p_date DATE,
  IN p_user_type SMALLINT UNSIGNED,
  IN p_min_vip INT UNSIGNED,
  IN p_max_vip INT UNSIGNED)
BEGIN
  DECLARE v_total_users INT UNSIGNED;

  SELECT COUNT(user_id) INTO v_total_users
  FROM T_USER_MONEY
  WHERE vip >= p_min_vip AND vip <= p_max_vip;

  IF(v_total_users = 0)
  THEN
    INSERT INTO T_WARRIOR_STAT 
      SET `date` = p_date, 
      user_type = p_user_type;
  ELSE
    INSERT INTO T_WARRIOR_STAT
    SET `date` = p_date,
      `user_type` = p_user_type,
      num1 = (
        SELECT ROUND(COUNT(`id`) / v_total_users, 4)
        FROM PiLi_GameDB.T_USER_WARRIOR W INNER JOIN T_USER_MONEY U 
          ON W.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND W.grade = 1
      ),
      num2 = (
        SELECT ROUND(COUNT(`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_WARRIOR W INNER JOIN T_USER_MONEY U 
          ON W.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND W.grade >= 2 AND W.grade <= 3
      ),
      num3 = (
        SELECT ROUND(COUNT(`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_WARRIOR W INNER JOIN T_USER_MONEY U 
          ON W.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND W.grade >= 4 AND W.grade <= 5
      ),
      num4 = (
        SELECT ROUND(COUNT(`id`) / v_total_users, 4) 
        FROM PiLi_GameDB.T_USER_WARRIOR W INNER JOIN T_USER_MONEY U 
          ON W.user_id = U.user_id
        WHERE U.vip >= p_min_vip AND U.vip <= p_max_vip
          AND W.grade >= 6
      );
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `SP_T_REQUEST_LOG_RENAME`()
BEGIN 
	DECLARE date VARCHAR(10); 
	DECLARE count INT; 
	DECLARE tablename VARCHAR(50); 
	DECLARE createnum int;  
	SET createnum=7; 
	WHILE createnum>=0 DO 
		SET date=REPLACE(LEFT(DATE_ADD(NOW(),INTERVAL createnum DAY),10),'-',''); 
		SET tablename=CONCAT('T_REQUEST_LOG_',date); 
		SELECT count(0) into count FROM information_schema.TABLES WHERE TABLE_SCHEMA='PiLi_LogDB' AND table_name=tablename; 
		IF count<>1 THEN 
			SET @a=CONCAT('CREATE TABLE ',tablename,'(',
			'id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
					service varchar(50) NOT NULL,
					method varchar(50) NOT NULL,
					args varchar(1024) NOT NULL,
					ms float unsigned NOT NULL,
					user_id int(12) unsigned NOT NULL DEFAULT ''0'',
					create_ts int(12) unsigned NOT NULL,
					PRIMARY KEY (id),
					KEY user_id (user_id),
					KEY ms (ms),
					KEY create_ts (create_ts)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8;');
			PREPARE cmd FROM @a; 
			EXECUTE cmd; 
			DEALLOCATE PREPARE cmd; 
		END IF; 
		SET createnum=createnum-1; 
	END WHILE;
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `SP_T_REQUEST_LOG_TRUN`()
BEGIN
	DECLARE tblname VARCHAR(50);
  DECLARE truntable TINYINT(11);
	DECLARE tblcnt TINYINT(11);
	SET truntable = 7;
	WHILE truntable>=0 DO
		SET tblname=CONCAT('T_REQUEST_LOG_',REPLACE(DATE_ADD(CURDATE(),INTERVAL -truntable-11 DAY),'-',''));
		SELECT COUNT(0) INTO tblcnt FROM information_schema.TABLES WHERE TABLE_SCHEMA='PiLi_LogDB' AND TABLE_NAME=tblname;
		IF tblcnt = 1 THEN
			SET @a = CONCAT('TRUNCATE TABLE ',tblname,';');
			PREPARE cmd FROM @a;
			
			EXECUTE cmd;

			SET @b = CONCAT('DROP TABLE ',tblname,';');
			PREPARE cmd FROM @b;
			
			EXECUTE cmd;
			DEALLOCATE PREPARE cmd;
		END IF;
	SET truntable = truntable -1;
	END WHILE;
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

-- Dump completed on 2015-11-10 15:17:54
