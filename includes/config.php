<?php
/*数据库配置*/
$dbconfig=array(
	'host' => getenv('DB_HOST') ?: 'mysql', //数据库服务器
	'port' => 3306, //数据库端口
	'user' => getenv('DB_USER') ?: 'bf_shop_user', //数据库用户名
	'pwd' => getenv('DB_PASS') ?: 'bf_shop_password', //数据库密码
	'dbname' => getenv('DB_NAME') ?: 'bf_shop' //数据库名
);
?>