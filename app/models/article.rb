class Article < ApplicationRecord

    #Validate Form
    validates :title, presence: true
    validates :body, presence: true
    validate :image_type

    #Article Relationship to Active Storage for Image
    has_many_attached :images, dependent: :destroy

    #Article Relationship to Comments
    has_many :comments, dependent: :destroy

    #Article To Taggings
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    #Join tags from Database into string
    def tag_list
        self.tags.collect do |tag|
          tag.name
        end.join(", ")
    end

    #Inputted tags from form separation and save to database 
    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
        self.tags = new_or_found_tags
    end

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
