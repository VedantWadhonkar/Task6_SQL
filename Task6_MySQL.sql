-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS StudentPerformanceDB;
USE StudentPerformanceDB;

-- Step 2: Drop tables if they already exist (for clean re-run)
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

-- Step 3: Create Students table
CREATE TABLE students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  roll_no VARCHAR(20) NOT NULL UNIQUE,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  gender ENUM('M','F','O'),
  batch YEAR,
  department VARCHAR(50)
);

-- Step 4: Create Courses table
CREATE TABLE courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_code VARCHAR(20) UNIQUE,
  course_name VARCHAR(100),
  credits INT
);

-- Step 5: Create Enrollments table (linking students & courses)
CREATE TABLE enrollments (
  enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT,
  course_id INT,
  semester INT,
  year YEAR,
  section VARCHAR(5),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Step 6: Create Assessments table (marks per exam/test)
CREATE TABLE assessments (
  assessment_id INT AUTO_INCREMENT PRIMARY KEY,
  enrollment_id INT,
  assessment_type ENUM('Mid','End','Quiz','Assignment','Lab','Project'),
  max_marks INT,
  marks_obtained DECIMAL(6,2),
  assessment_date DATE,
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- Step 7: Create Attendance table (daily attendance per student/course)
CREATE TABLE attendance (
  attendance_id INT AUTO_INCREMENT PRIMARY KEY,
  enrollment_id INT,
  class_date DATE,
  status ENUM('Present','Absent','Late') DEFAULT 'Present',
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);
INSERT INTO students (roll_no, first_name, last_name, dob, gender, batch, department)
VALUES
('S101', 'Amit', 'Sharma', '2003-05-14', 'M', 2025, 'Computer Science'),
('S102', 'Priya', 'Verma', '2002-09-20', 'F', 2025, 'Computer Science'),
('S103', 'Rahul', 'Patil', '2003-01-10', 'M', 2025, 'Information Technology'),
('S104', 'Sneha', 'Kulkarni', '2002-11-05', 'F', 2025, 'Electronics'),
('S105', 'Vikas', 'Jain', '2003-03-18', 'M', 2025, 'Computer Science');
INSERT INTO courses (course_code, course_name, credits)
VALUES
('CS101', 'Database Management Systems', 4),
('CS102', 'Data Structures', 3),
('CS103', 'Operating Systems', 3);
INSERT INTO enrollments (student_id, course_id, semester, year, section)
VALUES
(1, 1, 4, 2025, 'A'),
(1, 2, 4, 2025, 'A'),
(2, 1, 4, 2025, 'A'),
(2, 3, 4, 2025, 'A'),
(3, 2, 4, 2025, 'B'),
(4, 1, 4, 2025, 'B'),
(5, 3, 4, 2025, 'A');
INSERT INTO assessments (enrollment_id, assessment_type, max_marks, marks_obtained, assessment_date)
VALUES
(1, 'Mid', 50, 42, '2025-03-10'),
(1, 'End', 100, 78, '2025-05-20'),
(2, 'Mid', 50, 35, '2025-03-12'),
(2, 'End', 100, 66, '2025-05-22'),
(3, 'Quiz', 20, 15, '2025-02-15'),
(4, 'Assignment', 10, 9, '2025-04-05'),
(5, 'Mid', 50, 28, '2025-03-15'),
(6, 'End', 100, 82, '2025-05-25'),
(7, 'Project', 50, 40, '2025-06-01');
INSERT INTO attendance (enrollment_id, class_date, status)
VALUES
(1, '2025-03-01', 'Present'),
(1, '2025-03-02', 'Absent'),
(1, '2025-03-03', 'Present'),
(2, '2025-03-01', 'Present'),
(2, '2025-03-02', 'Present'),
(3, '2025-03-01', 'Late'),
(3, '2025-03-02', 'Present'),
(4, '2025-03-01', 'Absent'),
(5, '2025-03-01', 'Present'),
(6, '2025-03-01', 'Present'),
(7, '2025-03-01', 'Absent');
SELECT s.roll_no, s.first_name, s.last_name, c.course_name, e.semester, e.section
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
SELECT s.roll_no, s.first_name, s.last_name,
       ROUND(AVG(a.marks_obtained / a.max_marks * 100),2) AS avg_percentage
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN assessments a ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id;
SELECT s.roll_no, s.first_name, s.last_name, c.course_name,
       ROUND(SUM(CASE WHEN at.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attendance_percentage
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN attendance at ON e.enrollment_id = at.enrollment_id
GROUP BY s.student_id, c.course_id;
SELECT s.roll_no, s.first_name, s.last_name,
       ROUND(AVG(a.marks_obtained / a.max_marks * 100),2) AS avg_percentage
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN assessments a ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id
HAVING avg_percentage < 40;
SELECT s.roll_no, s.first_name, s.last_name, c.course_name,
       ROUND(SUM(CASE WHEN at.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attendance_percentage
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN attendance at ON e.enrollment_id = at.enrollment_id
GROUP BY s.student_id, c.course_id
HAVING attendance_percentage < 75;

