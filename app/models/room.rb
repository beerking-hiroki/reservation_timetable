class Room < ApplicationRecord
  belongs_to :store
  has_many :slots, dependent: :destroy

  validates :name, presence: true
  validates :min_capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :max_capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: :min_capacity, if: :min_capacity? }
end
