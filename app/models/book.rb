class Book < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
