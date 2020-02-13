module JobHelper
  def calculate_job_discount(job)
    return 0 unless job.promotion_id

    discount = 0.00
    promotion = job.promotion

    return 0 unless promotion

    if promotion
      s_t = job.services.map{|s| s.time * s.price}.inject(:+)
      discount = s_t * promotion.discount / 100
    end

    discount.round(2)
  end
end
