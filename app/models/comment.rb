class Comment < ApplicationRecord
  belongs_to :reported_incident
  
  validates :content, presence: true
end
