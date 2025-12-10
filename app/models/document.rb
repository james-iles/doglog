class Document < ApplicationRecord
  belongs_to :dog
  has_many_attached :photos

  CATEGORIES = ["Medical", "Training", "Grooming", "Nutrition", "Behavior", "Other"]

  validates :title, :content, :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
