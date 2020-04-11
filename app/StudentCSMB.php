<?php

//XML

class StudentCSMB {
    public static function getStudentData() {
        $student = new Student();
        $data = $student->getStudentData($studentID, $db);

        return json_encode($data);
    }
}