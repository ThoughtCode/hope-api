class Api::V1::Customers::ProvidersController < Api::V1::ApiController
  skip_before_action :disable_access_by_tk
  before_action :ensure_params

  # Sign Up
  def facebook
    if user_params[:facebook_access_token]
      graph = Koala::Facebook::API.new(user_params[:facebook_access_token])
      user_data = graph.get_object('me?fields=name,first_name,last_name,email,'\
        'id,picture.type(large)')
      user = User.find_by_email(user_data['email'])
      if user
        if user.confirmed?
          user.generate_token
          @messages[:success] = 'Signed In successfully!'
          @is_success = true
          user = parse_json(user)
          @data[:user] = user
          render status: :ok
        else
          @messages[:error] = 'Please confirm your account first!'
          render status: :failure
        end
      else
        user = User.new(email: user_data['email'],
                        first_name: user_data['first_name'],
                        last_name: user_data['last_name'],
                        uid: user_data['id'],
                        provider: 'facebook',
                        password: Devise.friendly_token.first(20))
        user.authentication_token = User.generate_unique_secure_token
        if user.save
          image_url = "https://graph.facebook.com/v2.6/#{user_data['id']}/"\
          "picture'?type=large"
          image = URI.parse(image_url)
          Attachment.create!(
            parent: user,
            description: "Image of #{user_data['name']}",
            img_type: 'avatar', image: image
          )
          @messages[:success] = 'Signed Up successfully!'
          @is_success = true
          user = parse_json(user)
          @data[:user] = user
          render status: :ok
        else
          @messages[:error] = 'Something went wrong!'
          @data[:user] = { errors: user.errors }
          render status: :unprocessable_entity
        end
      end
    else
      @messages[:error] = 'Missing facebook Access Token!'
      render status: :failure
    end
  end

  private

  def user_params
    params.require(:customer).permit(:facebook_access_token)
  end

  def ensure_params
    return if params[:customer].present?
    @messages[:error] = 'Missing params!'
    render status: :bad_request
  end
end
