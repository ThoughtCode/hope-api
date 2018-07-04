class Review < ApplicationRecord
  include Hashable
  belongs_to :job
  belongs_to :owner, polymorphic: true
  after_create :complete_job

  validates_presence_of :comment, :qualification, :job
  validate :can_create

  private

  def can_create
    already_reviewed = job.reviews.find_by(owner: owner).blank?
    msg = 'ya calificado por usted'
    errors.add(:job, msg) unless already_reviewed
  end

  def complete_job
    job.completed! if job.reviews.any? && owner.class.name == 'Agent'
    job.job_recurrency if job.frequency != 'one_time' && owner.class.name == 'Agent'
    # TODO: Send email notification
  end
end
