<?php

/**
 * class Student
 * Model
 */

class Student {
    /**
     * @param int $studentID
     * @param Object $db
     * @return Array 
     * fetch student info
     */

    public static function getStudentData(int $studentID, Object $db) {
        $sql = "
            SELECT
                students.student_id,
                students.firstname,
                students.lastname,
                (
                    SELECT 
                        AVG(grades.grade) 
                    FROM 
                        grades 
                    WHERE 
                        grades.student_id = students.student_id
                ) AS avgGrade,
                (
                	GROUP_CONCAT(DISTINCT(CONCAT(grades.grade)) SEPARATOR ', ')
                )  as gradeList
            FROM students 
                INNER JOIN boards 
                    ON (students.board_id = boards.board_id)
                INNER JOIN grades
                    ON (students.student_id = grades.student_id)
                INNER JOIN subjects
                    ON (grades.subject_id = subjects.subject_id)
                WHERE students.student_id = :studentID 
                LIMIT 1;
        ";

        $stmt = $db->prepare($sql);
        $stmt->execute([
            ":studentID" => $studentID,
        ]);
        $records = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $records;
    }

    /**
     * @param int $studentID
     * @param Object $db
     * @return Array
     * fetch board num (1 or 2)
     * 1 - CSM
     * 2 - CSMB
     */

    public static function getBoardNum(int $studentID, Object $db) {
        $sql = "
            SELECT
                students.board_id
            FROM students 
            WHERE students.student_id = :studentID 
            LIMIT 1;
        ";

        $stmt = $db->prepare($sql);
        $stmt->execute([
            ":studentID" => $studentID,
        ]);
        $boardNum = $stmt->fetch();

        return $boardNum;
    }
}