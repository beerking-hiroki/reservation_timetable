class Store < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :crypted_password, presence: true, uniqueness: true
  validates :open_time, presence: true
  validates :close_time, presence: true
  
  has_many :rooms
end
