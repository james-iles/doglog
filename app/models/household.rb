class Household < ApplicationRecord
  has_many :dogs, dependent: :destroy
  has_many :users, dependent: :destroy
end
