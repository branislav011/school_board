<?php
	class StudentInfo {
		// CONST CF_XML = 1;
		// CONST CF_DB = 2;
		// CONST CF_INI = 3;
		// private static $conf;

		// public function __construct($conf) {
		// 	$this->conf = $conf;
		// }
		
		public static function getConfig($conf) {
			switch($conf) {
				case 1:
					return new StudentCSM();
					break;
				case 2:
					return new StudentCSMB();
					break;
			}
		}

		public static function getStudentBoardNum($studentID, $db) {
			return Student::getBoardNum($studentID, $db);
		}
	}
	
    // $student = Configuration::getConfig(CF_INI);
    
    // $info = $student->getInfo();
?>