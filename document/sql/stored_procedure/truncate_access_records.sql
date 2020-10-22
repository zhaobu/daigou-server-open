DROP PROCEDURE IF EXISTS `truncate_access_records`;
delimiter ;;
CREATE PROCEDURE `truncate_access_records`()
BEGIN
truncate TABLE goods_access_records;
truncate TABLE shop_access_records;
truncate TABLE user_login_records;
END
;;
delimiter ;