class Post < ActiveRecord::Base
  has_many :comments
  attr_accessible :body, :title, :topic
  belongs_to :user
  belongs_to :topic
  default_scope order('created_at DESC')
end
