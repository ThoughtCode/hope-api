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
    return ((reviews.sum(:qualification) / reviews.count) * 2.0).round / 2.0 unless reviews.count == 0
    return 0
  end

  # Returns all qualifications given to an object
  #
  def my_qualifications
    completed_jobs = jobs.completed
    my_reviews = Review.where(job_id: completed_jobs.pluck(:id))
    unless completed_jobs.blank?
      Review.where(job_id: completed_jobs.pluck(:id)).each do |r| 
        r if (r.owner_id != self.id && r.owner_type != self.class.name)
      end
    end
    return my_reviews
    # Review.where(job_id: reviews.pluck(:job_id)).where.not(id: Review.where(owner: self))
  end
end
