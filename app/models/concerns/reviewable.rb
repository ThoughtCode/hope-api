# Reviewable object
#
module Reviewable
  extend ActiveSupport::Concern

  # Returns a Review row depending on a given job
  #
  def my_job_review(job)
    # TODO: Check this, because of
    #       my_qualifications issues in sql query construction
    Review.where.not(id: job.reviews.where(owner: self).pluck(:id).compact).first
  end

  # Returns the review's average given to an object
  #
  def reviews_average
    reviews = my_qualifications
    return ((reviews.pluck(:qualification).compact.sum / reviews.count) * 2.0).round / 2.0 unless reviews.count.zero?
    0
  end

  # Returns all qualifications given to an object
  #
  def my_qualifications
    completed_jobs = jobs.completed
    my_reviews = Review.where(job_id: completed_jobs.pluck(:id))
    my_reviews
      .map { |r| r if r.owner_type != self.class.name }
      .compact
  end
end
