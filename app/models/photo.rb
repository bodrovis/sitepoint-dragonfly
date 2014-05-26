# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  image_uid  :string(255)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image_size :integer
#

class Photo < ActiveRecord::Base
  dragonfly_accessor :image do
    after_assign do |img|
      img.encode!('jpg', '-quality 80') if img.image?
    end
  end

  validates :title, presence: true, length: {minimum: 2, maximum: 20}

  validates :image, presence: true
  validates_size_of :image, maximum: 500.kilobytes,
                    message: "should be no more than 500 KB", if: :image_changed?

  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
                     message: "should be either .jpeg, .jpg, .png, .bmp", if: :image_changed?
end
