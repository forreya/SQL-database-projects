
require_relative './post'

class PostRepository
  def all
    sql = 'SELECT id, title, content, views, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql,[])

    posts = []
    
    result_set.each{
      |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.account_id = record['account_id']
    
      posts.push(post)
    }
    posts
  end

  def find(id)
    sql = 'SELECT * FROM posts WHERE id = $1;'
    record = DatabaseConnection.exec_params(sql,[id])[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.account_id = record['account_id']

    post
  end

  def create(new_post)
    sql = 'INSERT INTO posts (title, content, views, account_id) VALUES($1,$2,$3,$4);'
    DatabaseConnection.exec_params(sql,[new_post.title, new_post.content,new_post.views,new_post.account_id])
  end

  def delete(id) 
    sql = 'DELETE FROM posts WHERE id = $1'
    DatabaseConnection.exec_params(sql,[id])
  end

  def update(new_views, id)
    sql = 'UPDATE posts SET views = $1 WHERE id = $2;'
    DatabaseConnection.exec_params(sql,[new_views, id])
  end

end