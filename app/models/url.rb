class Url < ApplicationRecord
  belongs_to :user

  validates :destination, presence: true, uniqueness: true
  validates :short_link, uniqueness: true
end
