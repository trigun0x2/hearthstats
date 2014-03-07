class Coach < ActiveRecord::Base
  attr_accessible :user_id, :description, :active, :available
  belongs_to :user
end
