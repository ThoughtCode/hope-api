module Api::V1::Customers
  class ProvidersController < CustomerUsersController
    include Serializable
    skip_before_action :disable_access_by_tk
    before_action :ensure_params
    before_action :prepare_data, only: :facebook

    # Sign Up
    def facebook
      customer = Customer.find_by_email(@data[:email])
      if customer
        customer.acquire_access_token!
        set_response(200, 'Inicio de sesión exitoso',
                     serialize_customer(customer))
        customer.save
      else
        customer = Customer.new(@data)
        customer.remote_avatar_url = @data[:avatar]['url']
        if customer.save
          customer.acquire_access_token!
          set_response(200, 'Ahora es un usuario registrado!',
                       serialize_customer(customer))
          customer.save
        else
          set_response(422,
                       customer.errors)
          return
        end
      end
    end

    private

    def user_params
      params.require(:customer).permit(:facebook_access_token)
    end

    def ensure_params
      if params[:customer].present?
        return if params[:customer][:facebook_access_token].present?
      end
      set_response(400, 'Missing facebook Access Token!')
    end

    def prepare_data
      graph = Koala::Facebook::API.new(user_params[:facebook_access_token])
      user_data = graph.get_object('me?fields=name,first_name,last_name,'\
                                   'email,id,birthday,picture.type(large)')
      @data = {
        email: user_data['email'],
        first_name: user_data['first_name'],
        last_name: user_data['last_name'],
        uid: user_data['id'],
        avatar: user_data['picture']['data']['url'],
        provider: 'facebook',
        password: Devise.friendly_token.first(20),
        birthday: user_data['birthday']
      }
    end
  end
end
