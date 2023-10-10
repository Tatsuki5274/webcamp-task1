class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followees, class_name: "Relationship", foreign_key: "followee_id", dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # (string) => boolean
  def is_following(target_user_id)
    ret = Relationship.find_by(followee_id: target_user_id, follower_id: id) ? true : false
    return ret
  end

  # (string) => boolean
  def is_followed(target_user_id)
    ret = Relationship.find_by(followee_id: id, follower_id: target_user_id) ? true : false
    return ret
  end
end
