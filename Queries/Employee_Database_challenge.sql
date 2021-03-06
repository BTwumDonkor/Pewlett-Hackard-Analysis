--Retirement Titles
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;



-- Use Dictinct with Orderby to remove duplicate rows:
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--INTO unique_titles
FROM retirement_titles 
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- The number of employees by their most recent job title who are about to retire.
SELECT COUNT(title) AS count,  title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

--Summary query
--Roles to be filled
SELECT DISTINCT ON (ri.emp_no) ri.emp_no, 
ri.first_name,
ri.last_name,
ri.title,
d.dept_name
FROM retirement_titles AS ri
INNER JOIN dept_emp AS de 
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (d.dept_no = de.dept_no)
ORDER BY emp_no DESC;


-- Are there enough qualified mentors for each department?
-- the employees who are eligible to participate in a mentorship program.
SELECT COUNT (emp_no) AS count  from  mentorship_eligibility;
