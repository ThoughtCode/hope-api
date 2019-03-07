module Api::V1
  class Customers::PaymentsController < ApiController
    include Serializable
    skip_before_action :disable_access_by_tk, only: [:received, :update, :add_card_mobile]

    def index
      ccs = current_user.credit_cards
      set_response(200, 'Tarjetas Listadas', serialize_payment(ccs))
    end

    def add_card
      card = current_user.credit_cards.build(payment_params)
      if card.save
        set_response(200, 'Tarjeta creada exitosamente', serialize_payment(card))
      else
        set_response(422, card.errors.messages.values.join(', '))
      end
    end

    def add_card_mobile
      Rails.logger.info(params)
      user = Customer.find_by(email: params[:payment][:email])
      card = user.credit_cards.build(payment_params)
      if card.save
        set_response(200, 'Tarjeta creada exitosamente', serialize_payment(card))
      else
        set_response(422, card.errors.messages.values.join(', '))
      end
    end

    def destroy
      cc =  CreditCard.find(params[:id])
      if cc.destroy
        set_response(200, 'Tarjeta borrada exitosamente', serialize_payment(cc))
      else
        set_response(422, cc.errors.messages.values.join(', '))
      end
    end

    def received
      Rails.logger.info(request.raw_post)
      payment = Payment.find(params[:transaction]['dev_reference'])
      payment.payment_date = params[:transaction][:paid_date]
      payment.authorization_code = params[:transaction][:authorization_code]
      payment.message = params[:transaction][:message]
      payment.carrier_code = params[:transaction][:carrier_code]
      payment.status_detail = set_status_details(params[:transaction][:status_detail])
      payment.status = set_status(params[:transaction][:status])
      payment.transaction_identifier = params[:transaction][:id]
      payment.save
      payment.check_receipt_send
      set_response(
        200, 'Pago guardado'
      )
    end

    def update
      Rails.logger.info(request.raw_post)
      set_response(
        200, 'OK'
      )
    end

    private

    def set_status(status)
      case status.to_s
      when '0'
        return 'Pending'
      when '1'
        return 'Approved'
      when '2'
        return 'Cancelled'
      when '4'
        return 'Rejected'
      else
        return 'Other'
      end
    end

    def set_status_details(status)
      case status.to_s
      when '0'
        return 'Waiting for Payment.'
      when '1'
        return 'Verification required, please see Verification section.'
      when '3'
        return 'Paid'
      when '6'
        return 'Fraud'
      when '7'
        return 'Refund'
      when '6'
        return 'Fraud'
      when '8'
        return 'Chargeback'
      when '9'
        return 'Rejected by carrier.'
      when '10'
        return 'System error'
      when '11'
        return 'Paymentez fraud'
      when '12'
        return 'Paymentez blacklist.'
      when '13'
        return 'Time tolerance.'
      when '19'
        return 'Invalid Authorization Code.'
      when '20'
        return 'Authorization code expired.'
      when '21'
        return 'Paymentez Fraud - Pending refund.'
      when '22'
        return 'Invalid AuthCode - Pending refund.'
      when '23'
        return 'AuthCode expired - Pending refund.'
      when '24'
        return 'Paymentez Fraud - Refund requested.'
      when '25'
        return 'Invalid AuthCode - Refund requested.'
      when '26'
        return 'AuthCode expired - Refund requested.'
      when '27'
        return 'Merchant - Pending refund.'
      when '28'
        return 'Merchant - Refund requested.'
      when '30'
        return 'Transaction seated (only Datafast).'
      when '31'
        return 'Waiting for OTP.'
      when '32'
        return 'OTP successfully validated.'
      when '33'
        return 'OTP not validated.'
      when '34'
        return 'Partial refund.'
      else
        return 'Other'
      end
    end

    def payment_params
      params.require(:payment)
            .permit(:holder_name, :card_type, :number, :token, :status, :expiry_month, :expiry_year)
    end
  end
end
