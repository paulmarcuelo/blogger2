class Article < ApplicationRecord

    #Validate Form
    validates :title, presence: true
    validates :body, presence: true
    validate :image_type

    #Article Relationship to Active Storage for Image
    has_many_attached :images, dependent: :destroy

    #Article Relationship to Comments
    has_many :comments, dependent: :destroy

    #Image Sizes
    def thumbnail input
        return self.images[input].variant(resize: "300x300!").processed        
    end

    private
    #Image Validation
    def image_type
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                errors.add(:images, "needs to be JPEG or PNG")
            end
        end
    end
end
