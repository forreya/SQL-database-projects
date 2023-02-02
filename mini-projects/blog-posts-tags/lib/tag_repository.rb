require_relative 'database_connection'
require_relative 'tag'
require_relative 'post'


class TagRepository
  def find_by_post(post_id)
    sql = '
            SELECT posts.id, posts.title, tags.id AS tag_id, tags.name
            FROM tags
            JOIN posts_tags ON posts_tags.tag_id = tags.id
            JOIN posts ON posts_tags.post_id = posts.id
            WHERE posts.id = $1;
          '
      result_set = DatabaseConnection.exec_params(sql, [post_id])

      post = Post.new
      post.id = result_set.first['id']
      post.title = result_set.first['title']

      result_set.each {
        |record|
        tag = Tag.new
        tag.id = record['tag_id']
        tag.name = record['name']
        
        post.tags.push(tag)
      }

      post
  end

end