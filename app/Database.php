<?php

class Database {
	private static $instance = NULL;
	
	private function __construct() {}
	
	private function __clone() {}
	
	public static function getInstance() {
		if (!isset(self::$instance)) {
			self::$instance = new PDO("mysql:host=localhost;dbname=school_board", "root", "");
			self::$instance->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			self::$instance->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
		}
		
		return self::$instance;
	}
}