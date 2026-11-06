class Store < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :open_time, presence: true
  validates :close_time, presence: true
  
  has_secure_password

  has_many :rooms

  def opening_hours(date)
    start_at = date.in_time_zone.change(hour: open_time.hour, min: open_time.min)
    end_at = date.in_time_zone.change(hour: close_time.hour, min: close_time.min)
    end_at += 1.day if end_at <= start_at
    start_at..end_at
  end

end
