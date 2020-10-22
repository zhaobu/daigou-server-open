set @user_id := 1000082;

delete from user where user_id = @user_id
delete from user_login_records where user_id = @user_id
delete from user_address where user_id = @user_id
delete from vip_recharge_records where user_id = @user_id
delete from shop_info where user_id = @user_id
delete from shop_wallet where shop_id = @user_id
delete from shop_vip where user_id = @user_id
delete from shop_fans where user_id = @user_id
delete from shop_access_records where user_id = @user_id
delete from orders_profit where user_id = @user_id
delete from orders where user_id = @user_id
delete from goods_access_records where user_id = @user_id

