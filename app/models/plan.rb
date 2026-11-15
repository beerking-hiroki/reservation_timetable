class Plan < ApplicationRecord
  belongs_to :store

  validates :name, presence: true
  validate :duration_or_time_range

  private

  def duration_or_time_range
    if duration_minutes? == (start_time? && end_time?)
      errors.add(:base, "エラーメッセージ")
    end
  end
end
