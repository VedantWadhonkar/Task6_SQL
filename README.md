# Task6_SQL
# 🎓 Student Performance Dashboard (SQL-Based)

## 📌 Objective
The goal of this project is to design and implement a **SQL-based Student Performance Dashboard** that tracks student academic performance and attendance using **MySQL**.

---

## ⚙️ Tools & Technologies
- **Database**: MySQL  
- **Queries**: SQL (Joins, Aggregations, Grouping, Filtering)  
- **Dashboard Output**: Tabular reports generated from SQL queries  

---

## 📂 Database Design
The system is built using a **relational database schema** with the following tables:
1. **Students** – Stores student details (roll no, name, DOB, gender, batch, department).  
2. **Courses** – Stores course information (course code, course name, credits).  
3. **Enrollments** – Links students with courses, semester, year, and section.  
4. **Assessments** – Records marks for tests, assignments, labs, projects, etc.  
5. **Attendance** – Tracks daily student attendance per course.  

---

## 📝 Features
The dashboard generates:
- ✅ **Student Enrollment Report** – List of students with their registered courses.  
- ✅ **Average Marks Report** – Calculates each student’s average percentage across assessments.  
- ✅ **Attendance Report** – Percentage attendance per student per course.  
- ✅ **Low Performance Alerts** – Identifies students scoring below 40%.  
- ✅ **Low Attendance Alerts** – Flags students with attendance below 75%.  

---

## 📊 Sample Reports
- **Enrollment Report** → Shows which student is enrolled in which course.  
- **Performance Report** → Displays each student’s average marks.  
- **Attendance Report** → Calculates attendance percentage.  
- **Alerts** → Low marks (<40%) and low attendance (<75%).  

---

## 🚀 How to Run
1. Open MySQL Workbench or CLI.  
2. Run the database creation and table scripts.  
3. Insert sample data (students, courses, assessments, attendance).  
4. Execute the queries to generate dashboard reports.  

---

## 📷 Deliverables
- SQL script for database and queries.  
- Dashboard screenshots showing reports.  
- Query documentation with explanations.  

---

## 🏆 Outcome
This project provides a **mini student management system** that demonstrates how SQL can be used for **academic performance monitoring** and **attendance tracking**. It is useful for colleges, universities, and academic institutions to monitor student progress effectively.
