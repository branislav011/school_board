<?php
	class StudentInfo {		
		public static function getConfig($conf) {
			switch($conf) {
				case 1:
					$_SESSION["app_type"] = "application/json";
					return new StudentCSM();
					break;
				case 2:
					$_SESSION["app_type"] = "application/xml";
					return new StudentCSMB();
					break;
			}
		}

		public static function getStudentBoardNum($studentID, $db) {
			return Student::getBoardNum($studentID, $db);
		}
	}
?>