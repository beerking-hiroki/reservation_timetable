class Slot < ApplicationRecord
  belongs_to :room

  enum :kind, { reservation: 0, walk_in: 1, block: 2 }
  enum :status, { waiting: 0, checked_in: 1, checked_out: 2 }

  validates :kind, presence: true
  validates :status, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :name, presence: true, if: :reservation?
  validates :tel, presence: true, if: :reservation?
  validates :headcount, presence: true, if: :reservation?
  validates :plan, presence: true, if: :reservation?

end
