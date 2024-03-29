class Post < ApplicationRecord
    belongs_to :user, optional: true
    has_many :like

    validates :user, presence: {message: "存在するユーザーIDを入力してください"}
    validates :post_contents, presence:  {message: "必ず入力してください"} #必須チェック
    validates :post_contents, length: {maximum: 240, message: "240文字以下で入力してください"}  #投稿内容 : 長さチェック
    validates :post_image, length: {maximum: 240, message: "1000文字以下で入力してください"}  #画像のパス : 長さチェック

    #全件検索
    def self.user_join_all()
        Post.select('posts.*, users.name') \
        .joins(:user) \
        .order(name: :ASC) \
        .order(created_at: :DESC)
    end

    #ユーザー名検索
    def self.search_name(parameter)
        Post.select('posts.*, users.name') \
        .joins(:user) \
        .where("users.name like ?", "%#{parameter.to_s}%") \
        .order(name: :ASC) \
        .order(created_at: :DESC)
    end

    #投稿内容検索
    def self.search_post_contents(parameter)
        Post.select('posts.*, users.name') \
        .joins(:user) \
        .where("post_contents like ?", "%#{parameter.to_s}%") \
        .order(name: :ASC) \
        .order(created_at: :DESC)
    end

    def self.get_post(id)
        Post.select('posts.*, users.name') \
        .joins(:user) \
        .where("posts.id = ?", id)
    end
end
