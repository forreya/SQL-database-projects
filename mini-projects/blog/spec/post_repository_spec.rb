
require 'post_repository'

describe PostRepository do
  def reset_tables
    seed_sql = File.read('seeds/testing_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_tables
  end

  it 'finds post 1 with related comments' do
    repository = PostRepository.new
    post = repository.find_with_comments(1)

    expect(post.title).to eq('Fire')
    expect(post.comments.length).to eq(2)
  end

end