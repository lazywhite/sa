-- MySQL dump 10.13  Distrib 5.5.24, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: PiLi_ConfigDB
-- ------------------------------------------------------
-- Server version	5.5.24-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'PiLi_ConfigDB'
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `sp_t_log`()
    COMMENT '更新T_USER.act_date时间'
BEGIN

	DECLARE v_tbl CHAR(8);
	DECLARE v_dt INT;
	DECLARE v_n_dt INT;
	SET v_dt = UNIX_TIMESTAMP(DATE_ADD(CURDATE(),INTERVAL -1 DAY));
	SET v_n_dt = UNIX_TIMESTAMP(CURDATE());
	SET v_tbl=REPLACE(DATE_ADD(CURDATE(),INTERVAL -1 DAY),'-','');
	TRUNCATE TABLE t_log;
	
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	SET SESSION bulk_insert_buffer_size = 1*1024*1024*1024;
	
	SET AUTOCOMMIT=0;
		SET @a=CONCAT('INSERT INTO t_log(user_id,reg_ts,log_ts)',' SELECT DISTINCT user_id,DATE_ADD(CURDATE(),INTERVAL -1 DAY) reg_ts,CAST(FROM_UNIXTIME(log_ts)AS DATE)log_ts',
		' FROM PiLi_LogDB.T_LOG_',v_tbl,'  WHERE user_id>=1 ',' AND log_ts< ',v_n_dt);
		PREPARE cmd FROM @a;
		
		EXECUTE cmd;
		DEALLOCATE PREPARE cmd;
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
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 PROCEDURE `sp_t_user_loadinfo`()
BEGIN


	SET @gmt_time=DATE_ADD(CURDATE(),INTERVAL -1 DAY);
	
	SET @a=CONCAT('SELECT COUNT(0) INTO @total_regs FROM PiLi_GameDB.T_USER WHERE CAST(FROM_UNIXTIME(reg_ts) AS datetime)<CURDATE();');
	PREPARE cmd FROM @a;
	EXECUTE cmd;
	

	
	SET @b=CONCAT('SELECT COUNT(0) INTO @act_regs FROM PiLi_GameDB.T_USER WHERE CAST(FROM_UNIXTIME(logout_ts) AS datetime)>=DATE_ADD(CURDATE(),INTERVAL -1 DAY) AND CAST(FROM_UNIXTIME(logout_ts) AS datetime)<CURDATE();');
	PREPARE cmd FROM @b;
	EXECUTE cmd;

	

	
	SET @c=CONCAT('	SELECT COUNT(0) INTO @day_regs
	 FROM PiLi_GameDB.T_USER WHERE CAST(FROM_UNIXTIME(reg_ts) AS datetime)>=DATE_ADD(CURDATE(),INTERVAL -1 DAY) AND CAST(FROM_UNIXTIME(reg_ts) AS datetime)<CURDATE();');
	PREPARE cmd FROM @c;
	EXECUTE cmd;


	
	SET @d=CONCAT('SELECT SUM(amount),COUNT(DISTINCT user_id),COUNT(0) INTO @total_amount,@total_pay_users,@total_pay_num
	FROM PiLi_GameDB.T_USER_CHARGE WHERE create_ts<CURDATE();');
	PREPARE cmd FROM @d;
	EXECUTE cmd;

	
	SET @e=CONCAT('SELECT SUM(amount),COUNT(DISTINCT user_id),COUNT(0) INTO @day_amount, @day_pay_users,@day_pay_num
	FROM PiLi_GameDB.T_USER_CHARGE WHERE create_ts>=DATE_ADD(CURDATE(),INTERVAL -1 DAY) AND create_ts<CURDATE();');
	PREPARE cmd FROM @e;
	EXECUTE cmd;

	DEALLOCATE PREPARE cmd;
	
	IF @total_regs>0 THEN
		INSERT INTO t_user_loadinfo(gmt_time,total_regs,act_regs,day_regs,total_amount,total_pay_users,total_pay_num,day_amount,day_pay_users,day_pay_num)
		SELECT @gmt_time,@total_regs,@act_regs,@day_regs,@total_amount,@total_pay_users,@total_pay_num,@day_amount,@day_pay_users,@day_pay_num;
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

-- Dump completed on 2015-11-10 15:15:30
