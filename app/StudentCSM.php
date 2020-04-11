<?php

//JSON

class StudentCSM {
    public static function getStudentData(int $studentID, Object $db) {
        $student = new Student();
        $data = $student->getStudentData($studentID, $db);

        return json_encode($data);
    }
}
