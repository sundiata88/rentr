class Listing < ActiveRecord::Base
  belongs_to :user.owner 
end
