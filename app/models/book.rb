class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  has_many :read_counts, dependent: :destroy
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
