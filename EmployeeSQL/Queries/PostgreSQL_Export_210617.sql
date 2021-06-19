-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Create the tables
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_employee" (
    "id" serial   NOT NULL,
    "empl_no" VARCHAR   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_employee" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "manager" (
    "id" serial   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "empl_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_manager" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "employees" (
    "empl_no" VARCHAR   NOT NULL,
    "empl_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "empl_no"
     )
);

CREATE TABLE "salaries" (
    "id" serial   NOT NULL,
    "empl_no" VARCHAR   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

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

