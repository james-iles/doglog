class Dog < ApplicationRecord
  belongs_to :household

  has_many :documents, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :chats, dependent: :destroy

  validates :name, presence: true,  length: { minimum: 2, maximum: 10 }
  validates :breed, presence: true
  validates :dob, presence: true
  validates :household_id, presence: true
end
