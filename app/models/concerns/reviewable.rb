# Reviewable object
#
module Reviewable
  extend ActiveSupport::Concern

  # Returns a Review row depending on a given job
  #
  def my_job_review(job)
    Review.where.not(id: job.reviews.where(owner: self).pluck(:id)).first
  end

  # Returns the review's average given to an object
  #
  def reviews_average
    reviews = my_qualifications
    ((reviews.sum(:qualification) / reviews.count) * 2.0).round / 2.0
  end

  # Returns all qualifications given to an object
  #
  def my_qualifications
    Review.where.not(id: Review.where(owner: self)
          .where(job_id: reviews.pluck(:job_id)))
  end
end
