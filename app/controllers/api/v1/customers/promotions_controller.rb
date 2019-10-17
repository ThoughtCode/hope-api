module Api::V1::Customers
  class PromotionsController < CustomerUsersController
    skip_before_action :disable_access_by_tk, only: [:index, :show]
    before_action :set_promotion, only: %i[show]

    def show
      if @promotion
        set_response(
          200,
          'Promoción ha sido encontrada',
          @promotion.serialize!
        )
      else
        set_response(
          404,
          'Promoción no encontrada'
        )
      end
    end

    private

    def set_promotion
      @promotion = Promotion.eager_load(:service).available.find_by(promo_code: params[:promo_code])
    end
  end
end
