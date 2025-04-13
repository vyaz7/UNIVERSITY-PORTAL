-- Adminer 4.8.1 MySQL 8.1.0 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Announcements`;
CREATE TABLE `Announcements` (
  `ID` int NOT NULL,
  `Title` varchar(30) NOT NULL,
  `Descriptions` varchar(1000) NOT NULL,
  `priority` int NOT NULL,
  KEY `ID` (`ID`),
  CONSTRAINT `Announcements_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `Exam` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Attendance`;
CREATE TABLE `Attendance` (
  `class_id` int NOT NULL,
  `Semester_id` int NOT NULL,
  `reg_id` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tot_classes` int NOT NULL,
  `tot_present` int NOT NULL,
  `Percentage` int NOT NULL,
  KEY `class_id` (`class_id`),
  KEY `Semester_id` (`Semester_id`),
  KEY `reg_id` (`reg_id`),
  CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `Class` (`id`),
  CONSTRAINT `Attendance_ibfk_2` FOREIGN KEY (`Semester_id`) REFERENCES `Semester` (`Semester_id`),
  CONSTRAINT `Attendance_ibfk_3` FOREIGN KEY (`reg_id`) REFERENCES `Student` (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Attendance` (`class_id`, `Semester_id`, `reg_id`, `tot_classes`, `tot_present`, `Percentage`) VALUES
(1,	1,	'2023001',	20,	15,	75),
(2,	1,	'2023002',	20,	18,	90),
(3,	2,	'2024001',	20,	17,	85),
(4,	2,	'2024002',	20,	20,	100),
(5,	3,	'2023003',	20,	16,	80),
(6,	3,	'2024003',	20,	19,	95),
(7,	1,	'2023001',	20,	18,	90),
(8,	1,	'2023002',	20,	17,	85),
(9,	1,	'2023003',	20,	19,	95),
(10,	2,	'2024001',	20,	16,	80),
(11,	2,	'2024002',	20,	18,	90),
(12,	2,	'2024003',	20,	20,	100),
(13,	3,	'2023001',	20,	19,	95),
(14,	3,	'2023002',	20,	17,	85),
(15,	3,	'2023003',	20,	20,	100)
ON DUPLICATE KEY UPDATE `class_id` = VALUES(`class_id`), `Semester_id` = VALUES(`Semester_id`), `reg_id` = VALUES(`reg_id`), `tot_classes` = VALUES(`tot_classes`), `tot_present` = VALUES(`tot_present`), `Percentage` = VALUES(`Percentage`);

DROP TABLE IF EXISTS `Class`;
CREATE TABLE `Class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Faculty_Name` varchar(30) NOT NULL,
  `Course_id` int NOT NULL,
  `Slot` varchar(10) NOT NULL,
  `Semester_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_id` (`Course_id`),
  KEY `Semester_id` (`Semester_id`),
  CONSTRAINT `Class_ibfk_1` FOREIGN KEY (`Course_id`) REFERENCES `Course` (`Course_id`),
  CONSTRAINT `Class_ibfk_2` FOREIGN KEY (`Semester_id`) REFERENCES `Semester` (`Semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Class` (`id`, `Faculty_Name`, `Course_id`, `Slot`, `Semester_id`) VALUES
(1,	'Prof. Anderson',	1,	'Morning',	1),
(2,	'Prof. Carter',	2,	'Afternoon',	1),
(3,	'Prof. Evans',	3,	'Evening',	2),
(4,	'Prof. Harris',	4,	'Morning',	2),
(5,	'Prof. Jackson',	5,	'Afternoon',	3),
(6,	'Prof. Lopez',	6,	'Evening',	3),
(7,	'Prof. White',	7,	'Morning',	1),
(8,	'Prof. Black',	8,	'Afternoon',	1),
(9,	'Prof. Green',	9,	'Evening',	1),
(10,	'Prof. Red',	10,	'Morning',	2),
(11,	'Prof. Blue',	11,	'Afternoon',	2),
(12,	'Prof. Yellow',	12,	'Evening',	2),
(13,	'Prof. Orange',	13,	'Morning',	3),
(14,	'Prof. Purple',	14,	'Afternoon',	3),
(15,	'Prof. Pink',	15,	'Evening',	3)
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `Faculty_Name` = VALUES(`Faculty_Name`), `Course_id` = VALUES(`Course_id`), `Slot` = VALUES(`Slot`), `Semester_id` = VALUES(`Semester_id`);

DROP TABLE IF EXISTS `Course`;
CREATE TABLE `Course` (
  `Course_id` int NOT NULL,
  `Course` varchar(30) NOT NULL,
  `Credits` int NOT NULL,
  `Semester_id` int NOT NULL,
  PRIMARY KEY (`Course_id`),
  KEY `Course_Semester_fk` (`Semester_id`),
  CONSTRAINT `Course_Semester_fk` FOREIGN KEY (`Semester_id`) REFERENCES `Semester` (`Semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Course` (`Course_id`, `Course`, `Credits`, `Semester_id`) VALUES
(1,	'Mathematics',	3,	1),
(2,	'Computer Science',	4,	1),
(3,	'Physics',	3,	2),
(4,	'Chemistry',	4,	2),
(5,	'Literature',	3,	3),
(6,	'History',	4,	3),
(7,	'Biology',	3,	1),
(8,	'Art',	2,	1),
(9,	'Music',	2,	1),
(10,	'Economics',	3,	2),
(11,	'Psychology',	3,	2),
(12,	'Sociology',	3,	2),
(13,	'Geography',	3,	3),
(14,	'Political Science',	3,	3),
(15,	'Philosophy',	3,	3)
ON DUPLICATE KEY UPDATE `Course_id` = VALUES(`Course_id`), `Course` = VALUES(`Course`), `Credits` = VALUES(`Credits`), `Semester_id` = VALUES(`Semester_id`);

DROP TABLE IF EXISTS `Credentials`;
CREATE TABLE `Credentials` (
  `reg_id` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw',
  KEY `reg_id` (`reg_id`),
  CONSTRAINT `Credentials_ibfk_1` FOREIGN KEY (`reg_id`) REFERENCES `Student` (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Credentials` (`reg_id`, `login`, `password`) VALUES
('2023001',	'alice@example.com',	'$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw'),
('2023002',	'bob@example.com',	'$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw'),
('2023003',	'charlie@example.com',	'$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw'),
('2024001',	'david@example.com',	'$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw'),
('2024002',	'ella@example.com',	'$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw'),
('2024003',	'frank@example.com',	'$argon2id$v=19$m=65536,t=3,p=4$kFW6pGJKYpwWyg5K27Qo7Q$Ds9NYjOOUieVXlCGANFUc8SUUcuPLdmibaIMU166pxw')
ON DUPLICATE KEY UPDATE `reg_id` = VALUES(`reg_id`), `login` = VALUES(`login`), `password` = VALUES(`password`);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) NOT NULL,
  `Course_id` int NOT NULL,
  `Semester_id` int NOT NULL,
  `date_of_exam` date NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Course_id` (`Course_id`),
  KEY `Semester_id` (`Semester_id`),
  CONSTRAINT `Exam_ibfk_2` FOREIGN KEY (`Course_id`) REFERENCES `Course` (`Course_id`),
  CONSTRAINT `Exam_ibfk_3` FOREIGN KEY (`Semester_id`) REFERENCES `Semester` (`Semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Exam` (`ID`, `Name`, `Course_id`, `Semester_id`, `date_of_exam`) VALUES
(1,	'CAT1',	1,	1,	'2023-10-15'),
(2,	'CAT1',	2,	1,	'2023-11-01'),
(3,	'CAT1',	3,	2,	'2024-03-10'),
(4,	'CAT1',	4,	2,	'2024-03-25'),
(5,	'CAT1',	5,	3,	'2024-04-05'),
(6,	'CAT1',	6,	3,	'2024-04-20')
ON DUPLICATE KEY UPDATE `ID` = VALUES(`ID`), `Name` = VALUES(`Name`), `Course_id` = VALUES(`Course_id`), `Semester_id` = VALUES(`Semester_id`), `date_of_exam` = VALUES(`date_of_exam`);

DROP TABLE IF EXISTS `Marks`;
CREATE TABLE `Marks` (
  `Exam_id` int NOT NULL,
  `reg_id` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mark` int NOT NULL,
  `tot_mark` int NOT NULL,
  KEY `Exam_id` (`Exam_id`),
  KEY `reg_id` (`reg_id`),
  CONSTRAINT `Marks_ibfk_1` FOREIGN KEY (`Exam_id`) REFERENCES `Exam` (`ID`),
  CONSTRAINT `Marks_ibfk_2` FOREIGN KEY (`reg_id`) REFERENCES `Student` (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Marks` (`Exam_id`, `reg_id`, `mark`, `tot_mark`) VALUES
(1,	'2023001',	85,	100),
(2,	'2023002',	90,	100),
(3,	'2023003',	88,	100),
(4,	'2024001',	92,	100),
(5,	'2024002',	95,	100),
(6,	'2024003',	87,	100),
(1,	'2023001',	85,	100),
(1,	'2023002',	80,	100),
(1,	'2023003',	90,	100),
(1,	'2024001',	75,	100),
(1,	'2024002',	85,	100),
(1,	'2024003',	95,	100),
(2,	'2023001',	88,	100),
(2,	'2023002',	92,	100),
(2,	'2023003',	82,	100),
(2,	'2024001',	90,	100),
(2,	'2024002',	85,	100),
(2,	'2024003',	80,	100),
(3,	'2023001',	92,	100),
(3,	'2023002',	85,	100),
(3,	'2023003',	90,	100),
(3,	'2024001',	88,	100),
(3,	'2024002',	94,	100),
(3,	'2024003',	87,	100),
(4,	'2023001',	78,	100),
(4,	'2023002',	80,	100),
(4,	'2023003',	85,	100),
(4,	'2024001',	90,	100),
(4,	'2024002',	88,	100),
(4,	'2024003',	92,	100),
(5,	'2023001',	85,	100),
(5,	'2023002',	90,	100),
(5,	'2023003',	88,	100),
(5,	'2024001',	92,	100),
(5,	'2024002',	95,	100),
(5,	'2024003',	87,	100),
(6,	'2023001',	90,	100),
(6,	'2023002',	85,	100),
(6,	'2023003',	88,	100),
(6,	'2024001',	94,	100),
(6,	'2024002',	90,	100),
(6,	'2024003',	85,	100)
ON DUPLICATE KEY UPDATE `Exam_id` = VALUES(`Exam_id`), `reg_id` = VALUES(`reg_id`), `mark` = VALUES(`mark`), `tot_mark` = VALUES(`tot_mark`);

DROP TABLE IF EXISTS `Profile`;
CREATE TABLE `Profile` (
  `reg_id` varchar(9) NOT NULL,
  `Address` varchar(300) NOT NULL,
  `Phone` bigint NOT NULL,
  `Blood_Group` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Department` varchar(50) NOT NULL,
  `CGPA` int NOT NULL,
  `Dob` date NOT NULL,
  KEY `reg_id` (`reg_id`),
  CONSTRAINT `Profile_ibfk_1` FOREIGN KEY (`reg_id`) REFERENCES `Student` (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Profile` (`reg_id`, `Address`, `Phone`, `Blood_Group`, `Department`, `CGPA`, `Dob`) VALUES
('2023001',	'123 Main St, City',	1234567890,	'O+',	'Computer Science',	4,	'2000-01-01'),
('2023002',	'456 Elm St, Town',	2345678901,	'A-',	'Mathematics',	3,	'2000-05-15'),
('2023003',	'789 Oak St, Village',	3456789012,	'B+',	'Physics',	4,	'1999-10-10'),
('2024001',	'901 Maple St, City',	4567890123,	'AB-',	'Chemistry',	4,	'2001-02-20'),
('2024002',	'234 Pine St, Town',	5678901234,	'O-',	'Literature',	4,	'2001-06-25'),
('2024003',	'567 Cedar St, Village',	6789012345,	'A+',	'History',	3,	'2001-11-30')
ON DUPLICATE KEY UPDATE `reg_id` = VALUES(`reg_id`), `Address` = VALUES(`Address`), `Phone` = VALUES(`Phone`), `Blood_Group` = VALUES(`Blood_Group`), `Department` = VALUES(`Department`), `CGPA` = VALUES(`CGPA`), `Dob` = VALUES(`Dob`);

DROP TABLE IF EXISTS `Semester`;
CREATE TABLE `Semester` (
  `Semester_id` int NOT NULL,
  `Semester` varchar(30) NOT NULL,
  PRIMARY KEY (`Semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Semester` (`Semester_id`, `Semester`) VALUES
(1,	'Fall 2023'),
(2,	'Spring 2024'),
(3,	'Summer 2024')
ON DUPLICATE KEY UPDATE `Semester_id` = VALUES(`Semester_id`), `Semester` = VALUES(`Semester`);

DROP TABLE IF EXISTS `Student`;
CREATE TABLE `Student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reg_id` varchar(9) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`reg_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Student` (`id`, `reg_id`, `name`) VALUES
(1,	'2023001',	'Alice Johnson'),
(2,	'2023002',	'Bob Smith'),
(3,	'2023003',	'Charlie Brown'),
(4,	'2024001',	'David Miller'),
(5,	'2024002',	'Ella Davis'),
(6,	'2024003',	'Frank Wilson')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `reg_id` = VALUES(`reg_id`), `name` = VALUES(`name`);

-- 2024-03-25 15:43:51
