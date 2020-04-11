<?php

//JSON

class StudentCSM {
    public static function getStudentData(int $studentID, Object $db) {
        $student = new Student();
        $data = $student->getStudentData($studentID, $db);

        foreach ($data as $i => $student) {
            $finalResult = "Fail";
            $gradeArr = explode(",", $student["gradeList"]);
            
            $avg = array_sum($gradeArr) / count($gradeArr);

            if ($avg >= 7) {
                $finalResult = "Pass";
            } 

            $data[$i]["final_result"] = $finalResult;

            var_dump($student);
            exit;
        }

        return json_encode($data);
    }
}
