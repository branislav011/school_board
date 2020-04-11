<?php
session_start();
require_once("config/dependencies.php");

if (!empty($_GET["student"]) && is_numeric($_GET["student"])) {
  //var_dump($_GET["student"]);
  $studentID = (int) $_GET["student"]; //force int value
  $studentID = strip_tags(trim($studentID));

  if (filter_var($studentID, FILTER_SANITIZE_NUMBER_INT)) {
    //ready -> set -> go :) ....
    $db = Database::getInstance();
    $studentBoardNum = StudentInfo::getStudentBoardNum($studentID, $db);

    if (!empty($studentBoardNum))
      $studentBoardNum = $studentBoardNum["board_id"];
    else {
      throw new Exception("Invalid ID provided", "441");
      exit;
    }
    
    $student = StudentInfo::getConfig($studentBoardNum);
    
    $info = $student->getStudentData($studentID, $db);

    // var_dump($info);
    // exit;
    header("Content-Type: {$_SESSION["app_type"]}");
    //header('Content-type: application/xml');
    echo $info;
    exit;
  }
}