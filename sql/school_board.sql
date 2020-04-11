-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 11, 2020 at 12:25 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school_board`
--

-- --------------------------------------------------------

--
-- Table structure for table `boards`
--

CREATE TABLE `boards` (
  `board_id` int(11) UNSIGNED NOT NULL,
  `board_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boards`
--

INSERT INTO `boards` (`board_id`, `board_name`, `active`, `created_at`) VALUES
(1, 'CSM', 1, '2020-04-11 11:36:15'),
(2, 'CSMB', 1, '2020-04-11 11:36:15');

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `grade_id` int(11) UNSIGNED NOT NULL,
  `subject_id` int(11) UNSIGNED NOT NULL,
  `grade` int(11) NOT NULL,
  `student_id` int(11) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`grade_id`, `subject_id`, `grade`, `student_id`, `created_at`) VALUES
(1, 1, 9, 1, '2020-04-11 11:51:16'),
(2, 4, 10, 1, '2020-04-11 11:51:16'),
(3, 6, 8, 2, '2020-04-11 11:51:46'),
(4, 1, 10, 2, '2020-04-11 11:51:46'),
(5, 5, 9, 2, '2020-04-11 11:52:00'),
(6, 8, 6, 3, '2020-04-11 11:52:24'),
(7, 6, 7, 3, '2020-04-11 11:52:24'),
(8, 2, 6, 3, '2020-04-11 11:53:09'),
(9, 7, 5, 3, '2020-04-11 11:53:09'),
(10, 8, 7, 4, '2020-04-11 11:54:20'),
(11, 5, 9, 5, '2020-04-11 11:54:20'),
(12, 4, 10, 6, '2020-04-11 11:54:59'),
(13, 6, 10, 6, '2020-04-11 11:54:59'),
(14, 3, 9, 6, '2020-04-11 11:55:30'),
(15, 7, 9, 7, '2020-04-11 11:55:30'),
(16, 6, 8, 7, '2020-04-11 11:55:50'),
(17, 5, 5, 1, '2020-04-11 12:24:30'),
(18, 3, 7, 1, '2020-04-11 12:24:54');

--
-- Triggers `grades`
--
DELIMITER $$
CREATE TRIGGER `limit_grade_per_student` BEFORE INSERT ON `grades` FOR EACH ROW BEGIN
	DECLARE students INT UNSIGNED DEFAULT 0;
	
    SET students = (SELECT COUNT(grade_id) FROM grades WHERE student_id = NEW.student_id);

    IF students > 3 THEN
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Warning: max grades for student is 4!';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) UNSIGNED NOT NULL,
  `firstname` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `board_id` int(11) UNSIGNED NOT NULL COMMENT 'student is registered with only one school board',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `firstname`, `lastname`, `board_id`, `created_at`) VALUES
(1, 'John', 'Doe', 1, '2020-04-11 11:37:34'),
(2, 'Anna', 'Smith', 1, '2020-04-11 11:37:34'),
(3, 'Mark', 'Holland', 1, '2020-04-11 11:38:46'),
(4, 'Clayton', 'Fransis', 1, '2020-04-11 11:38:46'),
(5, 'Maria', 'Smith', 2, '2020-04-11 11:40:15'),
(6, 'John', 'Brook', 2, '2020-04-11 11:40:15'),
(7, 'Jacob', 'Albers', 2, '2020-04-11 11:40:53');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) UNSIGNED NOT NULL,
  `subject_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `created_at`) VALUES
(1, 'Math', '2020-04-11 11:48:27'),
(2, 'Programming', '2020-04-11 11:48:27'),
(3, 'English', '2020-04-11 11:48:40'),
(4, 'Databases', '2020-04-11 11:48:40'),
(5, 'Discrete Math', '2020-04-11 11:49:23'),
(6, 'Data structures and algorithms', '2020-04-11 11:49:23'),
(7, 'Software testing', '2020-04-11 11:50:26'),
(8, 'Software methodologies', '2020-04-11 11:50:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `boards`
--
ALTER TABLE `boards`
  ADD PRIMARY KEY (`board_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`grade_id`),
  ADD UNIQUE KEY `unique_index_sub_stud` (`student_id`,`subject_id`),
  ADD KEY `fk_grades_subject_id` (`subject_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `fk_students_board_id` (`board_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `boards`
--
ALTER TABLE `boards`
  MODIFY `board_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `grade_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `fk_grades_student_id` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `fk_grades_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_board_id` FOREIGN KEY (`board_id`) REFERENCES `boards` (`board_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
