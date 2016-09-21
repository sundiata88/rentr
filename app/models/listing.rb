class Listing < ActiveRecord::Base
  belongs_to :user.owner
  has_many :messages
  
end
