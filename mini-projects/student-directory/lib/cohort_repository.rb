
require_relative 'cohort'
require_relative 'student'

class CohortRepository

  def find_with_students(cohort_id)
    sql = 'SELECT
            cohorts.name AS cohort_name,
            cohorts.id AS id,
            students.id AS student_id,
            students.name AS name
          FROM
            cohorts
          JOIN
            students
          ON
            students.cohort_id = cohorts.id
          WHERE
            cohorts.id = $1;
          '
    
    cohort_id = cohort_id.to_i
    result = DatabaseConnection.exec_params(sql, [cohort_id])

    cohort = Cohort.new

    cohort.id = result.first['id']
    cohort.name = result.first['cohort_name']

    result.each {
      |record|
      student = Student.new
      student.id = record['student_id']
      student.name = record['name']

      cohort.students.push(student)
    }

    cohort
  end

end