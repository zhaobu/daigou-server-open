DROP PROCEDURE IF EXISTS `truncate_all_tables`;
delimiter ;;
CREATE PROCEDURE `truncate_all_tables`(in db VARCHAR(10))
BEGIN
	DECLARE
		tmp_table_name VARCHAR ( 256 );
	DECLARE
		end_flag INT DEFAULT 0;
	DECLARE
		album_curosr CURSOR FOR ( SELECT table_name FROM information_schema.TABLES WHERE table_schema = db AND table_type = 'BASE TABLE' );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET end_flag = 1;
	OPEN album_curosr;
	REPEAT
			FETCH album_curosr INTO tmp_table_name;
		
		SET @sqlStr = CONCAT( 'TRUNCATE TABLE daigou.', tmp_table_name);
		PREPARE stmt 
		FROM
			@sqlStr;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		UNTIL end_flag 
	END REPEAT;
CLOSE album_curosr;
END
;;
delimiter ;