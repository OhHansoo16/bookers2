class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :category, presence: true
  
  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(star: :desc)}
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
