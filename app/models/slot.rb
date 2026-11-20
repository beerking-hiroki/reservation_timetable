class Slot < ApplicationRecord
  belongs_to :room
  belongs_to :plan, optional: true

  enum :kind, { reservation: 0, walk_in: 1, block: 2 }
  enum :status, { waiting: 0, checked_in: 1, checked_out: 2 }

  validates :kind, presence: true
  validates :status, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :name, presence: true, if: :reservation?
  validates :tel, presence: true, if: :reservation?
  validates :headcount, presence: true, if: :reservation?
  validates :plan_id, presence: true, if: :reservation?
  validate :start_within_plan_time

  private
  def start_within_plan_time
    return unless plan && plan.start_time? && plan.end_time?
    slot_start = start_at.seconds_since_midnight
    plan_start = plan.start_time.seconds_since_midnight
    plan_end = plan.end_time.seconds_since_midnight
    if slot_start < plan_start || plan_end <= slot_start
      errors.add(:base, "開始時間はプランの時間帯の中にしてください")
    end
  end
end
