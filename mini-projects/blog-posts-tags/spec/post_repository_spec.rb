
require 'post_repository'

describe PostRepository do
  it 'returns every post that has the specified tag' do
    repo = PostRepository.new

    results = repo.find_by_tag(1)
    posts = results.posts

    expect(results.name).to eq 'coding'
    expect(results.posts.length).to eq 4
  end
end