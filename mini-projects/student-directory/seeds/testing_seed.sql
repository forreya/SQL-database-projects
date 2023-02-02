
TRUNCATE TABLE cohorts, students RESTART IDENTITY; -- replace with your own table name.

INSERT INTO cohorts (name, starting_date) VALUES ('January', '01-01-2023');
INSERT INTO cohorts (name, starting_date) VALUES ('July', '12-07-2023');

INSERT INTO students (name, cohort_id) VALUES ('Ryan Lai', 1);
INSERT INTO students (name, cohort_id) VALUES ('Alain Lai', 2);
INSERT INTO students (name, cohort_id) VALUES ('Yvonne Phe', 1);