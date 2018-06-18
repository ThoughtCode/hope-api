class Review < ApplicationRecord
  include Hashable
  belongs_to :job
  belongs_to :owner, polymorphic: true
  after_create :send_notifications

  validates_presence_of :comment, :qualification, :job
  validate :can_create

  private

  def can_create
    msg = 'aún no ha sido completado'
    errors.add(:job, msg) unless job.completed?
    already_reviewed = job.reviews.find_by(owner: owner).blank?
    msg = 'ya calificado por usted'
    errors.add(:job, msg) unless already_reviewed
  end

  def send_notifications; end
end
