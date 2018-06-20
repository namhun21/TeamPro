class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    has_many :comments
    mount_uploader :image, PostImageUploader
    paginates_per 5  #페이지에 글이 5개만 나오도록 제한을 두었다.
    validates :image, :presence=> { :message => "Please put the picture!"} #이미지를 업로드하지 않으면 글이 써지지 않도록
end
