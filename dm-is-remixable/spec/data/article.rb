require Pathname(__FILE__).dirname / "image"
require Pathname(__FILE__).dirname / "commentable"
require Pathname(__FILE__).dirname / "viewable"
require Pathname(__FILE__).dirname / "user"

class Article
  include DataMapper::Resource

  property :id, Integer, :key => true, :serial => true
  property :title, String
  property :url, String


  remix 1, :images, :as => "pics"

  remix n, :viewables, :as => "views"

  remix n, :commentables, :as => "comments", :for => "User"
  
  remix n, "My::Nested::Remixable::Rating", :as => :ratings

  enhance :viewables do
    belongs_to :user
  end

  def viewed_by(usr)
    art_view = ArticleView.new
    art_view.ip = "127.0.0.1"
    art_view.user_id = usr.id

    self.views << art_view
  end

end
