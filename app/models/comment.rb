class Comment < ApplicationRecord
  #Comment Relationship to Article
  belongs_to :article
  
end
