-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Drop if table exists
DROP TABLE IF EXISTS "departments";
DROP TABLE IF EXISTS "dept_employee";
DROP TABLE IF EXISTS "manager";
DROP TABLE IF EXISTS "employees";
DROP TABLE IF EXISTS "salaries";
DROP TABLE IF EXISTS "titles";

-- Create the tables
CREATE TABLE "departments" (
    "dept_no" VARCHAR NOT NULL,
    "dept_name" VARCHAR NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_employee" (
    "id" serial NOT NULL,
    "empl_no" VARCHAR NOT NULL,
    "dept_no" VARCHAR NOT NULL,
    CONSTRAINT "pk_dept_employee" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "manager" (
    "id" serial NOT NULL,
    "dept_no" VARCHAR NOT NULL,
    "empl_no" VARCHAR NOT NULL,
    CONSTRAINT "pk_manager" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "employees" (
    "empl_no" VARCHAR NOT NULL,
    "empl_title_id" VARCHAR NOT NULL,
    "birth_date" DATE NOT NULL,
    "first_name" VARCHAR NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR NOT NULL,
    "hire_date" DATE NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "empl_no"
     )
);

CREATE TABLE "salaries" (
    "id" serial NOT NULL,
    "empl_no" VARCHAR NOT NULL,
    "salary" INT NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR NOT NULL,
    "title" VARCHAR NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

-- Define foreign Keys
ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_empl_no" FOREIGN KEY("empl_no")
REFERENCES "employees" ("empl_no");

ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "manager" ADD CONSTRAINT "fk_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "manager" ADD CONSTRAINT "fk_manager_empl_no" FOREIGN KEY("empl_no")
REFERENCES "employees" ("empl_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_empl_title_id" FOREIGN KEY("empl_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_empl_no" FOREIGN KEY("empl_no")
REFERENCES "employees" ("empl_no");

-- confirm the import worked
-- select * from salaries

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary
SELECT "employees"."empl_no", "employees"."last_name", "employees"."first_name", "employees"."sex", "salaries"."salary"
FROM "employees", "salaries"
WHERE "employees"."empl_no" = "salaries"."empl_no";

-- 2. List first name, last name, and hire date for employees who were hired in 1986
SELECT "first_name", "last_name", "hire_date"
FROM "employees"
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department with the following information: 
----  department number, department name, the manager's employee number, last name, first name
SELECT
    "manager"."dept_no", 
	"departments"."dept_name",
    "employees"."empl_no", "employees"."last_name", "employees"."first_name"
FROM
    "manager" 
    INNER JOIN "departments" ON "manager"."dept_no" = "departments"."dept_no"
    INNER JOIN "employees" ON "employees"."empl_no" = "manager"."empl_no";

-- 4. List the department of each employee with the following information: 
----  employee number, last name, first name, and department name
SELECT
    "employees"."empl_no", "employees"."last_name", "employees"."first_name", 
	"departments"."dept_name"
FROM
    "employees" 
    INNER JOIN "dept_employee" ON "employees"."empl_no" = "dept_employee"."empl_no"
    INNER JOIN "departments" ON "dept_employee"."dept_no" = "departments"."dept_no"
	ORDER BY "employees"."empl_no";

-- 5. List first name, last name, and sex for employees whose first name is
----  "Hercules" and last names begin with "B"
SELECT "first_name", "last_name", "sex"
FROM "employees"
WHERE "first_name" = 'Hercules' AND "last_name" LIKE 'B%';

-- 6. List all employees in the Sales department, including their 
----  employee number, last name, first name, and department name
SELECT
    "employees"."empl_no", "employees"."last_name", "employees"."first_name", 
	"departments"."dept_name"
FROM
    "employees" 
    INNER JOIN "dept_employee" ON "employees"."empl_no" = "dept_employee"."empl_no"
    INNER JOIN "departments" ON "dept_employee"."dept_no" = "departments"."dept_no"
WHERE "dept_name" = 'Sales';

-- 7. List all employees in the Sales and Development departments, 
----  including their employee number, last name, first name, and department name
SELECT
    "employees"."empl_no", "employees"."last_name", "employees"."first_name", 
	"departments"."dept_name"
FROM
    "employees" 
    INNER JOIN "dept_employee" ON "employees"."empl_no" = "dept_employee"."empl_no"
    INNER JOIN "departments" ON "dept_employee"."dept_no" = "departments"."dept_no"
WHERE "dept_name" = 'Sales' OR "dept_name" = 'Development'
ORDER BY dept_name ASC;

-- 8. In descending order, list the frequency count of employee last names
SELECT "last_name", COUNT("last_name") AS "frequency"
FROM "employees"
GROUP BY "employees"."last_name"
ORDER BY COUNT("employees"."last_name") DESC;
