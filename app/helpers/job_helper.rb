module JobHelper
  def calculate_job_discount(job)
    return 0 unless job.promotion_id

    discount = 0.00
    promotion = job.promotion

    return 0 unless promotion

    if promotion
      service = job.services.find(promotion.service_id)
      total_service = service.time * service.price
      discount = total_service * promotion.discount / 100
    end

    discount.round(2)
  end
end
