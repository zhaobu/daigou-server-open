DROP PROCEDURE IF EXISTS `delete_userby_id`;
delimiter ;;
CREATE PROCEDURE `delete_userby_id`(in _user_id INT)
BEGIN

delete from user where user_id = _user_id;
delete from user_login_records where user_id = _user_id;
delete from user_address where user_id = _user_id;
delete from vip_recharge_records where user_id = _user_id;
delete from shop_info where user_id = _user_id;
delete from shop_wallet where shop_id = _user_id;
delete from shop_vip where user_id = _user_id;
delete from shop_fans where user_id = _user_id;
delete from shop_access_records where user_id = _user_id;
delete from shop_profit where user_id = _user_id;
delete from orders where user_id = _user_id;
delete from goods_access_records where user_id = _user_id;

END
;;
delimiter ;