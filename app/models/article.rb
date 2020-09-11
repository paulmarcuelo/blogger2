class Article < ApplicationRecord

    #Validate Form
    validates :title, presence: true
    validates :body, presence: true

    #Article Relationship to Active Storage for Image
    has_many_attached :images, dependent: :destroy

    #Image Sizes
    def thumbnail input
        return self.images[input].variant(resize: "300x300!").processed        
    end
end
