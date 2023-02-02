
require 'cohort_repository'

describe CohortRepository do
  def reset_tables
    seed_sql = File.read('seeds/testing_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_tables
  end

  it 'finds cohort 1 with related students' do
    repository = CohortRepository.new
    cohort = repository.find_with_students(1)

    expect(cohort.name).to eq('January')
    expect(cohort.students.length).to eq(2)
  end

end