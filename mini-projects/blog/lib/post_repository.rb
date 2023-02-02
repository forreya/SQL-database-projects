
require_relative 'post'
require_relative 'comment'

class PostRepository

  def find_with_comments(post_id)
    sql = 'SELECT
            posts.title,
            posts.id AS id,
            comments.id AS comment_id,
            comments.comment_contents
          FROM
            posts
          JOIN
            comments
          ON
            comments.post_id = posts.id
          WHERE
            posts.id = $1;
          '
    
    post_id = post_id.to_i
    result = DatabaseConnection.exec_params(sql, [post_id])

    post = Post.new

    post.id = result.first['id']
    post.title = result.first['title']

    result.each {
      |record|
      comment = Comment.new
      comment.id = record['comment_id']
      comment.comment_contents = record['comment_contents']

      post.comments.push(comment)
    }

    post
  end

end