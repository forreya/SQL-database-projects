require_relative 'database_connection'
require_relative 'tag'
require_relative 'post'


class PostRepository
  def find_by_tag(tag_id)
    sql = '
            SELECT posts.id, posts.title, tags.id AS tag_id, tags.name
            FROM posts
            JOIN posts_tags ON posts_tags.post_id = posts.id
            JOIN tags ON posts_tags.tag_id = tags.id
            WHERE tags.id = $1;
          '
      result_set = DatabaseConnection.exec_params(sql, [tag_id])

      tag = Tag.new
      tag.id = result_set.first['tag_id']
      tag.name = result_set.first['name']

      result_set.each {
        |record|
        post = Post.new
        post.id = record['id']
        post.title = record['title']
        
        tag.posts.push(post)
      }

      tag
  end

end