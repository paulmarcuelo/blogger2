class Tag < ApplicationRecord
    #Tag to Taggings
    has_many :taggings, dependent: :destroy
    has_many :articles, through: :taggings
end
