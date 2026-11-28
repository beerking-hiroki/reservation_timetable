class Plan < ApplicationRecord
  belongs_to :store
  has_many :slots

  validates :name, presence: true
  validate :duration_or_time_range
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  private

  def duration_or_time_range
    if duration_minutes? == (start_time? && end_time?) || (start_time? != end_time?)
      errors.add(:base, "長さか時間帯の、どちらか一方だけを入力してください")
    end
  end
end
