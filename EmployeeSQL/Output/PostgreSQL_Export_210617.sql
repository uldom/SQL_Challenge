-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Drop table if previously exists
DROP TABLE IF EXISTS "Departments";

-- Create table
CREATE TABLE "Departments" (
    "dept_no" varchar NOT NULL,
    "dept_name" varchar NOT NULL,
    CONSTRAINT "pk_Departments" 
	PRIMARY KEY ("dept_no")
);

-- Drop table if previously exists
DROP TABLE IF EXISTS "Dept_Employee";

-- Create table
CREATE TABLE "Dept_Employee" (
    "id" serial NOT NULL,
    "empl_no" int NOT NULL,
    "dept_no" varchar NOT NULL,
    CONSTRAINT "pk_Dept_Employee" 
	PRIMARY KEY ("id")
);

-- Drop table if previously exists
DROP TABLE IF EXISTS "Dept_Manager";

-- Create table
CREATE TABLE "Dept_Manager" (
    "id" serial NOT NULL,
    "dept_no" varchar NOT NULL,
    "empl_no" int NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY ("id")
);

-- Drop table if previously exists
DROP TABLE IF EXISTS "Employees";

-- Create table
CREATE TABLE "Employees" (
    "empl_no" int NOT NULL,
    "empl_title_id" varchar NOT NULL,
    "birth_date" date NOT NULL,
    "first_name" varchar NOT NULL,
    "last_name" varchar NOT NULL,
    "sex" varchar NOT NULL,
    "hire_date" date NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY ("empl_no")
);

-- Drop table if previously exists
DROP TABLE IF EXISTS "Salaries";

-- Create table
CREATE TABLE "Salaries" (
    "id" serial NOT NULL,
    "empl_no" int NOT NULL,
    "salary" int NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY ("id")
);

-- Drop table if previously exists
DROP TABLE IF EXISTS "Titles";

-- Create table
CREATE TABLE "Titles" (
    "title_id" varchar NOT NULL,
    "title" varchar NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY ("title_id")
);

-- Foreign Keys

ALTER TABLE "Dept_Employee" ADD CONSTRAINT "fk_Dept_Employee_empl_no" FOREIGN KEY("empl_no")
REFERENCES "Employees" ("empl_no");

ALTER TABLE "Dept_Employee" ADD CONSTRAINT "fk_Dept_Employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_empl_no" FOREIGN KEY("empl_no")
REFERENCES "Employees" ("empl_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_empl_no" FOREIGN KEY("empl_no")
REFERENCES "Salaries" ("empl_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_empl_title_id" FOREIGN KEY("empl_title_id")
REFERENCES "Titles" ("title_id");

