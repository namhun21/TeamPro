class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    has_many :comments
    mount_uploader :image, PostImageUploader
    paginates_per 5  #페이지에 글이 5개만 나오도록 제한을 두었다.
end
