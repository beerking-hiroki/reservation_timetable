class Store < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :open_time, presence: true
  validates :close_time, presence: true
  
  has_secure_password

  has_many :rooms
end
