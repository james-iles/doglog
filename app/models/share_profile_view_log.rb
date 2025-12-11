# app/models/share_profile_view_log.rb
class ShareProfileViewLog < ApplicationRecord
  belongs_to :shareable_profile

  validates :viewed_at, presence: true
end
