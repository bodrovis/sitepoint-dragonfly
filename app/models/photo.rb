class Photo < ActiveRecord::Base
  dragonfly_accessor :image do
    after_assign { |img| img.encode!('jpg', '-quality 80') }
  end

  validates :title, presence: true, length: {minimum: 2, maximum: 20}

  validates_size_of :image, maximum: 500.kilobytes,
                    message: "should be no more than 500 KB", if: :image_changed?

  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
                     message: "should be either .jpeg, .jpg, .png, .bmp", if: :image_changed?
end