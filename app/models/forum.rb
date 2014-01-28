class Forum < ActiveRecord::Base
  attr_accessible :name, :description, :forum_id
  has_many :topics, dependent: :destroy
end
