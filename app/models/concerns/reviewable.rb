# Reviewable object
#
module Reviewable
  extend ActiveSupport::Concern

  # Returns a Review row depending on a given job
  #
  def my_job_review(job)
    # TODO: Check this, because of 
    #       my_qualifications issues in sql query construction
    Review.where.not(id: job.reviews.where(owner: self).pluck(:id)).first
  end

  # Returns the review's average given to an object
  #
  def reviews_average
    reviews = my_qualifications
    return ((reviews.pluck(:qualification).sum / reviews.count) * 2.0).round / 2.0 unless reviews.count == 0
    return 0
  end

  # Returns all qualifications given to an object
  #
  def my_qualifications
    completed_jobs = jobs.completed
    my_reviews = Review.where(job_id: completed_jobs.pluck(:id))
    return Review.where(job_id: completed_jobs.pluck(:id)).each do |r| 
             r if (r.owner_id != self.id && r.owner_type != self.class.name)
           end unless completed_jobs.blank?
    return my_reviews
  end
end
