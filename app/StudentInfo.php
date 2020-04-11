<?php
	class StudentInfo {
		CONST CF_XML = 1;
		CONST CF_DB = 2;
		CONST CF_INI = 3;
		
		public static function getConfig($conf = self::CF_INI) {
			switch($conf) {
				case CF_XML:
					return new StudentCSM();
					break;
				case CF_DB:
					return new StudentCSMB();
					break;
			}
		}
	}
	
    $student = Configuration::getConfig(CF_INI);
    
    $info = $student->getInfo();
?>