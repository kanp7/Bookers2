class User < ApplicationRecord
  # 住所検索機能
  include JpPrefecture
  jp_prefecture :prefecture_code

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
            foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
            foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms

  geocoded_by :address

  after_validation :geocode

  attachment :profile_image

  validates :name, presence: true, length: { minimum: 2 , maximum: 20}
  validates :introduction, length: {maximum: 20}

  # User or Book 検索機能 search_controllerにメソッドを定義
  class << self

    def search(search,word)
      if search == "forward_match"
        @user = User.where("name LIKE?", "#{word}%")
      elsif search == "backward_match"
        @user = User.where("name LIKE?", "%#{word}")
      elsif search == "perfect_match"
        @user = User.where(name: word)
      elsif search == "partial_match"
        @user = User.where("name LIKE?", "%#{word}%")
      else
        @user = User.all
      end
    end

  end

  #ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address
    [prefecture_code, address_city, address_street].compact.join(',')
  end


end
