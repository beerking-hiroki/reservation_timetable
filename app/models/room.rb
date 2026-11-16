class Room < ApplicationRecord
  belongs_to :store

  validates :name, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  
  has_many :slots, dependent: :destroy
end
