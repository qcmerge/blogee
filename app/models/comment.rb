class Comment < ActiveRecord::Base
  validates :content, length: { minimum: 15, message: "Content must be at least 15 characters long." }
  validates :content, :author, presence: true

  belongs_to :post
end
