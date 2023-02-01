
require 'post_repository'

describe PostRepository do
  def reset_posts_table
    seed_sql = File.read('seeds/posts_test_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_posts_table
  end
  
  it 'return an array of all posts' do
    repo = PostRepository.new

    posts = repo.all
    
    expect(posts.length).to eq 2
    
    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'What I Like About Apples'
    expect(posts[0].content).to eq 'They are nice and yummy'
    expect(posts[0].views).to eq '100'
    expect(posts[0].account_id).to eq '1'

    expect(posts[1].id).to eq '2'
    expect(posts[1].title).to eq 'What I Like About Watermelons'
    expect(posts[1].content).to eq 'They are made of water'
    expect(posts[1].views).to eq '200'
    expect(posts[1].account_id).to eq '2'
  end

  it 'returns one post based on its id' do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq '1'
    expect(post.title).to eq 'What I Like About Apples'
    expect(post.content).to eq 'They are nice and yummy'
    expect(post.views).to eq '100'
    expect(post.account_id).to eq '1'
  end

  it 'creates a new post in the posts table' do
    repo = PostRepository.new

    post = Post.new
    post.title = 'Why I like strawberries too'
    post.content = 'I like them cuz I like berries'
    post.views = 300
    post.account_id = 2 
    
    repo.create(post)
    
    posts = repo.all
    
    expect(posts[2].id).to eq '3'
    expect(posts[2].title).to eq 'Why I like strawberries too'
    expect(posts[2].content).to eq 'I like them cuz I like berries'
    expect(posts[2].views).to eq '300'
    expect(posts[2].account_id).to eq '2'
  end

  it 'deletes a post based on its id' do
    repo = PostRepository.new

    repo.delete(1)
    
    posts = repo.all
    
    expect(posts.length).to eq 1
  end

  it 'updates a post based on its id' do
    repo = PostRepository.new

    repo.update(500, 1)
    
    post = repo.find(1)
    
    expect(post.id).to eq '1'
    expect(post.title).to eq 'What I Like About Apples'
    expect(post.content).to eq 'They are nice and yummy'
    expect(post.views).to eq '500'
    expect(post.account_id).to eq '1'
  end
end