<?php

/**
 * class StudentCSMB
 * generate XML
 */

class StudentCSMB {
    /**
     * @param int $studentID
     * @param Object $db
     * @return XML
     */

    public static function getStudentData(int $studentID, Object $db) {
        $student = new Student();
        $data = $student->getStudentData($studentID, $db);

        return self::generateXML($data);
    }

    /**
     * @param int $studentID
     * @param Array $data
     */

    private static function generateXML($data) {
        $xmlOutput = new SimpleXMLElement("<xml/>");

        foreach ($data as $student) {
            $finalResult = "Fail";
            $gradeArr = explode(",", $student["gradeList"]);

            if (count($gradeArr) > 1 && max($gradeArr) >= 8) {
                $finalResult = "Pass";
            } else if (count($gradeArr) == 1 && $gradeArr[0] >= 8) {
                $finalResult = "Pass";
            }

            $track = $xmlOutput->addChild("student");
            $track->addChild("student-id", $student["student_id"]);
            $track->addChild("firstname", $student["firstname"]);
            $track->addChild("lastname", $student["lastname"]);
            $track->addChild("average-grade", $student["avgGrade"]);
            $track->addChild("all-grades", $student["gradeList"]);
            $track->addChild("final-result", $finalResult);
        }

        return $xmlOutput->asXML();
    }
}