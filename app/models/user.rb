class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post #어떤 사용자에 대해 특정글을 좋아요 눌렀는지 확인하는 메소드
  has_many :comments
  has_many :follower_relations, foreign_key: "followed_id", class_name: "Follow"
  has_many :followers, through: :follower_relations, source: :follower
  has_many :following_relations, foreign_key: "follower_id", class_name: "Follow"
  has_many :followings, through: :following_relations, source: :followed
  mount_uploader :avatar, AvatarUploader
  
  
  def is_like?(post) #특정post에 대한 정보를 넘김-> 좋아요 했는지 안했는지 확인
    Like.find_by(user_id: self.id , post_id: post.id).present?
  end
end
