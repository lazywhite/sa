<?php

return array(

	/*
	|--------------------------------------------------------------------------
	| Database Connections
	|--------------------------------------------------------------------------
	|
	| Here are each of the database connections setup for your application.
	| Of course, examples of configuring each database platform that is
	| supported by Laravel is shown below to make development simple.
	|
	|
	| All database work in Laravel is done through the PHP PDO facilities
	| so make sure you have the driver for your particular database of
	| choice installed on your machine before you begin development.
	|
	*/

	'connections' => array(

		'mysql' => array(
			'driver'    => 'mysql',
			'host'      => '10.157.129.227',
            'port'      => '6789',
			'database'  => 'jqcms',
			'username'  => 'hrcf',
			'password'  => '8a4ed5c8b7a1f32f423a384a79438108',
			'charset'   => 'utf8',
			'collation' => 'utf8_unicode_ci',
			'prefix'    => 'rt_',
		),

		'pgsql' => array(
			'driver'   => 'pgsql',
			'host'     => 'localhost',
			'database' => 'homestead',
			'username' => 'homestead',
			'password' => 'secret',
			'charset'  => 'utf8',
			'prefix'   => '',
			'schema'   => 'public',
		),

	),

);
