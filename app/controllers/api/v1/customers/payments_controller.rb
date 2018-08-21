module Api::V1
  class Customers::PaymentsController < ApiController
    include Serializable
    skip_before_action :disable_access_by_tk, only: [:received, :update]

    def index
      ccs = current_user.credit_cards
      set_response(200, 'Tarjetas Listadas', serialize_payment(ccs))
    end

    def add_card
      card = current_user.credit_cards.build(payment_params)
      if card.save
        set_response(200, 'Tarjeta creada exitosamente', serialize_payment(card))
      else
        set_response(422, card.errors)
      end
    end

    def destroy
      cc =  CreditCard.find(params[:id])
      if cc.destroy
        set_response(200, 'Tarjeta borrada exitosamente', serialize_payment(cc))
      else
        set_response(422, cc.errors)
      end
    end


    def received
      Rails.logger.info(request.raw_post)
      set_response(
        200, 'OK'
      )
    end
    def update
      Rails.logger.info(request.raw_post)
      set_response(
        200, 'OK'
      )
    end


    private

    def payment_params
      params.require(:payment)
            .permit(:holder_name, :card_type, :number, :token, :status, :expiry_month, :expiry_year)
    end
  end
end
