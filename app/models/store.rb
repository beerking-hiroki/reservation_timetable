class Store < ApplicationRecord
  has_many :rooms
  has_many :slots, through: :rooms
  has_many :plans

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :open_time, presence: true
  validates :close_time, presence: true

  def opening_hours(date)
    start_at = date.in_time_zone.change(hour: open_time.hour, min: open_time.min)
    end_at = date.in_time_zone.change(hour: close_time.hour, min: close_time.min)
    end_at += 1.day if end_at <= start_at
    start_at..end_at
  end

  def timeline_range(date)
    range = opening_hours(date)
    (range.begin - 1.hour)..(range.end + 1.hour)
  end
end
