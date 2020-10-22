DROP PROCEDURE IF EXISTS `set_auto_increment`;
delimiter ;;
CREATE PROCEDURE `set_auto_increment`(in db VARCHAR(10))
BEGIN
	DECLARE
		end_flag INT DEFAULT 0;
	DECLARE
		tmp_table_name VARCHAR ( 256 );
	DECLARE
		album_curosr CURSOR FOR ( SELECT table_name FROM information_schema.TABLES WHERE table_schema = db AND table_type = 'BASE TABLE' );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET end_flag = 1;
	OPEN album_curosr;
	REPEAT
			FETCH album_curosr INTO tmp_table_name;
		IF
			tmp_table_name <=> "user" THEN
				
				SET @sqlStr = CONCAT( 'ALTER TABLE ', tmp_table_name, ' auto_increment=1000000;' );
			ELSE 
				SET @sqlStr = CONCAT( 'ALTER TABLE ', tmp_table_name, ' auto_increment=1;' );
			
		END IF;
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