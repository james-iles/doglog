class Appointment < ApplicationRecord
  belongs_to :dog

  TYPES = [
    'Treeming', 'Veterinarian', 'Dogwalker', 'Playdate', 'Other'
    ].freeze

  validates :title, presence: true
  validates :appointment_type, presence: true, inclusion: { in: TYPES }
  validates :location, presence: true
  validates :host, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :start_time_in_future, on: :create

  scope :upcoming, -> { where('start_time >= ?', Time.current).order(:start_time) }
  scope :past, -> { where('start_time < ?', Time.current).order(start_time: :desc) }
  scope :today, -> { where(start_time: Time.current.beginning_of_day..Time.current.end_of_day) }
  scope :by_status, ->(status) { where(status: status) }

  def duration_in_minutes
    ((end_time - start_time) / 60).to_i
  end

  def past?
    start_time < Time.current
  end

  def today?
    start_time.to_date == Date.today
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def start_time_in_future
    return if start_time.blank?

    if start_time < Time.current
      errors.add(:start_time, "cannot be in the past")
    end
  end
end
