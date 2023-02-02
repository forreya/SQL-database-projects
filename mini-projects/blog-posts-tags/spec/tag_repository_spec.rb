
require 'tag_repository'

describe TagRepository do
  it 'returns every tag that the specified post has' do
    repo = TagRepository.new

    results = repo.find_by_post(3)
    tags = results.tags

    expect(results.title).to eq 'Using IRB'
    expect(results.tags.length).to eq 3
  end
end